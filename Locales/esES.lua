local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")

if not L then
    return
end

L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon cargado"
L["COMMON.SAVE"] = "Guardar"
L["COMMON.CANCEL"] = "Cancelar"
L["COMMON.FILTER"] = "Filtrar"
L["COMMON.SELECT_EXPANSION"] = "Seleccionar expansión"
L["COMMON.ALL_EXPANSION"] = "Todas las expansiones"
L["COMMON.CLEAR_FILTER"] = "Limpiar Filtro"

L["SETTINGS.TITLE"] = "Ajustes"
L["SETTINGS.RESET_TO_DEFAULT"] = "Restablecer por defecto"
L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Activar información de expansión"
L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Mostrar expansión en el tooltip de objetos"
L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Mostrar la expansión de origen en el tooltip del objeto."
L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Filtro de expansión en bancos"
L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Activar la funcionalidad de filtrado por expansión."

L["TOOLTIP.EXPANSION"] = "Expansión:"
L["TOOLTIP.ORIGIN"] = "Origen:"
L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión"
L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión (banco de hermandad)"
L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Haz clic para elegir expansión"

L["BANKFILTER.SELECT_EXPANSION"] = "Seleccionar Expansión"
L["BANKFILTER.ALL_EXPANSIONS"] = "Todas las Expansiones"
L["BANKFILTER.FILTER_APPLIED"] = "Filtro aplicado a %s objetos"
L["BANKFILTER.FILTER_CLEARED"] = "Filtro eliminado"
