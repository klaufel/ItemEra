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
                local item = ItemEra.ItemData:GetItemExpansionID(itemID)
                itemExpansionID = item and item.expansionID or nil
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
                local item = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
                itemExpansionID = item and item.expansionID or nil
            end
            FiltersUtils.ToggleButtonMatch(itemButton, itemExpansionID, expansionID)
        end
    end
end

function FiltersBank.Update(expansionID)
    FiltersBank.HighlightByExpansion(expansionID or nil)
end

function FiltersBank.Reset()
    FiltersBank.HighlightByExpansion(nil)
    bankExpansionFilter = nil
    if BankFilterDropdown then BankFilterDropdown:Reset() end
end

function FiltersBank:Initialize()
    ItemEra:RegisterEvent("BANKFRAME_OPENED", function()
        if not BankFilterDropdown then
            BankFilterDropdown = FiltersUtils.CreateDropdown(BankFrame, "BankFilterDropdown",
                nil, bankExpansionFilter,
                function(expansionID)
                    bankExpansionFilter = expansionID
                    FiltersBank.Update(expansionID)
                end)
        else
            BankFilterDropdown:Show()
        end

        ReagentBankFrame:HookScript("OnShow", function()
            FiltersBank.Update(bankExpansionFilter)
        end)

        hooksecurefunc(AccountBankPanel, "Show", function()
            FiltersBank.Update(bankExpansionFilter)
        end)
    end)

    ItemEra:RegisterEvent("BANKFRAME_CLOSED", FiltersBank.Reset)

    hooksecurefunc(AccountBankPanel, "SelectTab", function()
        FiltersBank.Update(bankExpansionFilter)
    end)


    local updateBankFiltersEvents = {
        "BANK_BAG_SLOT_FLAGS_UPDATED",
        "BANK_TAB_SETTINGS_UPDATED",
        "BANK_TABS_CHANGED",
        "PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
        "PLAYERBANKBAGSLOTS_CHANGED",
        "PLAYERBANKSLOTS_CHANGED",
        "PLAYERREAGENTBANKSLOTS_CHANGED",
        "REAGENTBANK_PURCHASED",
        "REAGENTBANK_UPDATE",
        "BAG_UPDATE_DELAYED",
        "BAG_UPDATE"
    }
    for _, event in ipairs(updateBankFiltersEvents) do
        ItemEra:RegisterEvent(event, function()
            FiltersBank.Update(bankExpansionFilter)
        end)
    end
end

ItemEra.FiltersBank = FiltersBank
