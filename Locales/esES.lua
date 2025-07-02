local addonName, addon = ...

-- Solo cargar las traducciones en español si el cliente está en español
local function LoadSpanishLocale()
    local locale = GetLocale()
    if locale == "esES" or locale == "esMX" then
        -- Asegurar que addon.L existe
        addon.L = addon.L or {}
        if not getmetatable(addon.L) then
            setmetatable(addon.L, { __index = function(t, k) return k end })
        end
        local L = addon.L

        -- COMMON
        L["COMMON.ADDON_LOADED"] = "[ItemEra]: Addon cargado"
        L["COMMON.SAVE"] = "Guardar"
        L["COMMON.CANCEL"] = "Cancelar"
        L["COMMON.FILTER"] = "Filtrar"
        L["COMMON.CLEAR_FILTER"] = "Limpiar Filtro"

        -- SETTINGS
        L["SETTINGS.TITLE"] = "Ajustes"
        L["SETTINGS.RESET_TO_DEFAULT"] = "Restablecer por defecto"
        -- SETTINGS.EXPANSION_TOOLTIP
        L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "Activar información de expansión"
        L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "Mostrar expansión en el tooltip de objetos"
        L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "Mostrar la expansión de origen en el tooltip del objeto."
        -- SETTINGS.EXPANSION_FILTER
        L["SETTINGS.EXPANSION_FILTER.TITLE"] = "Mostrar filtro de expansión"
        L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "Activar la funcionalidad de filtrado por expansión."


        -- UI
        -- TOOLTIP
        L["TOOLTIP.EXPANSION"] = "Expansión:"
        L["TOOLTIP.ORIGIN"] = "Origen:"
        -- FILTER
        L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión"
        L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "Filtrar objetos por expansión (banco de hermandad)"
        L["FILTER.CLICK_CHOOSE_EXPANSION"] = "Haz clic para elegir expansión"
    end
end

-- Ejecutar cuando el addon se cargue
-- Usar un event frame para asegurar que GetLocale esté disponible
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddonName)
    if loadedAddonName == addonName then
        LoadSpanishLocale()
        frame:UnregisterEvent("ADDON_LOADED")
    end
end)
