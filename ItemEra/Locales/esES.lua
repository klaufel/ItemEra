local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Seleccionar expansión"
L["ALL_EXPANSION"] = "Todas las expansiones"
L["EXPANSION"] = "Expansión:"
L["PROFESSION"] = "Profesión:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Filtra y muestra información de la expansión de tus objetos."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Tooltip"
L["SETTINGS_SUBPAGE_FILTERS"] = "Filtros"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Visualización de la expansión"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configura las opciones de visualización de ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Literal 'Expansión'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Muestra el literal 'Expansión' antes del nombre y logo en los tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Nombre de expansión"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Muestra el nombre de la expansión junto al icono en los tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Logo de expansión"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Muestra el logo de la expansión junto al icono en los tooltips"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "Visualización de profesión"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "Configura las opciones de visualización de profesión para reagentes de fabricación."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "Literal 'Profesión'"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "Muestra el literal 'Profesión' antes del nombre e icono en los tooltips"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "Nombre de profesión"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "Muestra el nombre de la profesión en los tooltips"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "Icono de profesión"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "Muestra el icono de la profesión en los tooltips"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(No se mostrará el tooltip)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Vista previa del tooltip:"


L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Tecla modificadora"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Usar tecla modificadora"
L['SETTINGS_USE_KEY_MODIFIER_DESC'] =
"Solo muestra la información de expansión cuando se mantiene presionada una tecla modificadora."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Tecla modificadora"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Selecciona la tecla modificadora que se utilizará para mostrar la información de expansión."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Filtros de expansión"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] =
"Habilita o deshabilita los filtros de expansión en diferentes ventanas del juego."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Inventario"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Habilita los filtros de expansión en las bolsas del inventario"

L["SETTINGS_FILTERS_BANK_NAME"] = "Banco personal"
L["SETTINGS_FILTERS_BANK_DESC"] = "Habilita los filtros de expansión en el banco personal"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Banco de Hermandad"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Habilita los filtros de expansión en el banco de la hermandad"

L["SETTINGS_RELOAD_REQUIRED"] = "Los cambios en los filtros requieren reiniciar la interfaz (/reload) para aplicarse."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "Los cambios en los filtros requieren reiniciar la interfaz para aplicarse."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Reiniciar ahora"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Más tarde"
L["SETTINGS_RESET_NAME"] = "Ajustes predeterminados"
L["SETTINGS_RESET_DESC"] = "Restablece todas las configuraciones a sus valores predeterminados"

L["SETTINGS_DISCORD_NAME"] = "Únete al Discord"
L["SETTINGS_DISCORD_DESC"] = "Únete a nuestra comunidad de Discord para soporte y actualizaciones"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Copia este enlace para unirte a nuestro Discord:"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Decoraciones de objetos"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Muestra iconos de expansión en los objetos del inventario."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Habilitar decoraciones de objetos"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] =
"Muestra un pequeño icono de expansión en cada objeto de tus bolsas. Pasa el ratón sobre el icono para ver el nombre de la expansión."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Integración con Baganator"
L["SETTINGS_BAGANATOR_DETECTED"] = "¡Baganator detectado!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator no detectado."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] =
"ItemEra añadirá iconos de expansión en las esquinas de los objetos en Baganator. Los filtros nativos se desactivan cuando Baganator está activo."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] = "Instala Baganator para usar la integración de categorías por expansión."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Habilitar integración con Baganator"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Muestra iconos de expansión en los objetos cuando usas Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Integración con Bagnon"
L["SETTINGS_BAGNON_DETECTED"] = "¡Bagnon detectado!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon no detectado."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] =
"ItemEra añadirá filtros de expansión a Bagnon. Los filtros nativos se desactivan cuando Bagnon está activo."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Instala Bagnon para usar la integración de filtros por expansión."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Habilitar integración con Bagnon"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Muestra el selector de filtro por expansión cuando usas Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Avanzado"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "Sobrescritura de API"
L["SETTINGS_API_HOOK_DESCRIPTION"] =
"Sobrescribe la función C_Item.GetItemInfo del juego para que TODOS los addons reciban los IDs de expansión corregidos de ItemEra en lugar de los valores predeterminados del juego."
L["SETTINGS_API_HOOK_WARNING"] =
"Advertencia: Esta es una función experimental que modifica una función central del juego. Puede causar problemas de compatibilidad con otros addons. Úsalo bajo tu propio riesgo."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Habilitar sobrescritura de API"
L["SETTINGS_API_HOOK_ENABLED_DESC"] =
"Reemplaza C_Item.GetItemInfo para devolver los IDs de expansión de ItemEra globalmente"
