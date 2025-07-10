local addonName, addon = ...
ItemEra.Filters = {}

local ItemEraSaved = ItemEraSaved or {}

local L = addon.L or {}

local function HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    for slot = 1, maxSlots do
        local itemLink
        if C_Container and C_Container.GetContainerItemLink then
            itemLink = C_Container.GetContainerItemLink(containerID, slot)
        else
            itemLink = GetContainerItemLink(containerID, slot)
        end
        local button = _G[buttonNamePattern .. slot]
        if button then
            if itemLink then
                local itemID = tonumber(itemLink:match("item:(%d+)"))
                if itemID then
                    local itemExpansionID = select(15, GetItemInfo(itemID))
                    if itemExpansionID and itemExpansionID ~= expansionID then
                        if button.searchOverlay then
                            button.searchOverlay:Show()
                        elseif button.SetMatchesSearch then
                            button:SetMatchesSearch(false)
                        end
                    else
                        if button.searchOverlay then
                            button.searchOverlay:Hide()
                        elseif button.SetMatchesSearch then
                            button:SetMatchesSearch(true)
                        end
                    end
                end
            else
                if button.searchOverlay then
                    button.searchOverlay:Hide()
                elseif button.SetMatchesSearch then
                    button:SetMatchesSearch(true)
                end
            end
        end
    end
end

local function HighlightAccountBankByExpansion(expansionID)
    if not AccountBankPanel or not AccountBankPanel:IsShown() then
        return
    end
    if not AccountBankPanel.EnumerateValidItems then return end

    for itemButton in AccountBankPanel:EnumerateValidItems() do
        local bankTabID = itemButton.GetBankTabID and itemButton:GetBankTabID() or nil
        local containerSlotID = itemButton.GetContainerSlotID and itemButton:GetContainerSlotID() or nil
        local itemInfo = (C_Container and C_Container.GetContainerItemInfo and bankTabID and containerSlotID) and
            C_Container.GetContainerItemInfo(bankTabID, containerSlotID) or nil
        if itemInfo and itemInfo.itemID then
            local itemExpansionID = select(15, GetItemInfo(itemInfo.itemID))
            if expansionID then
                if itemExpansionID and itemExpansionID ~= expansionID then
                    if itemButton.SetMatchesSearch then
                        itemButton:SetMatchesSearch(false)
                    end
                else
                    if itemButton.SetMatchesSearch then
                        itemButton:SetMatchesSearch(true)
                    end
                end
            else
                if itemButton.SetMatchesSearch then
                    itemButton:SetMatchesSearch(true)
                end
            end
        end
    end
end

local function ClearAccountBankHighlight()
    if not AccountBankPanel or not AccountBankPanel.EnumerateValidItems then return end
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        if itemButton.SetMatchesSearch then
            itemButton:SetMatchesSearch(true)
        end
    end
end

function ItemEra.Filters:HighlightBankByExpansion(expansionID)
    ItemEra.Filters:ClearBankHighlight()
    if not expansionID then return end
    HighlightContainerByExpansion(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS, "BankFrameItem", expansionID)
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        HighlightContainerByExpansion(REAGENTBANK_CONTAINER, 98, "ReagentBankFrameItem", expansionID)
    end
    if AccountBankPanel and AccountBankPanel:IsShown() then
        HighlightAccountBankByExpansion(expansionID)
    end
end

function ItemEra.Filters:ClearBankHighlight()
    for slot = 1, NUM_BANKGENERIC_SLOTS do
        local button = _G["BankFrameItem" .. slot]
        if button and button.searchOverlay then
            button.searchOverlay:Hide()
        end
    end
    for slot = 1, 98 do
        local button = _G["ReagentBankFrameItem" .. slot]
        if button and button.searchOverlay then
            button.searchOverlay:Hide()
        end
    end
    ClearAccountBankHighlight()
end

function ItemEra.Filters:CreateFilterDropdown(parent)
    local dropdown = CreateFrame("Frame", "ItemEraBankFilterDropdown", parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", parent, "TOPLEFT", 38, -24)
    local L = L or {}
    local function CreateMenuItems()
        local items = {}
        table.insert(items, {
            text = L["COMMON.ALL_EXPANSION"],
            func = function()
                ItemEraSaved.bankExpansionFilter = nil
                UIDropDownMenu_SetText(dropdown, L["COMMON.ALL_EXPANSION"])
                ItemEra.Filters:ClearBankHighlight()
            end,
            checked = (ItemEraSaved.bankExpansionFilter == nil)
        })
        table.insert(items, { isSeparator = true })
        for _, expansion in ipairs(ItemEra.Utils:GetExpansionsInOrder()) do
            local id, name = expansion.id, expansion.name
            local icon = "Interface/AddOns/ItemEra/Media/Icons/Exp_Logo_" .. id .. ".tga"
            local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)
            table.insert(items, {
                text = iconMarkup .. " " .. name,
                func = function()
                    ItemEraSaved.bankExpansionFilter = id
                    UIDropDownMenu_SetText(dropdown, iconMarkup .. " " .. name)
                    ItemEra.Filters:HighlightBankByExpansion(id)
                end,
                checked = (ItemEraSaved.bankExpansionFilter == id)
            })
        end
        return items
    end
    UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
        for _, item in ipairs(CreateMenuItems()) do
            local info = UIDropDownMenu_CreateInfo()
            for k, v in pairs(item) do info[k] = v end
            UIDropDownMenu_AddButton(info)
        end
    end)
    UIDropDownMenu_SetWidth(dropdown, 140)
    if ItemEraSaved.bankExpansionFilter == nil then
        UIDropDownMenu_SetText(dropdown, L["COMMON.ALL_EXPANSION"])
    else
        for _, expansion in ipairs(ItemEra.Utils:GetExpansionsInOrder()) do
            if expansion.id == ItemEraSaved.bankExpansionFilter then
                local icon = "Interface/AddOns/ItemEra/Media/Icons/Exp_Logo_" .. expansion.id .. ".tga"
                local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)
                UIDropDownMenu_SetText(dropdown, iconMarkup .. " " .. expansion.name)
                break
            end
        end
    end
    if _G["ItemEraBankFilterDropdownText"] and _G["ItemEraBankFilterDropdownText"].SetJustifyH then
        _G["ItemEraBankFilterDropdownText"]:SetJustifyH("LEFT")
    end
    dropdown:Show()
    return dropdown
end

function ItemEra.Filters:ResetFilters()
    ItemEraSaved.bankExpansionFilter = nil
    ItemEra.Filters:ClearBankHighlight()
    if ItemEraBankFilterDropdown then
        UIDropDownMenu_SetText(ItemEraBankFilterDropdown, L["COMMON.SELECT_EXPANSION"])
    end
end

function ItemEra.Filters:UpdateBankFilters()
    if ItemEraSaved.bankExpansionFilter then
        ItemEra.Filters:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
    else
        ItemEra.Filters:ClearBankHighlight()
    end
end

function ItemEra.Filters:Initialize()
    ItemEra:RegisterEvent("BANKFRAME_CLOSED", ItemEra.Filters.ResetFilters)

    ItemEra:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("BANK_TAB_SETTINGS_UPDATED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("BANK_TABS_CHANGED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("PLAYERBANKSLOTS_CHANGED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("REAGENTBANK_PURCHASED", ItemEra.Filters.UpdateBankFilters)
    ItemEra:RegisterEvent("REAGENTBANK_UPDATE", ItemEra.Filters.UpdateBankFilters)

    ItemEra:RegisterEvent("BAG_UPDATE_DELAYED", function(self, event, bagID)
        C_Timer.After(0.01, function()
            ItemEra.Filters:UpdateBankFilters()
        end)
    end)

    ItemEra:RegisterEvent("BAG_UPDATE", function(self, event, bagID)
        C_Timer.After(0.01, function()
            ItemEra.Filters:UpdateBankFilters()
        end)
    end)

    hooksecurefunc(AccountBankPanel, "SelectTab", function()
        ItemEra.Filters:UpdateBankFilters()
    end)

    ItemEra:RegisterEvent("BANKFRAME_OPENED", function()
        if not ItemEraBankFilterDropdown then
            ItemEra.Filters:CreateFilterDropdown(BankFrame)
        else
            ItemEraBankFilterDropdown:Show()
        end
        ItemEra.Filters:UpdateBankFilters()
        ReagentBankFrame:HookScript("OnShow", ItemEra.Filters.UpdateBankFilters)
        hooksecurefunc(AccountBankPanel, "Show", ItemEra.Filters.UpdateBankFilters)
    end)
end
