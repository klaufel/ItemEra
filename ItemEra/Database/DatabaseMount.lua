local _, addon = ...

local ExpansionDictionary = ItemEra.Utils.ExpansionDictionary

local EXPANSION_VERSION = {
    [ExpansionDictionary.CLASSIC] = "1.0.0.0", -- Classic
    [ExpansionDictionary.TBC] = "2.0.0.0",     -- The Burning Crusade
    [ExpansionDictionary.WOTLK] = "3.0.0.0",   -- Wrath of the Lich King
    [ExpansionDictionary.CATA] = "4.0.0.0",    -- Cataclysm
    [ExpansionDictionary.MOP] = "5.0.0.0",     -- Mists of Pandaria
    [ExpansionDictionary.WOD] = "6.0.0.0",     -- Warlords of Draenor
    [ExpansionDictionary.LEGION] = "7.0.0.0",  -- Legion
    [ExpansionDictionary.BFA] = "8.0.0.0",     -- Battle for Azeroth
    [ExpansionDictionary.SHADOW] = "9.0.0.0",  -- Shadowlands
    [ExpansionDictionary.DF] = "10.0.0.0",     -- Dragonflight
    [ExpansionDictionary.TWW] = "11.0.0.0",    -- War Within
}

---@class MountExpansionConfig
---@field expansionIndex number
---@field minID number
---@field maxID number
---@field exceptions number[]|nil
---@type MountExpansionConfig[]
local MOUNT_EXPANSION_CONFIG = {
    { ExpansionDictionary.CLASSIC, 0, 122 },
    { ExpansionDictionary.TBC, 123, 226, {
        241,
        243
    } },
    { ExpansionDictionary.WOTLK, 227, 382, {
        211,
        212,
        221,
        1679
    } },
    { ExpansionDictionary.CATA, 383, 447, {
        358,
        373,
        1812
    } },
    { ExpansionDictionary.MOP, 448, 571, {
        467,
        2582
    } },
    { ExpansionDictionary.DRAENOR, 572, 772, {
        454,
        552,
        778,
        781
    } },
    { ExpansionDictionary.LEGION, 773, 991, {
        476,
        633,
        656,
        663,
        763,
        1006,
        1007,
        1008,
        1009,
        1011
    } },
    { ExpansionDictionary.BFA, 993, 1329, {
        926,
        928,
        933,
        956,
        958,
        963,
        1346
    } },
    { ExpansionDictionary.SHADOW, 1330, 1576, {
        803,
        1289,
        1298,
        1299,
        1302,
        1303,
        1304,
        1305,
        1306,
        1307,
        1309,
        1310,
        1580,
        1581,
        1584,
        1585,
        1587,
        1597,
        1599,
        1600,
        1602
    } },
    { ExpansionDictionary.DF, 1577, 2115, {
        1469,
        1478,
        1545,
        1546,
        1553,
        1556,
        1563,
        2118,
        2142,
        2143,
        2152,
        2140,
        2189,
    }
    },
    { ExpansionDictionary.TWW, 2116, 3000, {
        1550,
        1792,
    } },
}

addon.DB.MOUNT = {}


for _, cfg in ipairs(MOUNT_EXPANSION_CONFIG) do
    local expansionIndex, minID, maxID, exceptions = cfg[1], cfg[2], cfg[3], cfg[4]
    for id = minID, maxID do
        addon.DB.MOUNT[id] = EXPANSION_VERSION[expansionIndex]
    end
    if exceptions then
        for _, exID in ipairs(exceptions) do
            addon.DB.MOUNT[exID] = EXPANSION_VERSION[expansionIndex]
        end
    end
end
