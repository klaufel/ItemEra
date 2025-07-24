local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)

ItemEra.Config = {
    debug = true,
    disabledDB = true
}

function ItemEra:OnInitialize()
    ItemEra.Tooltip:Initialize()
    ItemEra.Filters:Initialize()
end
