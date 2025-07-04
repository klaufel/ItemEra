local addonName, addon = ...
local locale = GetLocale()

if locale == "esES" or locale == "esMX" then
    addon.L = addon.L or {}
    local L = addon.L

    -- COMMON
    L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon cargado"
    L["COMMON.SAVE"] = "Guardar"
    L["COMMON.CANCEL"] = "Cancelar"
    L["COMMON.FILTER"] = "Filtrar"
    L["COMMON.SELECT_EXPANSION"] = "Seleccionar expansión"
    L["COMMON.ALL_EXPANSION"] = "Todas las expansiones"
    L["COMMON.CLEAR_FILTER"] = "Limpiar Filtro"

    -- SETTINGS
    L["SETTINGS.TITLE"] = "Ajustes"
    L["SETTINGS.RESET_TO_DEFAULT"] = "Restablecer por defecto"
    -- SETTINGS.EXPANSION_TOOLTIP
    L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Activar información de expansión"
    L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Mostrar expansión en el tooltip de objetos"
    L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Mostrar la expansión de origen en el tooltip del objeto."
    -- SETTINGS.EXPANSION_FILTER
    L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Filtro de expansión en bancos"
    L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Activar la funcionalidad de filtrado por expansión."

    -- UI
    -- TOOLTIP
    L["TOOLTIP.EXPANSION"] = "Expansión:"
    L["TOOLTIP.ORIGIN"] = "Origen:"
    L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión"
    L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión (banco de hermandad)"
    L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Haz clic para elegir expansión"
end
