local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Tooltip = {}

local TOOLTIP_DATA_TYPES = {
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

local function AddExpansionLine(tooltip, item)
    if not tooltip or not item then return end

    local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(item.expansionID)
    tooltip:AddLine(" ")
    tooltip:AddLine(expansionText)

    -- if (item.expansionPatchShort or item.expansionPatchName) then
    --     local expansionPatchName = item.expansionPatchName or ""
    --     local expansionPatchText = item.expansionPatchShort and "(" .. item.expansionPatchShort .. ")" or ""
    --     tooltip:AddLine(expansionPatchName .. " " .. expansionPatchText, 255, 255, 255)
    -- end

    if (ItemEra.CONFIG.DEBUG) then
        tooltip:AddLine(" ")
        tooltip:AddLine("ID: " .. item.itemID)
        tooltip:AddLine("Origin: " .. (item.origin) .. (ItemEra.CONFIG.DISABLED_DB and " (DISABLED_DB)" or ""))
    end

    tooltip:Show()
end


local function AddTooltipLine(tooltip, data)
    if not tooltip then return end
    local itemID = nil

    local dataType = data.type
    local dataID = data.id

    if (dataType == TOOLTIP_DATA_TYPES.MOUNT) then
        local mount = ItemEra.ItemData:GetMountDBVersion(dataID)
        if (mount) then AddExpansionLine(tooltip, mount) end
        return
    end

    if (dataType == TOOLTIP_DATA_TYPES.SPELL) then
        local mountID = C_MountJournal.GetMountFromSpell(dataID)
        if not mountID then return end
        local mount = ItemEra.ItemData:GetMountDBVersion(mountID)
        if (mount) then AddExpansionLine(tooltip, mount) end
        return
    end

    if (dataType == TOOLTIP_DATA_TYPES.ITEM or dataType == TOOLTIP_DATA_TYPES.TOY) then
        if (dataID) then
            itemID = dataID
        elseif tooltip.GetItem then
            local _, itemLink = tooltip:GetItem()
            if not itemLink then return end
            itemID = tonumber(string.match(itemLink, "item:(%d*)"))
        end

        if not itemID then return end

        local item = ItemEra.ItemData:GetItemExpansionID(itemID)
        if (item) then AddExpansionLine(tooltip, item) end
        return
    end
end

local function ShowTooltip(tooltip, data)
    local isTooltipEnabled = true
    if ItemEra.DB_SETTINGS.global.settings.useKeyModifier then
        isTooltipEnabled = false
        local keyModifier = ItemEra.DB_SETTINGS.global.settings.keyModifier or ItemEra.Utils.KeyModifiers.SHIFT

        if keyModifier == ItemEra.Utils.KeyModifiers.SHIFT then
            isTooltipEnabled = IsShiftKeyDown()
        elseif keyModifier == ItemEra.Utils.KeyModifiers.CTRL then
            isTooltipEnabled = IsControlKeyDown()
        elseif keyModifier == ItemEra.Utils.KeyModifiers.ALT then
            isTooltipEnabled = IsAltKeyDown()
        end
    end

    if isTooltipEnabled then
        AddTooltipLine(tooltip, data)
    end
end


function ItemEra.Tooltip:Initialize()
    for _, tooltipDataType in pairs(TOOLTIP_DATA_TYPES) do
        TooltipDataProcessor.AddTooltipPostCall(tooltipDataType, ShowTooltip)
    end
end
