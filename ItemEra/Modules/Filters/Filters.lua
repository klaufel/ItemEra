local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
    local isBaganatorLoaded = ItemEra.Utils:IsBaganatorLoaded()

    -- If Baganator is loaded, use the Baganator integration
    -- instead of ItemEra's native filters
    if isBaganatorLoaded then
        if ItemEra.DB_SETTINGS.global.settings.enabledBaganatorIntegration then
            ItemEra.Filters_Baganator:Initialize()
        end
        -- Don't initialize native filters when Baganator is active
        -- since Baganator replaces the inventory/bank interfaces
        return
    end

    -- ItemEra native filters (only when Baganator is NOT loaded)
    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersInventory then
        ItemEra.Filters_Inventory:Initialize()
    end

    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersBank then
        ItemEra.Filters_Bank:Initialize()
    end

    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersGuildBank then
        ItemEra.Filters_GuildBank:Initialize()
    end
end
