local _, ItemEra = ...

local AceDB = LibStub("AceDB-3.0")

ItemEra.Database = {}

function ItemEra.Database:GetDefault()
    return {
        profile = {
            prueba = 'holi',
            showPrefix = true,
            prefixColor = { r = 1.0, g = 1.0, b = 1.0 },
            shortExpacNames = false,
            expacColor = { r = 1.0, g = 1.0, b = 1.0 },
            showVersion = true,
            versionColor = { r = 1.0, g = 1.0, b = 1.0 },
            showWhenMissing = false,
            showBuildNumber = true,
            keyModifiers = { shift = false, control = false, alt = false, meta = false },
            includeCommunityUpdates = true,
        },
    }
end

function ItemEra.Database:New()
    return AceDB:New("ItemEraDB", self:GetDefault(), true)
end
