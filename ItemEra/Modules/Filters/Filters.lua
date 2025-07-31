local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
    ItemEra.FiltersGuildBank:Initialize()
    -- Prepare to 11.2
    -- ItemEra.FiltersInventory:Initialize()

    local version = GetBuildInfo()
    local majorVersion = tonumber(version:match("^(%d+)"))
    local minorVersion = tonumber(version:match("^%d+%.(%d+)"))

    if majorVersion == 11 and minorVersion >= 2 then
        ItemEra.FiltersBank_11_2:Initialize()
    else
        ItemEra.FiltersBank:Initialize()
    end
end
