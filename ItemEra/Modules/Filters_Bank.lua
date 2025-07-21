-- Filters_Bank.lua
-- Lógica de filtros para banco y reagent bank

local Utils = ItemEra.Filters_Utils
local _, ItemEra = ...

local Filters_Bank = {}

function Filters_Bank.HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    local getItemLink = function(cid, slot)
        if C_Container and C_Container.GetContainerItemLink then
            return C_Container.GetContainerItemLink(cid, slot)
        else
            return GetContainerItemLink(cid, slot)
        end
    end
    for slot = 1, maxSlots do
        local itemLink = getItemLink(containerID, slot)
        local button = _G[buttonNamePattern .. slot]
        local itemExpansionID = nil
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            end
        end
        Utils.SetButtonHighlight(button, itemExpansionID, expansionID)
    end
end

function Filters_Bank.ClearBankHighlight(maxSlots, buttonNamePattern)
    for slot = 1, maxSlots do
        local button = _G[buttonNamePattern .. slot]
        Utils.ClearButtonHighlight(button)
    end
end

ItemEra.Filters_Bank = Filters_Bank
