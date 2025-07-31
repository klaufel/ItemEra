local _, ItemEra = ...

local FiltersUtils = ItemEra.Filters_Utils

local FiltersBank = {}

local BankFilterDropdown = nil
local bankExpansionFilter = nil


function FiltersBank.HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    for slot = 1, maxSlots do
        local itemLink = C_Container.GetContainerItemLink(containerID, slot)
        local button = _G[buttonNamePattern .. slot]
        local itemExpansionID = nil
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                itemExpansionID = select(1, ItemEra.ItemData:GetItemExpansionID(itemID))
            end
        end
        FiltersUtils.ToggleButtonMatch(button, itemExpansionID, expansionID)
    end
end

function FiltersBank.HighlightByExpansion(expansionID)
    FiltersBank.HighlightContainerByExpansion(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS, "BankFrameItem", expansionID)
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        FiltersBank.HighlightContainerByExpansion(REAGENTBANK_CONTAINER, 98, "ReagentBankFrameItem", expansionID)
    end
    if AccountBankPanel and AccountBankPanel:IsShown() and AccountBankPanel.EnumerateValidItems then
        for itemButton in AccountBankPanel:EnumerateValidItems() do
            local bankTabID = itemButton.GetBankTabID and itemButton:GetBankTabID() or nil
            local containerSlotID = itemButton.GetContainerSlotID and itemButton:GetContainerSlotID() or nil
            local itemInfo = (C_Container and C_Container.GetContainerItemInfo and bankTabID and containerSlotID)
                and C_Container.GetContainerItemInfo(bankTabID, containerSlotID) or nil
            local itemExpansionID = nil
            if itemInfo and itemInfo.itemID then
                itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
            end
            FiltersUtils.SetButtonHighlight(itemButton, itemExpansionID, expansionID)
        end
    end
end

function FiltersBank.Update()
    print("FiltersBank.Update()")
end

function FiltersBank.Reset()
    FiltersBank.HighlightByExpansion(nil)
    bankExpansionFilter = nil
    if BankFilterDropdown then BankFilterDropdown:Reset() end
end

function FiltersBank:Initialize()
    print('init')
    ItemEra:RegisterEvent("BANK_TABS_CHANGED", function(event, arg, rest)
        print(event, arg, rest)
    end)
end

ItemEra.FiltersBank_11_2 = FiltersBank
