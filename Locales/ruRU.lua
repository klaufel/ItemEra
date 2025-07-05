local addonName, addon = ...
local locale = GetLocale()

if locale == "ruRU" then
    addon.L = addon.L or {}
    local L = addon.L
    -- Translator ZamestoTV
    -- COMMON
    L["COMMON.ADDON_LOADED"] = "[ItemEra]: Аддон загружен"
    L["COMMON.SAVE"] = "Сохранить"
    L["COMMON.CANCEL"] = "Отмена"
    L["COMMON.FILTER"] = "Фильтр"
    L["COMMON.SELECT_EXPANSION"] = "Выберите дополнение"
    L["COMMON.ALL_EXPANSION"] = "Bce дополнения"
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
    L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Фильтровать предметы по дополнению"
    L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Фильтровать предметы по дополнению (гильдейский банк)"
    L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Нажмите, чтобы выбрать дополнение"

    -- Bank Filter
    L["BANKFILTER.SELECT_EXPANSION"] = "Выбрать дополнение"
    L["BANKFILTER.ALL_EXPANSIONS"] = "Все дополнения"
    L["BANKFILTER.FILTER_APPLIED"] = "Фильтр применен к %s предметам"
    L["BANKFILTER.FILTER_CLEARED"] = "Фильтр очищен"
end
