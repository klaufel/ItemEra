local addonName, addon = ...

-- Solo cargar las traducciones en francés si le client est en français
local function LoadFrenchLocale()
    local locale = GetLocale()
    if locale == "frFR" then
        -- Asegurar que addon.L existe
        addon.L = addon.L or {}
        if not getmetatable(addon.L) then
            setmetatable(addon.L, { __index = function(t, k) return k end })
        end
        local L = addon.L

        -- Traducciones en francés
        -- COMMON
        L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon chargé"
        L["COMMON.SAVE"] = "Sauvegarder"
        L["COMMON.CANCEL"] = "Annuler"
        L["COMMON.FILTER"] = "Filtrer"
        L["COMMON.CLEAR_FILTER"] = "Effacer le Filtre"

        -- SETTINGS
        L["SETTINGS.TITLE"] = "Paramètres"
        L["SETTINGS.RESET_TO_DEFAULT"] = "Réinitialiser par défaut"
        -- SETTINGS.EXPANSION_TOOLTIP
        L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Activer les informations d'extension"
        L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Afficher l'extension dans l'infobulle de l'objet"
        L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Afficher l'extension d'origine dans l'infobulle de l'objet."
        -- SETTINGS.EXPANSION_FILTER
        L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Afficher le filtre d'extension"
        L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Activer la fonctionnalité de filtrage par extension."

        -- UI
        -- TOOLTIP
        L["TOOLTIP.EXPANSION"] = "Extension:"
        L["TOOLTIP.ORIGIN"] = "Origine:"
        -- FILTER
        L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filtrer les objets par extension"
        L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filtrer les objets par extension (banque de guilde)"
        L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Cliquer pour choisir l'extension"
    end
end

-- Ejecutar cuando el addon se cargue
-- Usar un event frame para asegurar que GetLocale esté disponible
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddonName)
    if loadedAddonName == addonName then
        LoadFrenchLocale()
        frame:UnregisterEvent("ADDON_LOADED")
    end
end)
