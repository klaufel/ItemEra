local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local ItemEraSaved = ItemEraSaved or {}

ItemEra.Filters = {}

local MAX_GUILDBANK_SLOTS_PER_TAB = 98
local NUM_SLOTS_PER_GUILDBANK_GROUP = 14

-- Auxiliar para marcar o limpiar el highlight de un botón según expansión
local function SetButtonHighlight(button, itemExpansionID, expansionID)
    if not button then return end
    if expansionID and itemExpansionID and itemExpansionID ~= expansionID then
        if button.searchOverlay and not button.searchOverlay:IsShown() then
            button.searchOverlay:Show()
        elseif button.SetMatchesSearch then
            button:SetMatchesSearch(false)
        end
    else
        if button.searchOverlay and button.searchOverlay:IsShown() then
            button.searchOverlay:Hide()
        elseif button.SetMatchesSearch then
            button:SetMatchesSearch(true)
        end
    end
end

local function ClearButtonHighlight(button)
    if not button then return end
    if button.searchOverlay and button.searchOverlay:IsShown() then
        button.searchOverlay:Hide()
    elseif button.SetMatchesSearch then
        button:SetMatchesSearch(true)
    end
end

-- Itera sobre botones de cualquier banco y aplica una función callback
-- params: {containerID, maxSlots, buttonNamePattern, getItemLink}
local function IterateBankButtons(params, callback)
    for slot = 1, params.maxSlots do
        local itemLink = params.getItemLink(params.containerID, slot)
        local button = _G[params.buttonNamePattern .. slot]
        callback(button, itemLink, slot)
    end
end


local function HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    local getItemLink = function(cid, slot)
        if C_Container and C_Container.GetContainerItemLink then
            return C_Container.GetContainerItemLink(cid, slot)
        else
            return GetContainerItemLink(cid, slot)
        end
    end
    for slot = 1, maxSlots do
        local itemLink = getItemLink(containerID, slot)
        local button = _G[buttonNamePattern .. slot]
        local itemExpansionID = nil
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            end
        end
        SetButtonHighlight(button, itemExpansionID, expansionID)
    end
end

local function HighlightAccountBankByExpansion(expansionID)
    if not AccountBankPanel or not AccountBankPanel:IsShown() then return end
    if not AccountBankPanel.EnumerateValidItems then return end
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        local bankTabID = itemButton.GetBankTabID and itemButton:GetBankTabID() or nil
        local containerSlotID = itemButton.GetContainerSlotID and itemButton:GetContainerSlotID() or nil
        local itemInfo = (C_Container and C_Container.GetContainerItemInfo and bankTabID and containerSlotID)
            and C_Container.GetContainerItemInfo(bankTabID, containerSlotID) or nil
        local itemExpansionID = nil
        if itemInfo and itemInfo.itemID then
            itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemInfo.itemID)
        end
        SetButtonHighlight(itemButton, itemExpansionID, expansionID)
    end
end

local function ClearAccountBankHighlight()
    if not AccountBankPanel or not AccountBankPanel.EnumerateValidItems then return end
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        ClearButtonHighlight(itemButton)
    end
end

local function HighlightGuildBankByExpansion(expansionID)
    if not GuildBankFrame or not GuildBankFrame:IsShown() then return end
    local currentTab = GetCurrentGuildBankTab()
    if not currentTab then return end
    for slot = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local itemLink = GetGuildBankItemLink(currentTab, slot)
        local index = (slot - 1) % NUM_SLOTS_PER_GUILDBANK_GROUP + 1
        local column = math.ceil(slot / 14)
        local button = GuildBankFrame.Columns and GuildBankFrame.Columns[column] and
            GuildBankFrame.Columns[column].Buttons and GuildBankFrame.Columns[column].Buttons[index]
        local itemExpansionID = nil
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            end
        end
        SetButtonHighlight(button, itemExpansionID, expansionID)
    end
end

local function ClearGuildBankHighlight()
    if not GuildBankFrame then return end
    for slot = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local index = (slot - 1) % 14 + 1
        local column = math.ceil(slot / 14)
        local button = GuildBankFrame.Columns and GuildBankFrame.Columns[column] and
            GuildBankFrame.Columns[column].Buttons and GuildBankFrame.Columns[column].Buttons[index]
        ClearButtonHighlight(button)
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

    if GuildBankFrame and GuildBankFrame:IsShown() then
        HighlightGuildBankByExpansion(expansionID)
    end
end

function ItemEra.Filters:ClearBankHighlight()
    for slot = 1, NUM_BANKGENERIC_SLOTS do
        local button = _G["BankFrameItem" .. slot]
        ClearButtonHighlight(button)
    end
    for slot = 1, 98 do
        local button = _G["ReagentBankFrameItem" .. slot]
        ClearButtonHighlight(button)
    end
    ClearAccountBankHighlight()
    ClearGuildBankHighlight()
end

function ItemEra.Filters:CreateFilterDropdown(parent, name, params)
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
        local allButton = rootDescription:CreateRadio(
            L["COMMON.ALL_EXPANSION"] or "All Expansions",
            function() return ItemEraSaved.bankExpansionFilter == nil end,
            function()
                ItemEraSaved.bankExpansionFilter = nil
                ItemEra.Filters:ClearBankHighlight()
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
                    ItemEra.Filters:HighlightBankByExpansion(id)
                    dropdown:GenerateMenu()
                end
            )
        end
    end

    dropdown:SetupMenu(GeneratorFunction)
    dropdown:Show()
    return dropdown
end

function ItemEra.Filters:ResetFilters()
    ItemEraSaved.bankExpansionFilter = nil
    ItemEra.Filters:ClearBankHighlight()
    if ItemEraBankFilterDropdown then
        ItemEraBankFilterDropdown:SetDefaultText(L["COMMON.SELECT_EXPANSION"] or "Select Expansion")
        ItemEraBankFilterDropdown:GenerateMenu()
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
    -- Eventos agrupados para UpdateBankFilters
    local bankEvents = {
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
    for _, event in ipairs(bankEvents) do
        ItemEra:RegisterEvent(event, ItemEra.Filters.UpdateBankFilters)
    end

    -- Otros eventos
    ItemEra:RegisterEvent("BANKFRAME_CLOSED", ItemEra.Filters.ResetFilters)

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

    -- Guild Bank
    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.GuildBanker then return end
        if not ItemEraGuildBankFilterDropdown then
            local dropdownParams = { x = 18, y = -28, width = 200 }
            ItemEra.Filters:CreateFilterDropdown(GuildBankFrame, "ItemEraGuildBankFilterDropdown", dropdownParams)
        else
            ItemEraGuildBankFilterDropdown:Show()
        end
    end)
end
