local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")

if not L then
    return
end

L["COMMON.ADDON_LOADED"] = "ItemEra chargé avec succès !"
L["COMMON.SELECT_EXPANSION"] = "Sélectionner l'extension"
L["COMMON.ALL_EXPANSION"] = "Toutes les extensions"

L["TOOLTIP.EXPANSION"] = "Extension : %s"
L["TOOLTIP.ITEM_LEVEL"] = "Niveau d'objet : %d"

L["BANKFILTER.SELECT_EXPANSION"] = "Sélectionner l'extension"
L["BANKFILTER.ALL_EXPANSIONS"] = "Toutes les extensions"
L["BANKFILTER.FILTER_APPLIED"] = "Filtre appliqué à %s objets"
L["BANKFILTER.FILTER_CLEARED"] = "Filtre supprimé"

L["SETTINGS.TITLE"] = "Paramètres ItemEra"
L["SETTINGS.GENERAL"] = "Général"
L["SETTINGS.TOOLTIP"] = "Info-bulle"
L["SETTINGS.BANK_FILTER"] = "Filtre de banque"
L["SETTINGS.SHOW_EXPANSION_TOOLTIP"] = "Afficher l'extension dans l'info-bulle"
L["SETTINGS.SHOW_EXPANSION_TOOLTIP_DESC"] = "Affiche l'extension d'origine de l'objet dans l'info-bulle"
L["SETTINGS.ENABLE_BANK_FILTER"] = "Activer le filtre de banque"
L["SETTINGS.ENABLE_BANK_FILTER_DESC"] = "Active le système de filtrage par extension dans la banque"
