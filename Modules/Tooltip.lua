local addonName, addon = ...

addon.Tooltip = Tooltip

ItemEra = ItemEra or {}
ItemEra.Tooltip = {}

if not getmetatable(addon.L) then
    setmetatable(addon.L, { __index = function(t, k) return k end })
end

local L = addon.L

function ItemEra.Tooltip:AddExpansionTooltipLine(tooltip)
    local _, itemLink = tooltip:GetItem()
    if itemLink then
        local itemID = tonumber(itemLink:match("item:(%d+)"))
        if itemID then
            local expansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            if expansionID and ItemEra.Utils.ExpansionColors[expansionID] and ItemEra.Utils.ExpansionNames[expansionID] then
                local r, g, b = unpack(ItemEra.Utils.ExpansionColors[expansionID])
                tooltip:AddLine(" ")
                local icon = "Interface/AddOns/ItemEra/Media/Icons/Exp_Logo_" .. expansionID .. ".tga"
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
    hooksecurefunc(GameTooltip, "SetBagItem", function(self)
        ItemEra.Tooltip:AddExpansionTooltipLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetInventoryItem", function(self)
        ItemEra.Tooltip:AddExpansionTooltipLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetHyperlink", function(self)
        ItemEra.Tooltip:AddExpansionTooltipLine(self)
    end)
    hooksecurefunc(GameTooltip, "SetMerchantItem", function(self)
        ItemEra.Tooltip:AddExpansionTooltipLine(self)
    end)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(self)
        ItemEra.Tooltip:AddExpansionTooltipLine(self)
    end)
end
