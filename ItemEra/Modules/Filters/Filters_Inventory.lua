local addonName, ItemEra = ...

local FiltersUtils = ItemEra.Filters_Utils
local FiltersInventory = {}

local InventoryFilterDropdown = nil
local inventoryExpansionFilter = nil

local memoizedContainerFrame1 = nil
local memoizedContainerFrameCombinedBags = nil

local function ForEachInventory(containerFrame, expansionID, force)
    if containerFrame and (force or containerFrame:IsShown()) and type(containerFrame.size) == "number" then
        for itemIndex = 1, containerFrame.size do
            local itemButton = containerFrame.Items[itemIndex]
            if itemButton then
                local itemInfo = C_Container.GetContainerItemInfo(itemButton:GetBagID(), itemButton:GetID())
                if itemInfo and itemInfo.itemID then
                    local item = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
                    FiltersUtils.ToggleButtonMatch(itemButton, item and item.expansionID or nil, expansionID)
                else
                    FiltersUtils.ToggleButtonMatch(itemButton, nil, expansionID)
                end
            end
        end
    end
end

function FiltersInventory.Update(expansionID, force)
    local containerFrameCombinedBags = _G["ContainerFrameCombinedBags"]
    ForEachInventory(containerFrameCombinedBags, expansionID, force)

    if containerFrameCombinedBags and containerFrameCombinedBags:IsShown() then
        local containerFrame = _G["ContainerFrame" .. Enum.BagIndex.ReagentBag + 1]
        ForEachInventory(containerFrame, expansionID, force)
    else
        for frameIndex = 1, NUM_CONTAINER_FRAMES do
            local containerFrame = _G["ContainerFrame" .. frameIndex]
            ForEachInventory(containerFrame, expansionID, force)
        end
    end
end

function FiltersInventory.Reset()
    FiltersInventory.Update(nil, true)
    inventoryExpansionFilter = nil
    if InventoryFilterDropdown then InventoryFilterDropdown:Reset() end
end

local function Initialize()
    local containerFrameCombinedBags = _G["ContainerFrameCombinedBags"]
    local containerFrame1 = _G["ContainerFrame1"]

    local isCombinedBags = containerFrameCombinedBags:IsShown() == true and containerFrame1:IsShown() == false

    if isCombinedBags then
        if not memoizedContainerFrameCombinedBags then
            memoizedContainerFrameCombinedBags = containerFrameCombinedBags:GetHeight()
        end
        containerFrameCombinedBags:SetHeight(memoizedContainerFrameCombinedBags + 40)
    else
        if not memoizedContainerFrame1 then
            memoizedContainerFrame1 = containerFrame1:GetHeight()
        end
        containerFrame1:SetHeight(memoizedContainerFrame1 + 20)
    end


    local dropdownParams = { position = "TOPRIGHT", width = 160, x = -12, y = -64 }
    if not InventoryFilterDropdown then
        InventoryFilterDropdown = FiltersUtils.CreateDropdown(containerFrameCombinedBags, "InventoryFilterDropdown",
            dropdownParams, inventoryExpansionFilter,
            function(expansionID)
                inventoryExpansionFilter = expansionID
                FiltersInventory.Update(expansionID)
            end)
    else
        if isCombinedBags then
            InventoryFilterDropdown:ClearAllPoints()
            InventoryFilterDropdown:SetParent(containerFrameCombinedBags)
            InventoryFilterDropdown:SetWidth(160)
            InventoryFilterDropdown:SetPoint("TOPRIGHT", containerFrameCombinedBags, "TOPRIGHT", -12, -64)
        else
            InventoryFilterDropdown:ClearAllPoints()
            InventoryFilterDropdown:SetParent(containerFrame1)
            InventoryFilterDropdown:SetWidth(120)
            InventoryFilterDropdown:SetPoint("TOPRIGHT", containerFrame1, "TOPRIGHT", -12, -64)
        end
        InventoryFilterDropdown:Show()
    end
end

function FiltersInventory:Initialize()
    hooksecurefunc("OpenBag", function() Initialize() end)
    hooksecurefunc("CloseBag", function() FiltersInventory.Reset() end)

    local events = {
        "BAG_UPDATE_DELAYED",
        "ITEM_LOCK_CHANGED",
    }
    for _, event in ipairs(events) do
        ItemEra:RegisterEvent(event, function()
            if (inventoryExpansionFilter) then
                FiltersInventory.Update(inventoryExpansionFilter)
            end
        end)
    end
end

ItemEra.Filters_Inventory = FiltersInventory
