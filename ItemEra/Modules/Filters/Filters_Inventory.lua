local addonName, ItemEra = ...

local FiltersUtils = ItemEra.Filters_Utils
local FiltersInventory = {}

local InventoryFilterDropdown = nil
local inventoryExpansionFilter = nil

local function ForEachInventory(containerFrame, expansionID)
    if containerFrame and containerFrame:IsShown() then
        for itemIndex = 1, containerFrame.size do
            local itemButton = containerFrame.Items[itemIndex]
            if itemButton then
                local itemInfo = C_Container.GetContainerItemInfo(itemButton:GetBagID(), itemButton:GetID())
                if itemInfo and itemInfo.itemID then
                    local item = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
                    FiltersUtils.ToggleButtonMatch(itemButton, item and item.expansionID or nil, expansionID)
                end
            end
        end
    end
end


function FiltersInventory.Update(expansionID)
    local containerFrameCombinedBags = _G["ContainerFrameCombinedBags"]
    ForEachInventory(containerFrameCombinedBags, expansionID)

    if containerFrameCombinedBags and containerFrameCombinedBags:IsShown() then
        local containerFrame = _G["ContainerFrame" .. Enum.BagIndex.ReagentBag + 1]
        ForEachInventory(containerFrame, expansionID)
    else
        for frameIndex = 1, NUM_CONTAINER_FRAMES do
            local containerFrame = _G["ContainerFrame" .. frameIndex]
            ForEachInventory(containerFrame, expansionID)
        end
    end
end

function FiltersInventory.Reset()
    FiltersInventory.Update(nil)
    inventoryExpansionFilter = nil
    if InventoryFilterDropdown then InventoryFilterDropdown:Reset() end
end

function FiltersInventory:Initialize()
    hooksecurefunc("OpenBag", function()
        local searchBox = _G["BagItemSearchBox"]
        if searchBox and searchBox:IsShown() then
            searchBox:SetWidth(160)
            if not InventoryFilterDropdown then
                local dropdownParams = { x = 180, y = 0, }
                InventoryFilterDropdown = FiltersUtils.CreateDropdown(searchBox, "InventoryFilterDropdown",
                    dropdownParams, inventoryExpansionFilter,
                    function(expansionID)
                        inventoryExpansionFilter = expansionID
                        FiltersInventory.Update(expansionID)
                    end)
            else
                InventoryFilterDropdown:Show()
            end
        end
    end)

    hooksecurefunc("CloseBag", FiltersInventory.Reset)
end

ItemEra.FiltersInventory = FiltersInventory
