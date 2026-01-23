local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
    local isBaganatorLoaded = ItemEra.Utils:IsBaganatorLoaded()
    local isBagnonLoaded = ItemEra.Utils:IsBagnonLoaded()

    -- If Baganator is loaded, use the Baganator integration
    if isBaganatorLoaded and ItemEra.DB_SETTINGS.global.settings.enabledBaganatorIntegration then
        ItemEra.Filters_Baganator:Initialize()
    end

    -- If Bagnon is loaded, use the Bagnon integration
    if isBagnonLoaded and ItemEra.DB_SETTINGS.global.settings.enabledBagnonIntegration then
        ItemEra.Filters_Bagnon:Initialize()
    end

    if (isBaganatorLoaded or isBagnonLoaded) then
        return
    end

    -- ItemEra native filters (only when Baganator/Bagnon is NOT loaded)
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
