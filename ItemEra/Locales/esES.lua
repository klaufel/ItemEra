local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Seleccionar expansión"
L["ALL_EXPANSION"] = "Todas las expansiones"
L["EXPANSION"] = "Expansión:"

--- Settings
L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Visualización de la expansión"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "\n\nConfigura las opciones de visualización de ItemEra.\n\n"

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Mostrar literal 'Expansión'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Muestra el literal 'Expansión' antes del nombre y logo en los tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Mostrar nombre de expansión"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Muestra el nombre de la expansión junto al icono en los tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Mostrar logo de expansión"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Muestra el logo de la expansión junto al icono en los tooltips"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(No se mostrará el tooltip)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Vista previa del tooltip:"


L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Tecla modificadora"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Usar tecla modificadora"
L['SETTINGS_USE_KEY_MODIFIER_DESC'] =
"Solo muestra la información de expansión cuando se mantiene presionada una tecla modificadora."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Tecla modificadora"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Selecciona la tecla modificadora que se utilizará para mostrar la información de expansión."
