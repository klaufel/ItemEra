local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Decorations = {}

local ICON_SIZE = 14
local ICON_POSITION = "BOTTOMRIGHT"
local ICON_OFFSET_X = -2
local ICON_OFFSET_Y = 2

local decorationPool = {}

local function CreateDecorationIcon(button)
    local frame = CreateFrame("Frame", nil, button)
    frame:SetSize(ICON_SIZE, ICON_SIZE)
    frame:SetPoint(ICON_POSITION, button, ICON_POSITION, ICON_OFFSET_X, ICON_OFFSET_Y)
    frame:SetFrameStrata("HIGH")

    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)
    frame.texture = texture

    frame:EnableMouse(true)
    frame:SetScript("OnEnter", function(self)
        if self.expansionID then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            local expansionName = ItemEra.Utils.ExpansionNames[self.expansionID]
            if expansionName then
                GameTooltip:AddLine(expansionName, 1, 1, 1)
                GameTooltip:Show()
            end
        end
    end)

    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    frame:Hide()
    return frame
end

local function GetOrCreateDecoration(button)
    if not button then return nil end

    local key = tostring(button)
    if not decorationPool[key] then
        decorationPool[key] = CreateDecorationIcon(button)
    end
    return decorationPool[key]
end

function ItemEra.Decorations:UpdateDecoration(button, itemID)
    if not button then return end

    local decoration = GetOrCreateDecoration(button)
    if not decoration then return end

    if not itemID then
        decoration:Hide()
        return
    end

    local item = ItemEra.ItemData:GetItemExpansionID(itemID)
    if not item or item.expansionID == nil then
        decoration:Hide()
        return
    end

    local iconPath = ItemEra.Utils:GetExpansionLogoById(item.expansionID)
    decoration.texture:SetTexture(iconPath)
    decoration.texture:SetTexCoord(4/64, 60/64, 4/64, 60/64)
    decoration.expansionID = item.expansionID
    decoration:Show()
end

function ItemEra.Decorations:ClearDecoration(button)
    if not button then return end

    local key = tostring(button)
    local decoration = decorationPool[key]
    if decoration then
        decoration:Hide()
    end
end

local function UpdateContainerDecorations(containerFrame)
    if not containerFrame or not containerFrame:IsShown() then return end
    if type(containerFrame.size) ~= "number" then return end

    for itemIndex = 1, containerFrame.size do
        local itemButton = containerFrame.Items and containerFrame.Items[itemIndex]
        if itemButton then
            local itemInfo = C_Container.GetContainerItemInfo(itemButton:GetBagID(), itemButton:GetID())
            if itemInfo and itemInfo.itemID then
                ItemEra.Decorations:UpdateDecoration(itemButton, itemInfo.itemID)
            else
                ItemEra.Decorations:ClearDecoration(itemButton)
            end
        end
    end
end

local function UpdateAllInventoryDecorations()
    if not ItemEra.DB_SETTINGS.global.settings.enabledDecorations then return end

    local containerFrameCombinedBags = _G["ContainerFrameCombinedBags"]
    UpdateContainerDecorations(containerFrameCombinedBags)

    if containerFrameCombinedBags and containerFrameCombinedBags:IsShown() then
        local containerFrame = _G["ContainerFrame" .. Enum.BagIndex.ReagentBag + 1]
        UpdateContainerDecorations(containerFrame)
    else
        for frameIndex = 1, NUM_CONTAINER_FRAMES do
            local containerFrame = _G["ContainerFrame" .. frameIndex]
            UpdateContainerDecorations(containerFrame)
        end
    end
end

local function ClearAllDecorations()
    for _, decoration in pairs(decorationPool) do
        decoration:Hide()
    end
end

function ItemEra.Decorations:Initialize()
    if not ItemEra.DB_SETTINGS.global.settings.enabledDecorations then return end

    hooksecurefunc("OpenBag", function()
        C_Timer.After(0.1, UpdateAllInventoryDecorations)
    end)

    hooksecurefunc("CloseBag", function()
        ClearAllDecorations()
    end)

    local events = {
        "BAG_UPDATE_DELAYED",
        "ITEM_LOCK_CHANGED",
    }

    for _, event in ipairs(events) do
        ItemEra:RegisterEvent(event, function()
            if ItemEra.DB_SETTINGS.global.settings.enabledDecorations then
                UpdateAllInventoryDecorations()
            end
        end)
    end
end
