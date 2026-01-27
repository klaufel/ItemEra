local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Tooltip = {}

local TooltipDataTypes = ItemEra.Utils.TooltipDataTypes

local function AddExpansionLine(tooltip, item)
    if not tooltip or not item then return end

    local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(item.expansionID)
    tooltip:AddLine(" ")
    tooltip:AddLine(expansionText)

    local professionText = ItemEra.Utils:GetProfessionTextByItemID(item.itemID)
    if (professionText and professionText ~= "") then
        tooltip:AddLine(professionText)
    end

    if ItemEra.DB_SETTINGS and ItemEra.DB_SETTINGS.global and ItemEra.DB_SETTINGS.global.settings then
        showProfessionName = ItemEra.DB_SETTINGS.global.settings.showProfessionName
        showProfessionIcon = ItemEra.DB_SETTINGS.global.settings.showProfessionIcon
        showProfessionLiteral = ItemEra.DB_SETTINGS.global.settings.showProfessionLiteral
    end

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

    if (dataType == TooltipDataTypes.MOUNT) then
        local mount = ItemEra.ItemData:GetMountDBVersion(dataID)
        if (mount) then AddExpansionLine(tooltip, mount) end
        return
    end

    if (dataType == TooltipDataTypes.SPELL) then
        local mountID = C_MountJournal.GetMountFromSpell(dataID)
        if not mountID then return end
        local mount = ItemEra.ItemData:GetMountDBVersion(mountID)
        if (mount) then AddExpansionLine(tooltip, mount) end
        return
    end

    if (dataType == TooltipDataTypes.ITEM or dataType == TooltipDataTypes.TOY) then
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
    for _, tooltipDataType in pairs(TooltipDataTypes) do
        TooltipDataProcessor.AddTooltipPostCall(tooltipDataType, ShowTooltip)
    end
end
