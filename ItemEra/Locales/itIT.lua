local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "itIT")

if not L then
    return
end

L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon caricato"
L["COMMON.SAVE"] = "Salva"
L["COMMON.CANCEL"] = "Annulla"
L["COMMON.FILTER"] = "Filtra"
L["COMMON.SELECT_EXPANSION"] = "Seleziona espansione"
L["COMMON.ALL_EXPANSION"] = "Tutte le espansioni"
L["COMMON.CLEAR_FILTER"] = "Cancella filtro"

L["SETTINGS.TITLE"] = "Impostazioni"
L["SETTINGS.RESET_TO_DEFAULT"] = "Ripristina predefiniti"
L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Abilita informazioni espansione"
L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Mostra espansione nel tooltip dell'oggetto"
L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Mostra l'espansione di origine nel tooltip dell'oggetto."
L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Filtro espansione nelle banche"
L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Abilita la funzionalità di filtro per espansione."

L["TOOLTIP.EXPANSION"] = "Espansione:"
L["TOOLTIP.ORIGIN"] = "Origine:"
L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filtra oggetti per espansione"
L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filtra oggetti per espansione (banca di gilda)"
L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Clicca per scegliere l'espansione"
