local addonName, addon = ...

-- Inicializar el sistema de localización si no existe
addon.L = addon.L or {}
-- Agregar metatable para fallback si no se encuentra una traducción
setmetatable(addon.L, { __index = function(t, k) return k end })
local L = addon.L

-- Cargar traducciones en inglés por defecto (fallback)
-- COMMON
L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon loaded"
L["COMMON.SAVE"] = "Save"
L["COMMON.CANCEL"] = "Cancel"
L["COMMON.FILTER"] = "Filter"
L["COMMON.SELECT_EXPANSION"] = "Select expansion"
L["COMMON.ALL_EXPANSION"] = "All expansions"
L["COMMON.CLEAR_FILTER"] = "Clear Filter"

-- SETTINGS
L["SETTINGS.TITLE"] = "Settings"
L["SETTINGS.RESET_TO_DEFAULT"] = "Reset to default"
-- SETTINGS.EXPANSION_TOOLTIP
L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Enable expansion information"
L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Show expansion in item tooltip"
L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Show the origin expansion in the item tooltip."
-- SETTINGS.EXPANSION_FILTER
L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Show expansion filter"
L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Enable expansion filtering functionality."


-- UI
-- TOOLTIP
L["TOOLTIP.EXPANSION"] = "Expansion:"
L["TOOLTIP.ORIGIN"] = "Origin:"
-- FILTER
L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filter items by expansion"
L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filter items by expansion (guild bank)"
L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Click to choose expansion"
