local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "itIT")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Seleziona espansione"
L["ALL_EXPANSION"] = "Tutte le espansioni"
L["EXPANSION"] = "Espansione:"
L["PROFESSION"] = "Professione:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Filtra e visualizza le informazioni dell'espansione per i tuoi oggetti."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Tooltip"
L["SETTINGS_SUBPAGE_FILTERS"] = "Filtri"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Visualizzazione espansione"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configura le opzioni di visualizzazione di ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Letterale 'Espansione'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Mostra il letterale 'Espansione' prima del nome e logo nei tooltip"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Nome espansione"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Mostra il nome dell'espansione accanto all'icona nei tooltip"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Logo espansione"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Mostra il logo dell'espansione accanto all'icona nei tooltip"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "Visualizzazione professione"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "Configura le opzioni di visualizzazione della professione per i reagenti di creazione."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "Letterale 'Professione'"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "Mostra il letterale 'Professione' prima del nome e icona nei tooltip"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "Nome professione"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "Mostra il nome della professione nei tooltip"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "Icona professione"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "Mostra l'icona della professione nei tooltip"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "A capo testo professione"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "Manda a capo il testo della professione su più righe quando è troppo lungo"

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

L["SETTINGS_DISCORD_NAME"] = "Unisciti a Discord"
L["SETTINGS_DISCORD_DESC"] = "Unisciti alla nostra comunità Discord per supporto e aggiornamenti"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Copia questo link per unirti al nostro Discord:"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Decorazioni oggetti"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Mostra le icone dell'espansione sugli oggetti nel tuo inventario."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Abilita decorazioni oggetti"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] =
"Mostra una piccola icona dell'espansione su ogni oggetto nelle tue borse. Passa il mouse sull'icona per vedere il nome dell'espansione."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Integrazione Baganator"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator rilevato!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator non rilevato."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] =
"ItemEra aggiungerà icone dell'espansione agli angoli degli oggetti in Baganator. I filtri nativi sono disabilitati quando Baganator è attivo."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] =
"Installa Baganator per utilizzare l'integrazione delle categorie per espansione."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Abilita integrazione Baganator"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Mostra le icone dell'espansione sugli oggetti quando usi Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Integrazione Bagnon"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon rilevato!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon non rilevato."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] =
"ItemEra aggiungerà filtri dell'espansione a Bagnon. I filtri nativi sono disabilitati quando Bagnon è attivo."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Installa Bagnon per utilizzare l'integrazione dei filtri per espansione."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Abilita integrazione Bagnon"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Mostra il selettore di filtro per espansione quando usi Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Avanzate"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "Sostituzione API"
L["SETTINGS_API_HOOK_DESCRIPTION"] =
"Sostituisce la funzione C_Item.GetItemInfo del gioco in modo che TUTTI gli addon ricevano gli ID di espansione corretti di ItemEra invece dei valori predefiniti del gioco."
L["SETTINGS_API_HOOK_WARNING"] =
"Avviso: Questa funzione è sperimentale e modifica una funzione principale del gioco. Potrebbe causare problemi di compatibilità con altri addon. Usala a tuo rischio."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Abilita sostituzione API"
L["SETTINGS_API_HOOK_ENABLED_DESC"] =
"Sostituire C_Item.GetItemInfo per restituire globalmente gli ID di espansione di ItemEra"
