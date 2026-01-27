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
    TWW = 10,
    MN = 11
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
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "The War Within",
    [ItemEra.Utils.ExpansionDictionary.MN]      = "Midnight"
}

ItemEra.Utils.ExpansionSearchTermsBaganator = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "classic",
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "tbc",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "wotlk",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "cataclysm",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "mop",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "wod",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "legion",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "bfa",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "shadowlands",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "dragonflight",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "tww",
    [ItemEra.Utils.ExpansionDictionary.MN]      = "midnight",
}


ItemEra.Utils.ExpansionSearchTermsBagnon = {
    [ItemEra.Utils.ExpansionDictionary.CLASSIC] = "classic",
    [ItemEra.Utils.ExpansionDictionary.TBC]     = "burning crusade",
    [ItemEra.Utils.ExpansionDictionary.WOTLK]   = "lich king",
    [ItemEra.Utils.ExpansionDictionary.CATA]    = "cataclysm",
    [ItemEra.Utils.ExpansionDictionary.MOP]     = "pandaria",
    [ItemEra.Utils.ExpansionDictionary.WOD]     = "draenor",
    [ItemEra.Utils.ExpansionDictionary.LEGION]  = "legion",
    [ItemEra.Utils.ExpansionDictionary.BFA]     = "azeroth",
    [ItemEra.Utils.ExpansionDictionary.SHADOW]  = "shadowlands",
    [ItemEra.Utils.ExpansionDictionary.DF]      = "dragonflight",
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "within",
    [ItemEra.Utils.ExpansionDictionary.MN]      = "midnight",
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
    [ItemEra.Utils.ExpansionDictionary.TWW]     = "TWW",
    [ItemEra.Utils.ExpansionDictionary.MN]      = "Midnight"
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
    [ItemEra.Utils.ExpansionDictionary.MN]      = "12.0.0.0",
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
    [ItemEra.Utils.ExpansionDictionary.MN]      = "#5C1FEA",
}

ItemEra.Utils.KeyModifiers = {
    SHIFT = "SHIFT",
    CTRL = "CTRL",
    ALT = "ALT"
}



ItemEra.Utils.TooltipDataTypes = {
    ITEM = Enum.TooltipDataType.Item,
    SPELL = Enum.TooltipDataType.Spell,
    -- UNIT = Enum.TooltipDataType.Unit,
    -- CORPSE = Enum.TooltipDataType.Corpse,
    -- OBJECT = Enum.TooltipDataType.Object,
    -- CURRENCY = Enum.TooltipDataType.Currency,
    -- BATTLEPET = Enum.TooltipDataType.BattlePet,
    -- UNITAURA = Enum.TooltipDataType.UnitAura,
    -- AZERITE_ESSENCE = Enum.TooltipDataType.AzeriteEssence,
    -- COMPANION_PET = Enum.TooltipDataType.CompanionPet,
    MOUNT = Enum.TooltipDataType.Mount,
    -- PET_ACTION = Enum.TooltipDataType.PetAction,
    -- ACHIEVEMENT = Enum.TooltipDataType.Achievement,
    -- ENHANCED_CONDUIT = Enum.TooltipDataType.EnhancedConduit,
    -- EQUIPMENT_SET = Enum.TooltipDataType.EquipmentSet,
    -- INSTANCE_LOCK = Enum.TooltipDataType.InstanceLock,
    -- PVP_BRAWL = Enum.TooltipDataType.PvPBrawl,
    -- RECIPE_RANK_INFO = Enum.TooltipDataType.RecipeRankInfo,
    -- TOTEM = Enum.TooltipDataType.Totem,
    TOY = Enum.TooltipDataType.Toy,
    -- CORRUPTION_CLEANSE = Enum.TooltipDataType.CorruptionCleanser,
    -- MINIMAP_MOUSEOVER = Enum.TooltipDataType.MinimapMouseover,
    -- FLYOUT = Enum.TooltipDataType.Flyout,
    -- QUEST = Enum.TooltipDataType.Quest,
    -- QUEST_PARTY_PROGRESS = Enum.TooltipDataType.QuestPartyProgress,
    -- MACRO = Enum.TooltipDataType.Macro,
    -- DEBUG = Enum.TooltipDataType.Debug,
}


ItemEra.Utils.ProfessionName = {
    -- Primary
    [Enum.Profession.Alchemy] = 2259,
    [Enum.Profession.Blacksmithing] = 2018,
    [Enum.Profession.Enchanting] = 7411,
    [Enum.Profession.Engineering] = 4036,
    [Enum.Profession.Inscription] = 45357,
    [Enum.Profession.Jewelcrafting] = 25229,
    [Enum.Profession.Leatherworking] = 2108,
    [Enum.Profession.Tailoring] = 3908,

    -- Harvest
    [Enum.Profession.Mining] = 2575,
    [Enum.Profession.Herbalism] = 2366,
    [Enum.Profession.Skinning] = 8613,

    -- Secondary
    [Enum.Profession.Fishing] = 131474,
    [Enum.Profession.Cooking] = 2550,
    [Enum.Profession.Archaeology] = 78670,
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
    for id = 0, 11 do
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

-- Professions utils

function ItemEra.Utils:GetProfessionIDsByItemID(itemID)
    local professionIDs = {}

    for key, items in pairs(ItemEra.DB.ITEM_REAGENTS) do
        for _, id in ipairs(items) do
            if id == itemID then
                table.insert(professionIDs, key)
                break
            end
        end
    end

    return professionIDs
end

function ItemEra.Utils:GetProfessionTextByProfessionID(professionID)
    local spellID = ItemEra.Utils.ProfessionName[professionID]
    if not spellID then return "ID: " .. professionID end

    local spellInfo = C_Spell.GetSpellInfo(spellID)
    if not spellInfo then return "ID: " .. professionID end

    local icon = spellInfo.iconID and ("|T" .. spellInfo.iconID .. ":14:14|t") or ""
    return icon .. " " .. spellInfo.name
end

-- External addons (Bagnon / Baganator)

-- Baganator
function ItemEra.Utils:IsBaganatorLoaded()
    local isLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded
    if isLoaded then
        local loaded = select(2, isLoaded("Baganator"))
        return loaded == true
    end
    return false
end

-- Verificar si Baganator existe (puede no estar cargado aún)
function ItemEra.Utils:DoesBaganatorExist()
    local doesExist = C_AddOns and C_AddOns.DoesAddOnExist or DoesAddOnExist
    if doesExist then
        return doesExist("Baganator")
    end
    return false
end

-- Bagnon
function ItemEra.Utils:IsBagnonLoaded()
    local isLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded
    if isLoaded then
        local loaded = select(2, isLoaded("Bagnon"))
        return loaded == true
    end
    return false
end

function ItemEra.Utils:DoesBagnonExist()
    local doesExist = C_AddOns and C_AddOns.DoesAddOnExist or DoesAddOnExist
    if doesExist then
        return doesExist("Bagnon")
    end
    return false
end
