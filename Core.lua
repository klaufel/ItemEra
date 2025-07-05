local addonName, addon = ...
_G[addonName] = addon

ItemEraSaved = ItemEraSaved or {}

function addon:Init()
    if self.Tooltip and self.Tooltip.Init then self.Tooltip:Init() end
    if self.BankFilter and self.BankFilter.Init then self.BankFilter:Init() end


    local locale = GetLocale and GetLocale() or "unknown"

    if ItemEraSaved.debug then
        print("ItemEra Debug: Client locale is " .. locale)
        print(addon.L["COMMON.ADDON_LOADED"])
    end
end

addon:Init()
