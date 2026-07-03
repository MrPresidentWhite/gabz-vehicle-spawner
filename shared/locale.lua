Locale = {
    Data = {},
    Current = 'en',
}

local function getNestedValue(data, key)
    local value = data

    for part in string.gmatch(key, '[^.]+') do
        if type(value) ~= 'table' then
            return nil
        end

        value = value[part]
    end

    return value
end

function Locale.Load(lang)
    local resourceName = GetCurrentResourceName()
    local localeFile = LoadResourceFile(resourceName, ('locales/%s.json'):format(lang))

    if not localeFile then
        print(('[gabz-vehicle-spawner] Locale "%s" not found, falling back to "en"'):format(lang))
        lang = 'en'
        localeFile = LoadResourceFile(resourceName, 'locales/en.json')
    end

    if not localeFile then
        print('[gabz-vehicle-spawner] Failed to load locale files')
        Locale.Data = {}
        return
    end

    Locale.Data = json.decode(localeFile) or {}
    Locale.Current = lang
end

function Locale.Get(key, ...)
    local value = getNestedValue(Locale.Data, key)

    if type(value) ~= 'string' then
        return key
    end

    if select('#', ...) > 0 then
        return string.format(value, ...)
    end

    return value
end

function Locale.GetCategory(categoryKey)
    local categories = Locale.Data.categories

    if type(categories) == 'table' and categories[categoryKey] then
        return categories[categoryKey]
    end

    return categoryKey
end

function Locale.GetUiStrings()
    return Locale.Data.ui or {}
end

function Locale.GetCategoryLabels()
    return Locale.Data.categories or {}
end

function L(key, ...)
    return Locale.Get(key, ...)
end

Locale.Load(Config.Locale or 'en')