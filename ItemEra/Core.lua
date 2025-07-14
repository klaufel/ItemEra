local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)

function ItemEra:OnInitialize()
    ItemEra.Tooltip:Initialize()
    ItemEra.Filters:Initialize()
end
