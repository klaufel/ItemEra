local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Tooltip = {}

local TOOLTIP_DATA_TYPES = {
    ITEM = Enum.TooltipDataType.Item,
    TOY = Enum.TooltipDataType.Toy,
    MOUNT = Enum.TooltipDataType.Mount,
}

local function GetExpansionTextByExpansionID(expansionID)
    if not expansionID then return end

    local expansionColor = ItemEra.Utils.ExpansionColors[expansionID]
    local expansionName = ItemEra.Utils.ExpansionNames[expansionID]
    if not expansionColor or not expansionName then return end

    local r, g, b = unpack(expansionColor)
    local imageSize = "14:14"
    local image = "|T%s:" .. imageSize .. ":0:0:64:64:4:60:4:60|t"
    local logo = (image):format(ItemEra.Utils:GetExpansionLogoById(expansionID))

    return L["EXPANSION"] .. "  " .. ("%s |cff%02x%02x%02x%s|r"):format(logo, r, g, b, expansionName)
end

local function AddExpansionLine(tooltip, item)
    if not tooltip or not item then return end

    local expansionText = GetExpansionTextByExpansionID(item.expansionID)
    tooltip:AddLine(" ")
    tooltip:AddLine(expansionText)


    -- if ItemEra.CONFIG.VERSION_MAJOR == 11 and ItemEra.CONFIG.VERSION_MINOR >= 2 then
    --     if (item.expansionPatchShort or item.expansionPatchName) then
    --         local expansionPatchName = item.expansionPatchName or ""
    --         local expansionPatchText = item.expansionPatchShort and "(" .. item.expansionPatchShort .. ")" or ""
    --         tooltip:AddLine(expansionPatchName .. " " .. expansionPatchText, 255, 255, 255)
    --     end
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

    if ItemEra.CONFIG.VERSION_MAJOR == 11 and ItemEra.CONFIG.VERSION_MINOR >= 2 then
        if (dataType == TOOLTIP_DATA_TYPES.MOUNT) then
            local mount = ItemEra.ItemData:GetMountDBVersion(dataID)
            if (mount) then AddExpansionLine(tooltip, mount) end

            return
        end
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
    end
end

function ItemEra.Tooltip:Initialize()
    for _, tooltipDataType in pairs(TOOLTIP_DATA_TYPES) do
        TooltipDataProcessor.AddTooltipPostCall(tooltipDataType, AddTooltipLine)
    end
end
