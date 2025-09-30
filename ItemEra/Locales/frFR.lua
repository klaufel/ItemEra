local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Sélectionner l'extension"
L["ALL_EXPANSION"] = "Toutes les extensions"
L["EXPANSION"] = "Extension:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Affichage de l'extension"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure les options d'affichage d'ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Afficher le littéral 'Extension'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Affiche le littéral 'Extension' avant le nom et le logo dans les infobulles"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Afficher le nom de l'extension"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Affiche le nom de l'extension à côté de l'icône dans les infobulles"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Afficher le logo de l'extension"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Affiche le logo de l'extension à côté de l'icône dans les infobulles"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(L'infobulle ne sera pas affichée)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Aperçu de l'infobulle:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Touche modificatrice"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Utiliser une touche modificatrice"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] =
"Affiche les informations d'extension seulement quand une touche modificatrice est maintenue."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Touche modificatrice"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Sélectionnez la touche modificatrice qui sera utilisée pour afficher les informations d'extension."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Filtres d'extension"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "Active ou désactive les filtres d'extension dans différentes fenêtres du jeu."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Inventaire"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Active les filtres d'extension dans les sacs d'inventaire"

L["SETTINGS_FILTERS_BANK_NAME"] = "Banque personnelle"
L["SETTINGS_FILTERS_BANK_DESC"] = "Active les filtres d'extension dans la banque personnelle"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Banque de guilde"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Active les filtres d'extension dans la banque de guilde"

L["SETTINGS_RELOAD_REQUIRED"] =
"Les modifications des filtres nécessitent de recharger l'interface (/reload) pour s'appliquer."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "Les modifications des filtres nécessitent de recharger l'interface pour s'appliquer."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Recharger maintenant"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Plus tard"
L["SETTINGS_RESET_NAME"] = "Réinitialiser les paramètres"
L["SETTINGS_RESET_DESC"] = "Remet tous les paramètres à leurs valeurs par défaut"
