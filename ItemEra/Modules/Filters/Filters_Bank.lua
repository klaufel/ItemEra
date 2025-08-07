local _, ItemEra = ...

local FiltersUtils = ItemEra.Filters_Utils

local FiltersBank = {}

local bankFilterDropdown = nil
local bankExpansionFilter = nil

function FiltersBank.Update(expansionID)
    if BankPanel and BankPanel:IsShown() and BankPanel.EnumerateValidItems then
        for itemButton in BankPanel:EnumerateValidItems() do
            local bankTabID = BankPanel:GetSelectedTabID() or nil
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

function FiltersBank.Reset()
    FiltersBank.Update(nil)
    bankExpansionFilter = nil
    if bankFilterDropdown then bankFilterDropdown:Reset() end
end

function FiltersBank:Initialize()
    if BankPanel and BankPanel.RegisterCallback then
        BankPanel:RegisterCallback(BankPanel.Event.NewBankTabSelected, function()
            FiltersBank.Update(bankExpansionFilter)
        end, FiltersBank)
    end


    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.Banker then return end
        if not bankFilterDropdown then
            local dropdownParams = { x = 72, y = -28, width = 180 }
            bankFilterDropdown = FiltersUtils.CreateDropdown(BankPanel, "bankFilterDropdown",
                dropdownParams, bankExpansionFilter,
                function(expansionID)
                    bankExpansionFilter = expansionID
                    FiltersBank.Update(expansionID)
                end)
        else
            bankFilterDropdown:Show()
        end
    end)

    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_HIDE", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.Banker then return end
        FiltersBank.Reset()
    end)


    ItemEra:RegisterEvent("BAG_UPDATE_DELAYED", function()
        FiltersBank.Update(bankExpansionFilter)
    end)
end

ItemEra.Filters_Bank = FiltersBank
