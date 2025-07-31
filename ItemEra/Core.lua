local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)


function ItemEra:OnInitialize()
    if ItemEra.CONFIG.DEBUG then print('ItemEra: OnInitialize [DEBUG: Enabled]') end
    ItemEra.Tooltip:Initialize()
    ItemEra.Filters:Initialize()
end
