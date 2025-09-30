local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "itIT")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Seleziona espansione"
L["ALL_EXPANSION"] = "Tutte le espansioni"
L["EXPANSION"] = "Espansione:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Visualizzazione espansione"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configura le opzioni di visualizzazione di ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Mostra letterale 'Espansione'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Mostra il letterale 'Espansione' prima del nome e logo nei tooltip"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Mostra nome espansione"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Mostra il nome dell'espansione accanto all'icona nei tooltip"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Mostra logo espansione"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Mostra il logo dell'espansione accanto all'icona nei tooltip"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(Il tooltip non verrà mostrato)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Anteprima tooltip:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Tasto modificatore"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Usa tasto modificatore"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] =
"Mostra le informazioni dell'espansione solo quando un tasto modificatore è tenuto premuto."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Tasto modificatore"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Seleziona il tasto modificatore che verrà utilizzato per mostrare le informazioni dell'espansione."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Filtri espansione"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "Abilita o disabilita i filtri dell'espansione in diverse finestre del gioco."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Inventario"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Abilita i filtri dell'espansione nelle borse dell'inventario"

L["SETTINGS_FILTERS_BANK_NAME"] = "Banca personale"
L["SETTINGS_FILTERS_BANK_DESC"] = "Abilita i filtri dell'espansione nella banca personale"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Banca della gilda"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Abilita i filtri dell'espansione nella banca della gilda"

L["SETTINGS_RELOAD_REQUIRED"] =
"Le modifiche ai filtri richiedono il ricaricamento dell'interfaccia (/reload) per essere applicate."
L["SETTINGS_RELOAD_POPUP_TEXT"] =
"Le modifiche ai filtri richiedono il ricaricamento dell'interfaccia per essere applicate."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Ricarica ora"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Più tardi"
L["SETTINGS_RESET_NAME"] = "Ripristina impostazioni"
L["SETTINGS_RESET_DESC"] = "Ripristina tutte le impostazioni ai loro valori predefiniti"
