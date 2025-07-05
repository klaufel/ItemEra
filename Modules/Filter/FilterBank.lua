local addonName, addon = ...
local BankFilter = {}
addon.BankFilter = BankFilter

addon.L = addon.L or {}
if not getmetatable(addon.L) then
    setmetatable(addon.L, { __index = function(t, k) return k end })
end
local L = addon.L

local function CreateBankExpansionDropdown(parent)
    local button = FrameUtil.CreateFrame("ItemEraBankFilterButton", parent, "WowStyle1DropdownTemplate")
    button:SetSize(140, 24)
    button:SetText(L["COMMON.SELECT_EXPANSION"])

    local function CreateMenuItems()
        local items = {}

        table.insert(items, {
            text = L["COMMON.ALL_EXPANSION"],
            func = function()
                ItemEraSaved.bankExpansionFilter = nil
                button:SetText(L["COMMON.ALL_EXPANSION"])
                BankFilter:ClearBankHighlight()
            end,
            checked = (ItemEraSaved.bankExpansionFilter == nil)
        })

        table.insert(items, { isSeparator = true })

        for _, expansion in ipairs(addon.GetExpansionsInOrder()) do
            local id, name = expansion.id, expansion.name
            local icon = "Interface/AddOns/ItemEra/Media/Icons/Exp_Logo_" .. id .. ".tga"
            local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)

            table.insert(items, {
                text = iconMarkup .. " " .. name,
                func = function()
                    ItemEraSaved.bankExpansionFilter = id
                    button:SetText(iconMarkup .. " " .. name)
                    BankFilter:HighlightBankByExpansion(id)
                end,
                checked = (ItemEraSaved.bankExpansionFilter == id)
            })
        end

        return items
    end

    button:SetScript("OnClick", function(self)
        local dropdown = CreateFrame("Frame", nil, UIParent, "UIDropDownMenuTemplate")

        local function initialize(_, level)
            for _, item in ipairs(CreateMenuItems()) do
                if not item.isSeparator then
                    local info = UIDropDownMenu_CreateInfo()
                    info.text = item.text
                    info.func = item.func
                    info.checked = item.checked
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        end
        UIDropDownMenu_Initialize(dropdown, initialize, "MENU")
        ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
    end)

    return button
end

-- Crear el dropdown en el banco
function BankFilter:CreateBankDropdown()
    if self.dropdown then return end
    if not BankFrame then return end

    self.dropdown = CreateBankExpansionDropdown(BankFrame)
    self.dropdown:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 56, -28)
end

-- Función reutilizable para destacar items en un contenedor
local function HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    -- Handle regular bank containers
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

                    -- Show overlay for items that DON'T match the selected expansion
                    if itemExpansionID and itemExpansionID ~= expansionID then
                        if button.searchOverlay then
                            button.searchOverlay:Show()
                        elseif button.SetMatchesSearch then
                            button:SetMatchesSearch(false)
                        end
                    else
                        -- Hide overlay for items that DO match
                        if button.searchOverlay then
                            button.searchOverlay:Hide()
                        elseif button.SetMatchesSearch then
                            button:SetMatchesSearch(true)
                        end
                    end
                end
            else
                -- No item in slot, ensure overlay is hidden
                if button.searchOverlay then
                    button.searchOverlay:Hide()
                elseif button.SetMatchesSearch then
                    button:SetMatchesSearch(true)
                end
            end
        end
    end
end

-- Function to highlight Account Bank items by expansion
function BankFilter:HighlightAccountBankByExpansion(expansionID)
    if not AccountBankPanel or not AccountBankPanel:IsShown() then
        return
    end

    local selectedTabID = AccountBankPanel:GetSelectedTabID()
    if not selectedTabID or selectedTabID == -1 then -- PURCHASE_TAB_ID = -1
        return
    end

    -- Use the native EnumerateValidItems method from BankPanelMixin
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        local bankTabID = itemButton:GetBankTabID()
        local containerSlotID = itemButton:GetContainerSlotID()

        -- Get item info using the same method as Blizzard
        local itemInfo = C_Container.GetContainerItemInfo(bankTabID, containerSlotID)
        if itemInfo and itemInfo.itemID then
            local itemExpansionID = select(15, GetItemInfo(itemInfo.itemID))

            if expansionID then
                -- Show overlay for items that DON'T match the selected expansion
                if itemExpansionID and itemExpansionID ~= expansionID then
                    itemButton:SetMatchesSearch(false)
                else
                    itemButton:SetMatchesSearch(true)
                end
            else
                -- Clear all filters when no expansion selected
                itemButton:SetMatchesSearch(true)
            end
        end
    end
end

-- Function to clear Account Bank highlighting
function BankFilter:ClearAccountBankHighlight()
    if not AccountBankPanel then
        return
    end

    -- Use native method to clear all filters
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        itemButton:SetMatchesSearch(true)
    end
end

-- Destacar items del banco por expansión
function BankFilter:HighlightBankByExpansion(expansionID)
    -- Limpiar highlighting previo
    self:ClearBankHighlight()

    if not expansionID then return end

    -- Banco principal (28 slots)
    HighlightContainerByExpansion(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS, "BankFrameItem", expansionID)

    -- Banco de reagentes (98 slots) - solo si está visible
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        HighlightContainerByExpansion(REAGENTBANK_CONTAINER, 98, "ReagentBankFrameItem", expansionID)
    end

    -- Account Bank filtering using native API
    if AccountBankPanel and AccountBankPanel:IsShown() then
        self:HighlightAccountBankByExpansion(expansionID)
    end
end

-- Limpiar highlighting del banco
function BankFilter:ClearBankHighlight()
    -- Banco principal
    for slot = 1, NUM_BANKGENERIC_SLOTS do
        local button = _G["BankFrameItem" .. slot]
        if button and button.searchOverlay then
            button.searchOverlay:Hide()
        end
    end

    -- Banco de reagentes
    for slot = 1, 98 do
        local button = _G["ReagentBankFrameItem" .. slot]
        if button and button.searchOverlay then
            button.searchOverlay:Hide()
        end
    end

    -- Account Bank using native API
    self:ClearAccountBankHighlight()
end

function BankFilter:Init()
    -- Hook para cuando se muestra el banco
    if BankFrame and BankFrame.Show then
        hooksecurefunc(BankFrame, "Show", function(self)
            BankFilter:CreateBankDropdown()
            -- Mostrar dropdown solo para banco personal
            if BankFilter.dropdown then
                BankFilter.dropdown:Show()
            end
            -- Aplicar filtro si ya está seleccionado
            if ItemEraSaved.bankExpansionFilter then
                BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
            end
        end)
    end

    -- Hook para cuando se oculta el banco
    if BankFrame and BankFrame.Hide then
        hooksecurefunc(BankFrame, "Hide", function(self)
            ItemEraSaved.bankExpansionFilter = nil
            BankFilter:ClearBankHighlight()
            if BankFilter.dropdown then
                UIDropDownMenu_SetText(BankFilter.dropdown, L["COMMON.SELECT_EXPANSION"])
            end
        end)
    end

    -- Hook para cuando se muestra el banco de reagentes
    if ReagentBankFrame and ReagentBankFrame.Show then
        hooksecurefunc(ReagentBankFrame, "Show", function(self)
            -- Aplicar filtro al banco de reagentes si ya está seleccionado
            if ItemEraSaved.bankExpansionFilter then
                BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
            end
        end)
    end

    -- Hook para cuando se muestra el banco de cuenta (Account Bank/Warband)
    if AccountBankPanel then
        -- Hook AccountBankPanel Show
        hooksecurefunc(AccountBankPanel, "OnShow", function()
            if ItemEraSaved.bankExpansionFilter then
                BankFilter:HighlightAccountBankByExpansion(ItemEraSaved.bankExpansionFilter)
            end
        end)

        -- Hook tab changes in Account Bank with improved event handling
        local accountBankFrame = CreateFrame("Frame")
        accountBankFrame:RegisterEvent("BAG_UPDATE")
        accountBankFrame:RegisterEvent("ADDON_LOADED")

        accountBankFrame:SetScript("OnEvent", function(self, event, bagID)
            if event == "BAG_UPDATE" and bagID >= 13 and bagID <= 17 then
                if AccountBankPanel and AccountBankPanel:IsShown() and ItemEraSaved.bankExpansionFilter then
                    -- Small delay to ensure the UI is updated
                    BankFilter:HighlightAccountBankByExpansion(ItemEraSaved.bankExpansionFilter)
                end
            elseif event == "ADDON_LOADED" and bagID == addonName then
                -- Hook the AccountBankPanel's internal tab selection
                if AccountBankPanel and AccountBankPanel.SelectTab then
                    hooksecurefunc(AccountBankPanel, "SelectTab", function(self, tabID)
                        if ItemEraSaved.bankExpansionFilter then
                            if tabID == 13 then
                                C_Timer.After(0.005, function()
                                    BankFilter:HighlightAccountBankByExpansion(ItemEraSaved.bankExpansionFilter)
                                end)
                            else
                                BankFilter:HighlightAccountBankByExpansion(ItemEraSaved.bankExpansionFilter)
                            end
                        end
                    end)
                end
            end
        end)
    end

    -- Hook alternativo usando eventos para el banco de reagentes
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("REAGENTBANK_PURCHASED")
    frame:SetScript("OnEvent", function(self, event)
        if event == "REAGENTBANK_PURCHASED" and ItemEraSaved.bankExpansionFilter then
            BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
        end
    end)
end
