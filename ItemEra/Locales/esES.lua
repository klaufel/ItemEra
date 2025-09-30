local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Seleccionar expansión"
L["ALL_EXPANSION"] = "Todas las expansiones"
L["EXPANSION"] = "Expansión:"

--- Settings
L["SETTINGS_NAME"] = "ItemEra"
L["SETTINGS_DESC"] = "Configuración de ItemEra"
L["SETTINGS_HEADER_NAME"] = "ItemEra - Filter Expansion Items"
L["SETTINGS_DESCRIPTION_NAME"] = "\n\nConfigura las opciones de visualización de ItemEra.\n\n"

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Mostrar literal 'Expansión'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Muestra el literal 'Expansión' antes del nombre y logo en los tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Mostrar nombre de expansión"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Muestra el nombre de la expansión junto al icono en los tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Mostrar logo de expansión"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Muestra el logo de la expansión junto al icono en los tooltips"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(No se mostrará el tooltip)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Vista previa del tooltip:"
