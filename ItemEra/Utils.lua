local _, ItemEra = ...
ItemEra.Utils = {}

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
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "The Burning Crusade",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "Wrath of the Lich King",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "Cataclysm",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "Mists of Pandaria",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "Warlords of Draenor",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "Legion",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "Battle for Azeroth",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "Shadowlands",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "Dragonflight",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "The War Within"
}

ItemEra.Utils.ExpansionVersionPatch = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "1.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "2.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "3.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "4.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "5.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "6.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "7.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "8.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "9.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "10.0.0.0",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "11.0.0.0",
}

ItemEra.Utils.ExpansionColorsHex = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "#F4BF2A",
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "#CBD86C",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "#9DC6E5",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "#8E3C14",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "#5FB177",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "#D77500",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "#D9E342",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "#C4C6C5",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "#F9F8F6",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "#B6B6BA",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "#EA551F",
}


function ItemEra.Utils:toRGB(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)),
        tonumber("0x" .. hex:sub(3, 4)),
        tonumber("0x" .. hex:sub(5, 6))
end

ItemEra.Utils.ExpansionColors = {}
for k, hex in pairs(ItemEra.Utils.ExpansionColorsHex) do
    ItemEra.Utils.ExpansionColors[k] = { ItemEra.Utils:toRGB(hex) }
end

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
