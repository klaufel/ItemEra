local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

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

ItemEra.Utils.ExpansionNamesShort = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "Classic",
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "TBC",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "WoTLK",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "Cata",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "MoP",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "WoD",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "Legion",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "BFA",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "SL",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "DF",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "TWW"
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

ItemEra.Utils.KeyModifiers = {
    SHIFT = "SHIFT",
    CTRL = "CTRL",
    ALT = "ALT"
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

function ItemEra.Utils:GetExpansionTextByExpansionID(expansionID)
    if not expansionID then return end

    local showExpansionLiteral = true
    local showExpansionName = true
    local showExpansionLogo = true

    if ItemEra.DB_SETTINGS and ItemEra.DB_SETTINGS.global and ItemEra.DB_SETTINGS.global.settings then
        showExpansionLiteral = ItemEra.DB_SETTINGS.global.settings.showExpansionLiteral
        showExpansionName = ItemEra.DB_SETTINGS.global.settings.showExpansionName
        showExpansionLogo = ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
    end

    local expansionColor = ItemEra.Utils.ExpansionColors[expansionID]
    local expansionName = showExpansionName and ItemEra.Utils.ExpansionNames[expansionID] or ""
    local expansionLiteral = showExpansionLiteral and ("|cffffd100" .. L["EXPANSION"] .. "|r") or ""

    if not expansionColor or not expansionName then return end

    local r, g, b = unpack(expansionColor)
    local imageSize = "14:14"
    local image = "|T%s:" .. imageSize .. ":0:0:64:64:4:60:4:60|t"
    local expansionLogo = showExpansionLogo and (image):format(ItemEra.Utils:GetExpansionLogoById(expansionID)) or ""

    local coloredExpansionName = (expansionName ~= "") and ("|cff%02x%02x%02x%s|r"):format(r, g, b, expansionName) or ""

    local expansionText = expansionLiteral .. " " .. expansionLogo .. "  " .. coloredExpansionName
    expansionText = expansionText:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return expansionText
end
