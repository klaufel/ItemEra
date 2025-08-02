local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)


function ItemEra:OnInitialize()
    if ItemEra.CONFIG.DEBUG then
        print("[ItemEra] DEBUG: " .. tostring(ItemEra.CONFIG.DEBUG))
        print("[ItemEra] DISABLED_DB: " .. tostring(ItemEra.CONFIG.DISABLED_DB))
        print("[ItemEra] VERSION: " .. ItemEra.CONFIG.VERSION)
    end

    ItemEra.Tooltip:Initialize()
    ItemEra.Filters:Initialize()
end
