local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
    ItemEra.FiltersGuildBank:Initialize()
    ItemEra.FiltersInventory:Initialize()

    if ItemEra.CONFIG.VERSION_MAJOR == 11 and ItemEra.CONFIG.VERSION_MINOR >= 2 then
        ItemEra.FiltersBank_11_2:Initialize()
    else
        ItemEra.FiltersBank:Initialize()
    end
end
