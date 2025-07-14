local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Tooltip = {}

function ItemEra.Tooltip:AddExpansionTooltipLine(tooltip)
    if not tooltip or not tooltip.GetItem then return end

    local _, itemLink = tooltip:GetItem()
    if itemLink then
        local itemID = tonumber(string.match(itemLink, "item:(%d*)"))
        if itemID then
            local expansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            if expansionID and ItemEra.Utils.ExpansionColors[expansionID] and ItemEra.Utils.ExpansionNames[expansionID] then
                local r, g, b = unpack(ItemEra.Utils.ExpansionColors[expansionID])
                tooltip:AddLine(" ")
                local icon = ItemEra.Utils:GetExpansionLogoById(expansionID)
                local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)
                tooltip:AddLine(L["TOOLTIP.ORIGIN"] .. "  " ..
                    ("%s |cff%02x%02x%02x%s|r"):format(iconMarkup, r * 255, g * 255, b * 255,
                        ItemEra.Utils.ExpansionNames[expansionID]))
                tooltip:Show()
            end
        end
    end
end

function ItemEra.Tooltip:Initialize()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip)
        ItemEra.Tooltip:AddExpansionTooltipLine(tooltip)
    end)
end
