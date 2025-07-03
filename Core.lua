local addonName, addon = ...
_G[addonName] = addon

-- Inicialización de variables globales y datos
ItemEraConfig = ItemEraConfig or {}

function addon:Init()
    if self.Config and self.Config.Init then self.Config:Init() end


    if addon.Config:GetShowExpansionTooltip() then
        if self.Tooltip and self.Tooltip.Init then self.Tooltip:Init() end
    end

    -- Debug: mostrar información del idioma
    local locale = GetLocale and GetLocale() or "unknown"
    print("ItemEra Debug: Client locale is " .. locale)

    print(addon.L["COMMON.ADDON_LOADED"])
end

addon:Init()
