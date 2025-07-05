local addonName, addon = ...

if GetLocale() ~= "frFR" then
    return
end

local L = addon.L or {}
addon.L = L

-- Common
L["COMMON.ADDON_LOADED"] = "ItemEra chargé avec succès !"
L["COMMON.SELECT_EXPANSION"] = "Sélectionner l'extension"
L["COMMON.ALL_EXPANSION"] = "Toutes les extensions"

-- Expansion Names
L["EXPANSION.CLASSIC"] = "Classic"
L["EXPANSION.BURNING_CRUSADE"] = "The Burning Crusade"
L["EXPANSION.WRATH_OF_THE_LICH_KING"] = "Wrath of the Lich King"
L["EXPANSION.CATACLYSM"] = "Cataclysm"
L["EXPANSION.MISTS_OF_PANDARIA"] = "Mists of Pandaria"
L["EXPANSION.WARLORDS_OF_DRAENOR"] = "Warlords of Draenor"
L["EXPANSION.LEGION"] = "Legion"
L["EXPANSION.BATTLE_FOR_AZEROTH"] = "Battle for Azeroth"
L["EXPANSION.SHADOWLANDS"] = "Shadowlands"
L["EXPANSION.DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION.THE_WAR_WITHIN"] = "The War Within"

-- Tooltip
L["TOOLTIP.EXPANSION"] = "Extension : %s"
L["TOOLTIP.ITEM_LEVEL"] = "Niveau d'objet : %d"

-- Bank Filter
L["BANKFILTER.SELECT_EXPANSION"] = "Sélectionner l'extension"
L["BANKFILTER.ALL_EXPANSIONS"] = "Toutes les extensions"
L["BANKFILTER.FILTER_APPLIED"] = "Filtre appliqué à %s objets"
L["BANKFILTER.FILTER_CLEARED"] = "Filtre supprimé"

-- Settings
L["SETTINGS.TITLE"] = "Paramètres ItemEra"
L["SETTINGS.GENERAL"] = "Général"
L["SETTINGS.TOOLTIP"] = "Info-bulle"
L["SETTINGS.BANK_FILTER"] = "Filtre de banque"
L["SETTINGS.SHOW_EXPANSION_TOOLTIP"] = "Afficher l'extension dans l'info-bulle"
L["SETTINGS.SHOW_EXPANSION_TOOLTIP_DESC"] = "Affiche l'extension d'origine de l'objet dans l'info-bulle"
L["SETTINGS.ENABLE_BANK_FILTER"] = "Activer le filtre de banque"
L["SETTINGS.ENABLE_BANK_FILTER_DESC"] = "Active le système de filtrage par extension dans la banque"
