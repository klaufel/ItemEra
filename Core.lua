local addonName, addon = ...
_G[addonName] = addon

-- Initialize global variables and data
ItemEraSaved = ItemEraSaved or {}

function addon:Init()
    -- if self.Config and self.Config.Init then self.Config:Init() end

    if self.Tooltip and self.Tooltip.Init then self.Tooltip:Init() end
    if self.BankFilter and self.BankFilter.Init then self.BankFilter:Init() end


    -- Debug: show language information
    local locale = GetLocale and GetLocale() or "unknown"

    if ItemEraSaved.debug then
        print("ItemEra Debug: Client locale is " .. locale)
        print(addon.L["COMMON.ADDON_LOADED"])
    end
end

addon:Init()
