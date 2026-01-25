local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)

function ItemEra:OnInitialize()
    ItemEra.Settings:Initialize()
    -- ItemEra.APIHook:Initialize()
    ItemEra.Tooltip:Initialize()
    ItemEra.Decorations:Initialize()
    ItemEra.Filters:Initialize()

    if ItemEra.CONFIG.DEBUG then
        print("[ItemEra] DEBUG: " .. tostring(ItemEra.CONFIG.DEBUG))
        print("[ItemEra] DISABLED_DB: " .. tostring(ItemEra.CONFIG.DISABLED_DB))
        print("[ItemEra] VERSION: " .. ItemEra.CONFIG.VERSION)
        print("[ItemEra] DB_SETTINGS: " .. tostring(ItemEra.DB_SETTINGS.global.settings))
    end
end
