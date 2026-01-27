local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Sélectionner l'extension"
L["ALL_EXPANSION"] = "Toutes les extensions"
L["EXPANSION"] = "Extension:"
L["PROFESSION"] = "Métier:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Filtrer et afficher les informations d'extension pour vos objets."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Infobulle"
L["SETTINGS_SUBPAGE_FILTERS"] = "Filtres"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Affichage de l'extension"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure les options d'affichage d'ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Littéral 'Extension'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Affiche le littéral 'Extension' avant le nom et le logo dans les infobulles"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Nom de l'extension"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Affiche le nom de l'extension à côté de l'icône dans les infobulles"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Logo de l'extension"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Affiche le logo de l'extension à côté de l'icône dans les infobulles"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "Affichage du métier"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "Configure les options d'affichage du métier pour les composants d'artisanat."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "Littéral 'Métier'"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "Affiche le littéral 'Métier' avant le nom et l'icône dans les infobulles"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "Nom du métier"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "Affiche le nom du métier dans les infobulles"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "Icône du métier"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "Affiche l'icône du métier dans les infobulles"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "Retour à la ligne du texte de métier"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "Retourne le texte de métier sur plusieurs lignes quand il est trop long"

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
L["SETTINGS_RESET_NAME"] = "Paramètres par défaut"
L["SETTINGS_RESET_DESC"] = "Remet tous les paramètres à leurs valeurs par défaut"

L["SETTINGS_DISCORD_NAME"] = "Rejoindre Discord"
L["SETTINGS_DISCORD_DESC"] = "Rejoignez notre communauté Discord pour le support et les mises à jour"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Copiez ce lien pour rejoindre notre Discord:"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Décorations d'objets"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Affiche les icônes d'extension sur les objets de votre inventaire."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Activer les décorations d'objets"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] =
"Affiche une petite icône d'extension sur chaque objet de vos sacs. Survolez l'icône pour voir le nom de l'extension."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Intégration Baganator"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator détecté !"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator non détecté."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] =
"ItemEra ajoutera des icônes d'extension aux coins des objets dans Baganator. Les filtres natifs sont désactivés lorsque Baganator est actif."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] =
"Installez Baganator pour utiliser l'intégration des catégories par extension."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Activer l'intégration Baganator"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Affiche les icônes d'extension sur les objets lorsque vous utilisez Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Intégration Bagnon"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon détecté !"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon non détecté."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] =
"ItemEra ajoutera des filtres d'extension à Bagnon. Les filtres natifs sont désactivés lorsque Bagnon est actif."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Installez Bagnon pour utiliser l'intégration des filtres par extension."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Activer l'intégration Bagnon"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Affiche le sélecteur de filtre par extension lorsque vous utilisez Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Avancé"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "Remplacement de l'API"
L["SETTINGS_API_HOOK_DESCRIPTION"] =
"Remplace la fonction C_Item.GetItemInfo du jeu afin que TOUS les addons reçoivent les ID d'extension corrigés d'ItemEra au lieu des valeurs par défaut du jeu."
L["SETTINGS_API_HOOK_WARNING"] =
"Avertissement : Cette fonctionnalité est expérimentale et modifie une fonction principale du jeu. Elle peut provoquer des problèmes de compatibilité avec d'autres addons. Utilisez-la à vos propres risques."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Activer le remplacement de l'API"
L["SETTINGS_API_HOOK_ENABLED_DESC"] =
"Remplacer C_Item.GetItemInfo pour renvoyer globalement les ID d'extension d'ItemEra"

L["SETTINGS_FEATURES_POPUP_NAME"] = "Nouveautés"
L["SETTINGS_FEATURES_POPUP_DESC"] = "Voir les nouveautés de cette version"

-- Features Popup
L["FEATURES_POPUP_TITLE"] = "Nouveautés"
L["FEATURES_POPUP_VERSION"] = "Version"
L["FEATURES_POPUP_CLOSE"] = "Fermer"
L["FEATURES_POPUP_DONT_SHOW_AGAIN"] = "Ne plus afficher pour cette version"
L["FEATURES_POPUP_CONTENT"] = [[
|cff00ff00Hey ! Quoi de neuf dans cette version ?|r

|cffffd700Composants d'artisanat|r
L'infobulle affiche maintenant les métiers qui utilisent chaque composant. Basé sur toutes les recettes du jeu et lié à leur métier. Base de données mise à jour avec support des rangs de composants.

Vous pouvez personnaliser l'affichage des métiers (icône + nom, nom seul, ou icône seule).

|cffffd700Dans la version précédente :|r
- Support des filtres pour Baganator et Bagnon (utilisant la recherche interne)
- Plus d'options de configuration dans la section "Paramètres" entièrement repensée

Merci d'utiliser ItemEra !
]]
