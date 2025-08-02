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
                local item = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
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
            FiltersUtils.SetButtonHighlight(itemButton, itemExpansionID, expansionID)
        end
    end
end

function FiltersBank.Update()
    print("FiltersBank.Update()")
end

function FiltersBank.Reset()
    -- FiltersBank.HighlightByExpansion(nil)
    -- bankExpansionFilter = nil
    if BankFilterDropdown then BankFilterDropdown:Reset() end
end

function FiltersBank:Initialize()
    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.Banker then return end
        if not BankFilterDropdown then
            local dropdownParams = { x = 18, y = -28, width = 200 }

            BankFilterDropdown = FiltersUtils.CreateDropdown(BankFrame, "BankFilterDropdown",
                dropdownParams, guildBankExpansionFilter,
                function(self, expansionID)
                    bankExpansionFilter = expansionID
                    BankFilterDropdown:Update()
                end)
        else
            BankFilterDropdown:Show()
        end
    end)

    ItemEra:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE', function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.Banker then return end
        FiltersBank.Reset()
    end)

    ItemEra:RegisterEvent("BANK_TABS_CHANGED", function(event, arg, rest)
        print(event, arg, rest)
    end)
end

ItemEra.FiltersBank_11_2 = FiltersBank
