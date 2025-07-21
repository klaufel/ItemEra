local _, ItemEra = ...
local Filters_Utils = {}

function Filters_Utils.SetButtonHighlight(button, itemExpansionID, expansionID)
    if not button then return end
    if expansionID and itemExpansionID and itemExpansionID ~= expansionID then
        if button.searchOverlay and not button.searchOverlay:IsShown() then
            button.searchOverlay:Show()
        elseif button.SetMatchesSearch then
            button:SetMatchesSearch(false)
        end
    else
        if button.searchOverlay and button.searchOverlay:IsShown() then
            button.searchOverlay:Hide()
        elseif button.SetMatchesSearch then
            button:SetMatchesSearch(true)
        end
    end
end

function Filters_Utils.ClearButtonHighlight(button)
    if not button then return end
    if button.searchOverlay and button.searchOverlay:IsShown() then
        button.searchOverlay:Hide()
    elseif button.SetMatchesSearch then
        button:SetMatchesSearch(true)
    end
end

---@class (exact) params
---@field maxSlots number The maximum number of slots allowed.
---@field containerID number The maximum number of slots allowed.
---@field buttonNamePattern string  The maximum number of slots allowed.
---@field getItemLink function The maximum number of slots allowed.
---@param callback function Función que recibe (button, itemLink, slot) y se ejecuta por cada botón
function Filters_Utils.IterateBankButtons(params, callback)
    for slot = 1, params.maxSlots do
        local itemLink = params.getItemLink(params.containerID, slot)
        local button = _G[params.buttonNamePattern .. slot]
        callback(button, itemLink, slot)
    end
end

ItemEra.Filters_Utils = Filters_Utils
