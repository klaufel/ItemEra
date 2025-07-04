local addonName, addon = ...

-- Solo cargar las traducciones en español si el cliente está en español
local function LoadSpanishLocale()
    local locale = GetLocale()
    if locale == "esES" or locale == "ruRU" then
        -- Asegurar que addon.L existe
        addon.L = addon.L or {}
        if not getmetatable(addon.L) then
            setmetatable(addon.L, { __index = function(t, k) return k end })
        end
        local L = addon.L
--Translator ZamestoTV
        -- COMMON
L["COMMON.ADDON_LOADED"] = "[ItemEra]: Аддон загружен"
L["COMMON.SAVE"] = "Сохранить"
L["COMMON.CANCEL"] = "Отмена"
L["COMMON.FILTER"] = "Фильтр"
L["COMMON.SELECT_EXPANSION"] = "Выберите дополнение"
L["COMMON.ALL_EXPANSION"] = "Все дополнения"
L["COMMON.CLEAR_FILTER"] = "Очистить фильтр"

-- SETTINGS
L["SETTINGS.TITLE"] = "Настройки"
L["SETTINGS.RESET_TO_DEFAULT"] = "Сбросить на значения по умолчанию"
-- SETTINGS.EXPANSION_TOOLTIP
L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Включить информацию о дополнении"
L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Показывать дополнение в подсказке предмета"
L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Показывать дополнение происхождения в подсказке предмета."
-- SETTINGS.EXPANSION_FILTER
L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Показывать фильтр дополнений"
L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Включить функцию фильтрации по дополнениям."

-- UI
-- TOOLTIP
L["TOOLTIP.EXPANSION"] = "Дополнение:"
L["TOOLTIP.ORIGIN"] = "Происхождение:"
-- FILTER
L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Фильтровать предметы по дополнению"
L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Фильтровать предметы по дополнению (гильдейский банк)"
L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Нажмите, чтобы выбрать дополнение"
