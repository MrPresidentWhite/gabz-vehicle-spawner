local menuOpen = false
local lastVehicle = nil

local function notify(message, notifyType)
    notifyType = notifyType or 'info'

    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, true)
end

local function buildMenuData()
    local categories = {}
    local categoryIndex = {}

    for _, categoryName in ipairs(Config.CategoryOrder) do
        categoryIndex[categoryName] = #categories + 1
        categories[#categories + 1] = {
            key = categoryName,
            name = Locale.GetCategory(categoryName),
            vehicles = {},
        }
    end

    for _, vehicle in ipairs(Config.Vehicles) do
        local index = categoryIndex[vehicle.category]

        if not index then
            categories[#categories + 1] = {
                key = vehicle.category,
                name = Locale.GetCategory(vehicle.category),
                vehicles = {},
            }
            index = #categories
            categoryIndex[vehicle.category] = index
        end

        categories[index].vehicles[#categories[index].vehicles + 1] = {
            model = vehicle.model,
            brand = vehicle.brand,
            name = vehicle.name,
            category = vehicle.category,
            categoryLabel = Locale.GetCategory(vehicle.category),
        }
    end

    return categories
end

local function setMenuState(state)
    menuOpen = state
    SetNuiFocus(state, state)
    SetNuiFocusKeepInput(false)

    if state then
        SendNUIMessage({
            action = 'open',
            categories = buildMenuData(),
            locale = Locale.Data,
            lang = Locale.Current,
            settings = {
                deletePrevious = Config.DeletePreviousVehicle,
                warpIntoVehicle = Config.WarpIntoVehicle,
                maxUpgrade = Config.MaxUpgrade,
            },
        })
    else
        SendNUIMessage({ action = 'close' })
    end
end

local function openMenu()
    if menuOpen then
        return
    end

    TriggerServerEvent('gabzvehicles:requestOpen')
end

local function closeMenu()
    if not menuOpen then
        return
    end

    setMenuState(false)
end

local function getSpawnCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local forward = GetEntityForwardVector(ped)

    return vector3(
        coords.x + forward.x * Config.SpawnDistance,
        coords.y + forward.y * Config.SpawnDistance,
        coords.z
    ), heading
end

local function ensureEntityControl(entity)
    if not DoesEntityExist(entity) then
        return false
    end

    if NetworkGetEntityIsNetworked(entity) then
        local timeout = GetGameTimer() + 3000

        while not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)

            if GetGameTimer() > timeout then
                return false
            end

            Wait(0)
        end
    end

    return true
end

local function ejectPedFromVehicle(ped, vehicle)
    if not IsPedInVehicle(ped, vehicle, false) then
        return
    end

    TaskLeaveVehicle(ped, vehicle, 16)

    local timeout = GetGameTimer() + 2000
    while IsPedInVehicle(ped, vehicle, false) and GetGameTimer() < timeout do
        Wait(0)
    end

    if IsPedInVehicle(ped, vehicle, false) then
        local coords = GetOffsetFromEntityInWorldCoords(vehicle, -2.5, 0.0, 0.5)
        SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
    end
end

local function deleteVehicleEntity(vehicle)
    if not vehicle or vehicle == 0 or not DoesEntityExist(vehicle) then
        return false
    end

    local ped = PlayerPedId()
    ejectPedFromVehicle(ped, vehicle)
    ensureEntityControl(vehicle)

    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, false)
    SetVehicleAsNoLongerNeeded(vehicle)
    DeleteVehicle(vehicle)

    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end

    return not DoesEntityExist(vehicle)
end

local function deletePreviousVehicle()
    if not Config.DeletePreviousVehicle then
        return
    end

    local ped = PlayerPedId()
    local vehiclesToDelete = {}
    local seen = {}

    local function queueVehicle(vehicle)
        if vehicle and vehicle ~= 0 and not seen[vehicle] then
            seen[vehicle] = true
            vehiclesToDelete[#vehiclesToDelete + 1] = vehicle
        end
    end

    queueVehicle(GetVehiclePedIsIn(ped, false))
    queueVehicle(lastVehicle)

    for i = 1, #vehiclesToDelete do
        deleteVehicleEntity(vehiclesToDelete[i])
    end

    lastVehicle = nil
    Wait(0)
end

local function applyMaxUpgrades(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)

    for modType = 0, 49 do
        local modCount = GetNumVehicleMods(vehicle, modType)
        if modCount > 0 then
            SetVehicleMod(vehicle, modType, modCount - 1, false)
        end
    end

    ToggleVehicleMod(vehicle, 18, true)
    ToggleVehicleMod(vehicle, 20, true)
    ToggleVehicleMod(vehicle, 22, true)

    if GetVehicleLiveryCount(vehicle) > 0 then
        SetVehicleLivery(vehicle, 0)
    end
end

local function spawnVehicle(modelName)
    local model = joaat(modelName)

    if not IsModelInCdimage(model) or not IsModelAVehicle(model) then
        notify(L('notifications.model_not_found', modelName), 'error')
        return
    end

    RequestModel(model)

    local timeout = GetGameTimer() + 10000
    while not HasModelLoaded(model) do
        if GetGameTimer() > timeout then
            notify(L('notifications.model_load_failed', modelName), 'error')
            return
        end
        Wait(0)
    end

    local ped = PlayerPedId()

    deletePreviousVehicle()

    local spawnCoords, heading = getSpawnCoords()
    local vehicle = CreateVehicle(model, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)

    if vehicle == 0 then
        notify(L('notifications.spawn_failed'), 'error')
        SetModelAsNoLongerNeeded(model)
        return
    end

    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    SetVehicleNumberPlateText(vehicle, 'GABZ')

    if Config.MaxUpgrade then
        applyMaxUpgrades(vehicle)
    end

    if Config.WarpIntoVehicle then
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
    end

    lastVehicle = vehicle
    SetModelAsNoLongerNeeded(model)

    local displayName = modelName
    for i = 1, #Config.Vehicles do
        if Config.Vehicles[i].model == modelName then
            displayName = Config.Vehicles[i].name
            break
        end
    end

    notify(L('notifications.vehicle_spawned', displayName), 'success')
end

RegisterNetEvent('gabzvehicles:openMenu', function()
    setMenuState(true)
end)

RegisterNetEvent('gabzvehicles:notify', function(message, notifyType)
    notify(message, notifyType)
end)

RegisterNetEvent('gabzvehicles:doSpawn', function(model)
    closeMenu()
    spawnVehicle(model)
end)

RegisterNUICallback('close', function(_, cb)
    closeMenu()
    cb('ok')
end)

RegisterNUICallback('spawn', function(data, cb)
    if not data or not data.model then
        cb('error')
        return
    end

    TriggerServerEvent('gabzvehicles:spawnVehicle', data.model)
    cb('ok')
end)

RegisterCommand(Config.Command, function()
    openMenu()
end, false)

RegisterKeyMapping(Config.Command, L('keymapping.open_menu'), 'keyboard', Config.OpenKey)

CreateThread(function()
    while true do
        if menuOpen then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 106, true)
            Wait(0)
        else
            Wait(500)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    closeMenu()
end)