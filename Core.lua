local addonName, addon = ...

ItemEra = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)

function ItemEra:OnInitialize()
    self.db = self.Database:New()

    print(self.db.profile.prueba)
    ItemEra.Tooltip:Initialize()
    ItemEra.Settings:Initialize()
    ItemEra.Filters:Initialize()
end
