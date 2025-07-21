local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local FiltersUtils = ItemEra.Filters_Utils
local FiltersBank = ItemEra.Filters_Bank
local FiltersGuildBank = ItemEra.Filters_GuildBank

local ItemEraSaved = {}

local ItemEraGuildBankFilterDropdown = nil

ItemEra.Filters = {}

local function ClearBankHighlight()
    FiltersBank.ClearBankHighlight(NUM_BANKGENERIC_SLOTS, "BankFrameItem")
    FiltersBank.ClearBankHighlight(98, "ReagentBankFrameItem")
    if AccountBankPanel and AccountBankPanel.EnumerateValidItems then
        for itemButton in AccountBankPanel:EnumerateValidItems() do
            FiltersUtils.ClearButtonHighlight(itemButton)
        end
    end
    FiltersGuildBank.ClearGuildBankHighlight()
end

local function HighlightBankByExpansion(expansionID)
    ClearBankHighlight()
    if not expansionID then return end
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
    if GuildBankFrame and GuildBankFrame:IsShown() then
        FiltersGuildBank.HighlightGuildBankByExpansion(expansionID)
    end
end

function CreateFilterDropdown(parent, name, params)
    local name = name or "ItemEraBankFilterDropdown"
    local positionX = (params and params.x) or 60
    local positionY = (params and params.y) or -30
    local width = (params and params.width) or 140
    local height = (params and params.height) or 22
    local dropdown = CreateFrame("DropdownButton", name, parent, "WowStyle1DropdownTemplate")
    dropdown:SetPoint("TOPLEFT", parent, "TOPLEFT", positionX, positionY)
    dropdown:SetWidth(width)
    dropdown:SetHeight(height)
    dropdown:SetDefaultText(L["COMMON.SELECT_EXPANSION"])

    local function GeneratorFunction(owner, rootDescription)
        rootDescription:CreateRadio(
            L["COMMON.ALL_EXPANSION"] or "All Expansions",
            function() return ItemEraSaved.bankExpansionFilter == nil end,
            function()
                ItemEraSaved.bankExpansionFilter = nil
                ClearBankHighlight()
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
                function() return ItemEraSaved.bankExpansionFilter == id end,
                function()
                    ItemEraSaved.bankExpansionFilter = id
                    HighlightBankByExpansion(id)
                    dropdown:GenerateMenu()
                end
            )
        end
    end

    dropdown:SetupMenu(GeneratorFunction)
    dropdown:Show()
    return dropdown
end

local function ResetFilters()
    ItemEraSaved.bankExpansionFilter = nil
    ClearBankHighlight()
    if ItemEraBankFilterDropdown then
        ItemEraBankFilterDropdown:SetDefaultText(L["COMMON.SELECT_EXPANSION"])
        ItemEraBankFilterDropdown:GenerateMenu()
    end
end

function UpdateBankFilters()
    if ItemEraSaved.bankExpansionFilter then
        HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
    else
        ClearBankHighlight()
    end
end

function ItemEra.Filters:Initialize()
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
        "GUILDBANKBAGSLOTS_CHANGED"
    }
    for _, event in ipairs(updateBankFiltersEvents) do
        ItemEra:RegisterEvent(event, UpdateBankFilters)
    end

    ItemEra:RegisterEvent("BANKFRAME_CLOSED", ResetFilters)

    ItemEra:RegisterEvent("BAG_UPDATE_DELAYED", function()
        C_Timer.After(0.01, function()
            UpdateBankFilters()
        end)
    end)

    ItemEra:RegisterEvent("BAG_UPDATE", function()
        C_Timer.After(0.01, function()
            UpdateBankFilters()
        end)
    end)

    hooksecurefunc(AccountBankPanel, "SelectTab", function()
        UpdateBankFilters()
    end)

    ItemEra:RegisterEvent("BANKFRAME_OPENED", function()
        if not ItemEraBankFilterDropdown then
            CreateFilterDropdown(BankFrame)
        else
            ItemEraBankFilterDropdown:Show()
        end
        UpdateBankFilters()
        ReagentBankFrame:HookScript("OnShow", UpdateBankFilters)
        hooksecurefunc(AccountBankPanel, "Show", UpdateBankFilters)
    end)

    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.GuildBanker then return end
        if not ItemEraGuildBankFilterDropdown then
            local dropdownParams = { x = 18, y = -28, width = 200 }
            ItemEraGuildBankFilterDropdown = CreateFilterDropdown(GuildBankFrame,
                "ItemEraGuildBankFilterDropdown", dropdownParams)
        else
            ItemEraGuildBankFilterDropdown:Show()
        end
    end)
end
