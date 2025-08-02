local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Filters_Utils = {}

function Filters_Utils.SetButtonHighlight(button, itemExpansionID, expansionID)
    if not button and button.searchOverlay then return end
    if expansionID and itemExpansionID and itemExpansionID ~= expansionID then
        button.searchOverlay:Show()
    else
        button.searchOverlay:Hide()
    end
end

function Filters_Utils.ClearButtonHighlight(button)
    if not button and button.searchOverlay then return end
    button.searchOverlay:Hide()
end

function Filters_Utils.ToggleButtonMatch(button, itemExpansionID, expansionID)
    if not button then return end
    if itemExpansionID and expansionID then
        Filters_Utils.SetButtonHighlight(button, itemExpansionID, expansionID)
    else
        Filters_Utils.ClearButtonHighlight(button)
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

---@class (exact) params
---@field position? string
---@field x? number
---@field y? number
---@field width? number
---@field height? number
---@param value string|nil
---@param onChange function
function Filters_Utils.CreateDropdown(parent, name, params, value, onChange)
    local position = (params and params.position) or "TOPLEFT"
    local positionX = (params and params.x) or 60
    local positionY = (params and params.y) or -30
    local width = (params and params.width) or 140
    local height = (params and params.height) or 22
    local dropdown = CreateFrame("DropdownButton", name, parent, "WowStyle1DropdownTemplate")
    dropdown:SetPoint(position, parent, position, positionX, positionY)
    dropdown:SetWidth(width)
    dropdown:SetHeight(height)
    dropdown:SetDefaultText(L["SELECT_EXPANSION"])


    local function GeneratorFunction(_, rootDescription)
        rootDescription:CreateRadio(
            L["ALL_EXPANSION"],
            function() return value == nil end,
            function()
                value = nil
                if onChange then onChange(nil) end
                dropdown:GenerateMenu()
            end
        )

        rootDescription:CreateDivider()

        for _, expansion in ipairs(ItemEra.Utils:GetExpansionsInOrder()) do
            local id, name = expansion.id, expansion.name
            local icon = ItemEra.Utils:GetExpansionLogoById(id)
            local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)

            rootDescription:CreateRadio(
                iconMarkup .. " " .. name,
                function() return value == id end,
                function()
                    value = id
                    if onChange then onChange(id) end
                    dropdown:GenerateMenu()
                end
            )
        end
    end

    dropdown:SetupMenu(GeneratorFunction)
    dropdown:Show()
    dropdown.Reset = function()
        value = nil
        dropdown:SetDefaultText(L["SELECT_EXPANSION"])
        dropdown:GenerateMenu()
    end
    return dropdown
end

ItemEra.Filters_Utils = Filters_Utils
