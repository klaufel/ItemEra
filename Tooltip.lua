local addonName, addon = ...
local Tooltip = {}
addon.Tooltip = Tooltip

function Tooltip:AddExpansionLine(tooltip)
    if not addon.Config:GetShowExpansionTooltip() then return end
    local _, itemLink = tooltip:GetItem()
    if itemLink then
        local itemID = tonumber(itemLink:match("item:(%d+)"))
        if itemID then
            local expansionID = select(15, GetItemInfo(itemID))
            if expansionID and addon.expansionColors[expansionID] and addon.expansionNames[expansionID] then
                local r, g, b = unpack(addon.expansionColors[expansionID])
                tooltip:AddLine(" ")
                local icon = "Interface/AddOns/ItemEra/icons/Exp_Logo_" .. expansionID .. ".png"
                local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)
                tooltip:AddLine(("%s |cff%02x%02x%02x%s|r"):format(iconMarkup, r * 255, g * 255, b * 255,
                    addon.expansionNames[expansionID]))
                tooltip:Show()
            end
        end
    end
end

function Tooltip:Init()
    hooksecurefunc(GameTooltip, "SetBagItem", function(self)
        Tooltip:AddExpansionLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetInventoryItem", function(self)
        Tooltip:AddExpansionLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetHyperlink", function(self)
        Tooltip:AddExpansionLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetMerchantItem", function(self)
        Tooltip:AddExpansionLine(self)
    end)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(self)
        Tooltip:AddExpansionLine(self)
    end)
    if addon.Highlight and addon.Highlight.Init then
        addon.Highlight:Init()
    end
end
