local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Tooltip = {}

local DEBUG = ItemEra.Config.debug
local DISABLED_DB = ItemEra.Config.disabledDB

local TOOLTIP_DATA_TYPES = {
    ITEM = Enum.TooltipDataType.Item,
    TOY = Enum.TooltipDataType.Toy
}

local function GetExpansionTextByItemID(itemID)
    local expansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
    if not expansionID then return end

    local expansionColor = ItemEra.Utils.ExpansionColors[expansionID]
    local expansionName = ItemEra.Utils.ExpansionNames[expansionID]
    if not expansionColor or not expansionName then return end

    local r, g, b = unpack(expansionColor)
    local logo = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(ItemEra.Utils:GetExpansionLogoById(expansionID))

    return L["TOOLTIP.EXPANSION"] .. "  " .. ("%s |cff%02x%02x%02x%s|r"):format(logo, r, g, b, expansionName)
end

local function AddExpansionLine(tooltip, itemID)
    if not tooltip or not itemID then return end

    local expansionText = GetExpansionTextByItemID(itemID)
    if not expansionText then return end

    tooltip:AddLine(" ")
    tooltip:AddLine(expansionText)
    if (DEBUG) then tooltip:AddLine("itemID: " .. itemID) end
    if (DEBUG) then tooltip:AddLine("itemDB: " .. (DISABLED_DB and "Game" or "DB")) end

    tooltip:Show()
end


local function AddTooltipLine(tooltip, data)
    if not tooltip then return end
    local itemID = nil

    if (data.id) then
        itemID = data.id
    elseif tooltip.GetItem then
        local _, itemLink = tooltip:GetItem()
        if not itemLink then return end
        itemID = tonumber(string.match(itemLink, "item:(%d*)"))
    end

    if not itemID then return end
    AddExpansionLine(tooltip, itemID)
end

function ItemEra.Tooltip:Initialize()
    for _, toolipDataType in pairs(TOOLTIP_DATA_TYPES) do
        TooltipDataProcessor.AddTooltipPostCall(toolipDataType, AddTooltipLine)
    end
end
