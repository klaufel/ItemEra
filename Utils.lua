local _, ItemEra = ...
ItemEra.Utils = {}



function ItemEra.Utils:toRGB(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
        tonumber("0x" .. hex:sub(3, 4)) / 255,
        tonumber("0x" .. hex:sub(5, 6)) / 255
end

ItemEra.Utils.ExpansionColorsHex = {
    [0]  = "#F4BF2A", -- Classic
    [1]  = "#CBD86C", -- The Burning Crusade
    [2]  = "#9DC6E5", -- Wrath of the Lich King
    [3]  = "#8E3C14", -- Cataclysm
    [4]  = "#5FB177", -- Mists of Pandaria
    [5]  = "#D77500", -- Warlords of Draenor
    [6]  = "#D9E342", -- Legion
    [7]  = "#C4C6C5", -- Battle for Azeroth
    [8]  = "#F9F8F6", -- Shadowlands
    [9]  = "#B6B6BA", -- Dragonflight
    [10] = "#EA551F", -- War Within
    [11] = "#5C1FEA", -- Midnight
}

ItemEra.Utils.ExpansionColors = {}
for k, hex in pairs(ItemEra.Utils.ExpansionColorsHex) do
    ItemEra.Utils.ExpansionColors[k] = { ItemEra.Utils:toRGB(hex) }
end



ItemEra.Utils.ExpansionDictionary = {
    CLASSIC = 0,
    TBC = 1,
    WOTLK = 2,
    CATA = 3,
    MOP = 4,
    WOD = 5,
    LEGION = 6,
    BFA = 7,
    SHADOW = 8,
    DF = 9,
    TWW = 10
}

ItemEra.Utils.ExpansionNames = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "Classic",
    [ItemEra.Utils.ExpansionDictionary.TBC] = "The Burning Crusade",
    [ItemEra.Utils.ExpansionDictionary.WOTLK] = "Wrath of the Lich King",
    [ItemEra.Utils.ExpansionDictionary.CATA] = "Cataclysm",
    [ItemEra.Utils.ExpansionDictionary.MOP] = "Mists of Pandaria",
    [ItemEra.Utils.ExpansionDictionary.WOD] = "Warlords of Draenor",
    [ItemEra.Utils.ExpansionDictionary.LEGION] = "Legion",
    [ItemEra.Utils.ExpansionDictionary.BFA] = "Battle for Azeroth",
    [ItemEra.Utils.ExpansionDictionary.SHADOW] = "Shadowlands",
    [ItemEra.Utils.ExpansionDictionary.DF] = "Dragonflight",
    [ItemEra.Utils.ExpansionDictionary.TWW] = "The War Within"
}


ItemEra.Utils.ExpansionItemsExcluded = {
    [168583] = ItemEra.Utils.ExpansionDictionary.SHADOW, -- Widowbloom
    [168586] = ItemEra.Utils.ExpansionDictionary.SHADOW, -- Rising Glory
    [168589] = ItemEra.Utils.ExpansionDictionary.SHADOW, -- Marrowroot
    [169701] = ItemEra.Utils.ExpansionDictionary.SHADOW, -- Death Blossom
    [171315] = ItemEra.Utils.ExpansionDictionary.SHADOW, -- Nightshade
}


function ItemEra.Utils:GetExpansionsInOrder()
    local ordered = {}
    for id = 0, 10 do
        if ItemEra.Utils.ExpansionNames[id] then
            table.insert(ordered, { id = id, name = ItemEra.Utils.ExpansionNames[id] })
        end
    end
    return ordered
end

ItemEra.Utils.PathAssets = "Interface\\AddOns\\ItemEra\\Assets\\"

function ItemEra.Utils:GetExpansionLogoById(expansionID)
    return ItemEra.Utils.PathAssets .. "Icons\\Exp_Logo_" .. expansionID .. ".tga"
end
