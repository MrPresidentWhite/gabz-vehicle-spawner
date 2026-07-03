local function hasPermission(source)
    if not Config.RequirePermission then
        return true
    end

    return IsPlayerAceAllowed(source, Config.AcePermission)
end

RegisterNetEvent('gabzvehicles:requestOpen', function()
    local source = source

    if not hasPermission(source) then
        TriggerClientEvent('gabzvehicles:notify', source, L('notifications.no_permission_menu'), 'error')
        return
    end

    TriggerClientEvent('gabzvehicles:openMenu', source)
end)

RegisterNetEvent('gabzvehicles:spawnVehicle', function(model)
    local source = source

    if type(model) ~= 'string' or model == '' then
        return
    end

    if not hasPermission(source) then
        TriggerClientEvent('gabzvehicles:notify', source, L('notifications.no_permission_spawn'), 'error')
        return
    end

    local isValid = false
    for i = 1, #Config.Vehicles do
        if Config.Vehicles[i].model == model then
            isValid = true
            break
        end
    end

    if not isValid then
        TriggerClientEvent('gabzvehicles:notify', source, L('notifications.invalid_spawn_code'), 'error')
        return
    end

    TriggerClientEvent('gabzvehicles:doSpawn', source, model)
end)