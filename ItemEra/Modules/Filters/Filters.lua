local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
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
