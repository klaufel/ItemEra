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
local function HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID, test)
    if test then
        -- Handle Account Bank/Warband Bank

        for bag = Enum.BagIndex.AccountBankTab_1, Enum.BagIndex.AccountBankTab_5 do
            local numSlots = C_Container.GetContainerNumSlots(bag)
            if numSlots and numSlots > 0 then
                for slot = 1, numSlots do
                    local item = C_Container.GetContainerItemInfo(bag, slot)

                    if item then
                        local itemExpansionID = select(15, GetItemInfo(item.itemID))
                        local buttonName = "AccountBankTab_" ..
                            (bag - Enum.BagIndex.AccountBankTab_1 + 1) .. "_Item" .. slot
                        local button = _G[buttonName]

                        if button then
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
                    end
                end
            end
        end
    else
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
end

-- Destacar items del banco por expansión
function BankFilter:HighlightBankByExpansion(expansionID)
    -- Limpiar highlighting previo
    self:ClearBankHighlight()

    if not expansionID then return end

    -- Banco principal (28 slots)
    HighlightContainerByExpansion(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS, "BankFrameItem", expansionID)

    -- -- Banco de reagentes (98 slots) - solo si está visible
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        HighlightContainerByExpansion(REAGENTBANK_CONTAINER, 98, "ReagentBankFrameItem", expansionID)
    end

    -- Banco de warband/account bank - solo si está visible y es compatible
    if AccountBankPanel and BankFrame:IsShown() and BankFrame.selectedTab == 3 then
        HighlightContainerByExpansion(13, 98, "AccountBankTab_1", expansionID, true)
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

    -- Banco de cuenta (Account Bank/Warband)
    for slot = 1, 98 do
        local button = _G["AccountBankPanelItem" .. slot]
        if button and button.searchOverlay then
            button.searchOverlay:Hide()
        end
    end
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
    if AccountBankPanel and AccountBankPanel.Show then
        hooksecurefunc(AccountBankPanel, "Show", function(self)
            if ItemEraSaved.bankExpansionFilter then
                BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
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
