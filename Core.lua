local addonName, addon = ...
ItemEra = ItemEra or {}
ItemEra.Events = ItemEra.Events or {}
ItemEra.Tooltip = ItemEra.Tooltip or {}
ItemEra.Settings = ItemEra.Settings or {}

function addon:Init()
    ItemEra.Tooltip:Initialize()
    ItemEra.Settings:Initialize()
    ItemEra.Filters:Initialize()
end

addon:Init()
