local addonName, addon = ...
local BankFilter = {}
addon.BankFilter = BankFilter

addon.L = addon.L or {}
if not getmetatable(addon.L) then
    setmetatable(addon.L, { __index = function(t, k) return k end })
end
local L = addon.L

-- Dropdown selector para filtrar por expansión en el banco
local function CreateBankExpansionDropdown(parent)
    local dropdown = CreateFrame("Frame", "ItemEraBankFilterDropdown", parent, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropdown, 136)
    UIDropDownMenu_SetText(dropdown, L["COMMON.SELECT_EXPANSION"])
    UIDropDownMenu_JustifyText(dropdown, "LEFT")

    local function initialize(self, level)
        -- Opción para limpiar filtro
        local info = UIDropDownMenu_CreateInfo()
        info.text = L["COMMON.ALL_EXPANSION"]
        info.value = nil
        info.func = function()
            ItemEraSaved.bankExpansionFilter = nil
            UIDropDownMenu_SetText(dropdown, L["COMMON.ALL_EXPANSION"])
            BankFilter:ClearBankHighlight()
        end
        info.checked = (ItemEraSaved.bankExpansionFilter == nil)
        UIDropDownMenu_AddButton(info, level)

        -- Separador
        local sepInfo = UIDropDownMenu_CreateInfo()
        sepInfo.text = ""
        sepInfo.isTitle = true
        sepInfo.notCheckable = true
        UIDropDownMenu_AddButton(sepInfo, level)

        -- Expansiones con iconos en orden
        for _, expansion in ipairs(addon.GetExpansionsInOrder()) do
            local id, name = expansion.id, expansion.name
            local expInfo = UIDropDownMenu_CreateInfo()
            local icon = "Interface/AddOns/ItemEra/Media/Icons/Exp_Logo_" .. id .. ".png"
            local iconMarkup = ("|T%s:16:16:0:0:64:64:4:60:4:60|t"):format(icon)
            expInfo.text = iconMarkup .. " " .. name
            expInfo.value = id
            expInfo.func = function()
                ItemEraSaved.bankExpansionFilter = id
                UIDropDownMenu_SetText(dropdown, iconMarkup .. " " .. name)
                BankFilter:HighlightBankByExpansion(id)
            end
            expInfo.checked = (ItemEraSaved.bankExpansionFilter == id)
            UIDropDownMenu_AddButton(expInfo, level)
        end
    end

    UIDropDownMenu_Initialize(dropdown, initialize)
    return dropdown
end

-- Crear el dropdown en el banco
function BankFilter:CreateBankDropdown()
    if self.dropdown then return end
    if not BankFrame then return end

    self.dropdown = CreateBankExpansionDropdown(BankFrame)
    self.dropdown:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 42, -26)
end

-- Función reutilizable para destacar items en un contenedor
local function HighlightContainerByExpansion(containerID, maxSlots, buttonNamePattern, expansionID)
    for slot = 1, maxSlots do
        local itemLink
        if C_Container and C_Container.GetContainerItemLink then
            itemLink = C_Container.GetContainerItemLink(containerID, slot)
        else
            itemLink = GetContainerItemLink(containerID, slot)
        end

        local button = _G[buttonNamePattern .. slot]

        if button and itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                local itemExpansionID = select(15, GetItemInfo(itemID))
                if itemExpansionID and itemExpansionID ~= expansionID then
                    if button.searchOverlay then
                        button.searchOverlay:Show()
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

    -- Banco de reagentes (98 slots) - solo si está visible
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        HighlightContainerByExpansion(REAGENTBANK_CONTAINER, 98, "ReagentBankFrameItem", expansionID)
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
end

function BankFilter:Init()
    -- Hook para cuando se muestra el banco
    if BankFrame and BankFrame.Show then
        hooksecurefunc(BankFrame, "Show", function(self)
            BankFilter:CreateBankDropdown()
            -- Aplicar filtro si ya está seleccionado
            if ItemEraSaved.bankExpansionFilter then
                BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
            end
        end)
    end

    -- Hook para cuando se oculta el banco
    if BankFrame and BankFrame.Hide then
        hooksecurefunc(BankFrame, "Hide", function(self)
            -- Limpiar filtro al cerrar
            ItemEraSaved.bankExpansionFilter = nil
            BankFilter:ClearBankHighlight()
            -- Reiniciar el texto del dropdown
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

    -- Hook alternativo usando eventos para el banco de reagentes
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("REAGENTBANK_PURCHASED")
    frame:SetScript("OnEvent", function(self, event)
        if event == "REAGENTBANK_PURCHASED" and ItemEraSaved.bankExpansionFilter then
            BankFilter:HighlightBankByExpansion(ItemEraSaved.bankExpansionFilter)
        end
    end)
end
