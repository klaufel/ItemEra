local addonName, addon = ...
local Highlight = {}
addon.Highlight = Highlight

-- Menú de selección de expansión (con selección persistente y visual)
local function ShowExpansionDropdown(anchor, callback)
    if not addon.expansionNames then return end
    local dropdown = CreateFrame("Frame", "ItemEraExpansionDropdown", UIParent, "UIDropDownMenuTemplate")
    local function OnClick(self)
        ItemEraConfig.highlightExpansionID = self.value
        callback(self.value)
        CloseDropDownMenus()
        -- Refresca el filtro en todas las vistas relevantes al instante
        if BankFrame and BankFrame:IsShown() then
            Highlight:HighlightBankByExpansion(self.value)
        end
        if ReagentBankFrame and ReagentBankFrame:IsShown() then
            Highlight:HighlightReagentBankByExpansion(self.value)
        end
        Highlight:HighlightBagsByExpansion(self.value)
    end
    local function initialize(_, level)
        for id, name in pairs(addon.expansionNames) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = name
            info.value = id
            info.func = OnClick
            info.checked = (ItemEraConfig.highlightExpansionID == id)
            UIDropDownMenu_AddButton(info, level or 1)
        end
    end
    UIDropDownMenu_Initialize(dropdown, initialize, "MENU")
    ToggleDropDownMenu(1, nil, dropdown, anchor, 0, 0)
end

-- Botón para filtrar objetos de una expansión en la mochila
function Highlight:CreateBagHighlightButton()
    if Highlight.BagButton then return end
    local parent = ContainerFrame1
    local cleanButton = _G["ContainerFrame1CleanUpButton"]
    local button = CreateFrame("Button", "ItemEraBagHighlightButton", parent, "UIPanelButtonTemplate")
    button:SetSize(28, 28)
    if cleanButton then
        button:SetPoint("LEFT", cleanButton, "RIGHT", 4, 0)
    else
        button:SetPoint("TOPLEFT", parent, "TOPLEFT", 40, -8)
    end
    button:SetText("Filtrar")
    button:SetScript("OnClick", function(self)
        -- Solo mostrar el menú si la opción está activada
        if ItemEraConfig.showExpansionFilter then
            ShowExpansionDropdown(self, function(expID)
                Highlight:HighlightBagsByExpansion(expID)
            end)
        else
            UIErrorsFrame:AddMessage("La opción 'Filtrar por expansión' está desactivada en las opciones.", 1, 0.2, 0.2)
        end
    end)
    button.tooltip = "Filtrar objetos por expansión"
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Filtrar objetos por expansión\nHaz clic para elegir expansión")
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    Highlight.BagButton = button
end

function Highlight:CreateBankHighlightButton()
    if Highlight.BankButton then return end
    if not BankFrame then return end
    -- Busca el botón de limpiar del banco (Clean Up Bank Bags)
    local button = CreateFrame("Button", "ItemEraBankHighlightButton", BankFrame, "UIPanelButtonTemplate")
    button:SetSize(80, 26)
    button:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 80, -26)
    button:SetText("Filtrar")

    button:SetScript("OnClick", function(self)
        if ItemEraConfig.showExpansionFilter then
            ShowExpansionDropdown(self, function(expID)
                Highlight:HighlightBankByExpansion(expID)
            end)
        else
            UIErrorsFrame:AddMessage("La opción 'Filtrar por expansión' está desactivada en las opciones.", 1, 0.2, 0.2)
        end
    end)
    button.tooltip = "Filtrar objetos por expansión"
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Filtrar objetos por expansión\nHaz clic para elegir expansión")
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    Highlight.BankButton = button
end

function Highlight:CreateReagentBankHighlightButton()
    if Highlight.ReagentBankButton then return end
    if not ReagentBankFrame or not ReagentBankFrame:IsShown() then return end
    local button = CreateFrame("Button", "ItemEraReagentBankHighlightButton", ReagentBankFrame, "UIPanelButtonTemplate")
    button:SetSize(60, 24)
    button:SetPoint("TOPRIGHT", ReagentBankFrame, "TOPRIGHT", -30, -8)
    button:SetText("Filtrar")
    button:SetScript("OnClick", function(self)
        if ItemEraConfig.showExpansionFilter then
            ShowExpansionDropdown(self, function(expID)
                Highlight:HighlightReagentBankByExpansion(expID)
            end)
        else
            UIErrorsFrame:AddMessage("La opción 'Filtrar por expansión' está desactivada en las opciones.", 1, 0.2, 0.2)
        end
    end)
    button.tooltip = "Filtrar objetos por expansión"
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Filtrar objetos por expansión\nHaz clic para elegir expansión")
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    Highlight.ReagentBankButton = button
end

function Highlight:CreateGuildBankHighlightButton()
    if Highlight.GuildBankButton then return end
    if not GuildBankFrame then return end
    -- Busca el botón de limpiar del banco de hermandad (GuildBankFrameCleanupButton)
    local cleanButton = _G["GuildBankFrameCleanupButton"]
    local button = CreateFrame("Button", "ItemEraGuildBankHighlightButton", GuildBankFrame, "UIPanelButtonTemplate")
    button:SetSize(28, 28)
    if cleanButton then
        button:SetPoint("LEFT", cleanButton, "RIGHT", 4, 0)
    else
        button:SetPoint("TOPLEFT", GuildBankFrame, "TOPLEFT", 40, -8)
    end
    button:SetText("Filtrar")
    button:SetScript("OnClick", function(self)
        if ItemEraConfig.showExpansionFilter then
            ShowExpansionDropdown(self, function(expID)
                Highlight:HighlightGuildBankByExpansion(expID)
            end)
        else
            UIErrorsFrame:AddMessage("La opción 'Filtrar por expansión' está desactivada en las opciones.", 1, 0.2, 0.2)
        end
    end)
    button.tooltip = "Filtrar objetos por expansión (banco de hermandad)"
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Filtrar objetos por expansión en el banco de hermandad\nHaz clic para elegir expansión")
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    Highlight.GuildBankButton = button
end

-- Oscurece los objetos que no coinciden con la expansión seleccionada en las bolsas
function Highlight:HighlightBagsByExpansion(expansionID)
    if not ItemEraConfig.showExpansionFilter then return end
    local getLink = C_Container and C_Container.GetContainerItemLink or GetContainerItemLink
    for bag = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerNumSlots(bag) or
            GetContainerNumSlots(bag)
        for slot = 1, numSlots do
            local itemLink = getLink(bag, slot)
            local button = _G["ContainerFrame" .. (bag + 1) .. "Item" .. slot]
            if button then
                local shouldDim = false
                if itemLink then
                    local itemID = tonumber(itemLink:match("item:(%d+)"))
                    if itemID then
                        local itemExpansionID = select(15, GetItemInfo(itemID))
                        if itemExpansionID ~= expansionID then
                            shouldDim = true
                        end
                    else
                        shouldDim = true
                    end
                else
                    shouldDim = true
                end
                if shouldDim then
                    if button.searchOverlay then
                        button.searchOverlay:Show()
                    end
                else
                    if button.searchOverlay then
                        button.searchOverlay:Hide()
                    end
                end
            end
        end
    end
end

-- Oscurece los objetos que no coinciden con la expansión seleccionada en el banco
function Highlight:HighlightBankByExpansion(expansionID)
    if not ItemEraConfig.showExpansionFilter then return end
    for slot = 1, NUM_BANKGENERIC_SLOTS do
        local itemLink
        if C_Container and C_Container.GetContainerItemLink then
            itemLink = C_Container.GetContainerItemLink(-1, slot)
        elseif GetContainerItemLink then
            itemLink = GetContainerItemLink(-1, slot)
        end
        local button = _G["BankFrameItem" .. slot]
        if button then
            local shouldDim = false
            if itemLink then
                local itemID = tonumber(itemLink:match("item:(%d+)"))
                if itemID then
                    local itemExpansionID = select(15, GetItemInfo(itemID))
                    if itemExpansionID ~= expansionID then
                        shouldDim = true
                    end
                else
                    shouldDim = true
                end
            else
                shouldDim = true
            end
            if shouldDim then
                if button.searchOverlay then
                    button.searchOverlay:Show()
                end
            else
                if button.searchOverlay then
                    button.searchOverlay:Hide()
                end
            end
        end
    end
end

-- Oscurece los objetos que no coinciden con la expansión seleccionada en el banco de componentes
function Highlight:HighlightReagentBankByExpansion(expansionID)
    if not ItemEraConfig.showExpansionFilter then return end
    for slot = 1, 98 do
        local itemLink
        if C_Container and C_Container.GetContainerItemLink then
            itemLink = C_Container.GetContainerItemLink(REAGENTBANK_CONTAINER, slot)
        elseif GetContainerItemLink then
            itemLink = GetContainerItemLink(REAGENTBANK_CONTAINER, slot)
        end
        local button = _G["ReagentBankFrameItem" .. slot]
        if button then
            local shouldDim = false
            if itemLink then
                local itemID = tonumber(itemLink:match("item:(%d+)"))
                if itemID then
                    local itemExpansionID = select(15, GetItemInfo(itemID))
                    if itemExpansionID ~= expansionID then
                        shouldDim = true
                    end
                else
                    shouldDim = true
                end
            else
                shouldDim = true
            end
            if shouldDim then
                if button.searchOverlay then
                    button.searchOverlay:Show()
                end
            else
                if button.searchOverlay then
                    button.searchOverlay:Hide()
                end
            end
        end
    end
end

function Highlight:HighlightGuildBankByExpansion(expansionID)
    if not ItemEraConfig.showExpansionFilter then return end
    -- El banco de hermandad tiene 7 columnas y 14 filas por pestaña
    for col = 1, 7 do
        for row = 1, 14 do
            local button = _G["GuildBankColumn" .. col .. "Button" .. row]
            if button then
                local itemLink = GetGuildBankItemLink(GuildBankFrame.selectedTab or GetCurrentGuildBankTab(),
                    ((col - 1) * 14) + row)
                local shouldDim = false
                if itemLink then
                    local itemID = tonumber(itemLink:match("item:(%d+)"))
                    if itemID then
                        local itemExpansionID = select(15, GetItemInfo(itemID))
                        if itemExpansionID ~= expansionID then
                            shouldDim = true
                        end
                    else
                        shouldDim = true
                    end
                else
                    shouldDim = true
                end
                if button.searchOverlay then
                    if shouldDim then
                        button.searchOverlay:Show()
                    else
                        button.searchOverlay:Hide()
                    end
                end
            end
        end
    end
end

-- Hooks para mostrar los botones al abrir las ventanas
local f = CreateFrame("Frame")
f:RegisterEvent("BANKFRAME_OPENED")
f:RegisterEvent("BANKFRAME_CLOSED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("REAGENTBANK_PURCHASED")
f:RegisterEvent("BAG_CLOSED")
f:RegisterEvent("GUILDBANKFRAME_OPENED")
f:RegisterEvent("GUILDBANKFRAME_CLOSED")
f:SetScript("OnEvent", function(self, event)
    if event == "BANKFRAME_OPENED" then
        addon.Highlight:CreateBankHighlightButton()
        if ReagentBankFrame and ReagentBankFrame:IsShown() then
            addon.Highlight:CreateReagentBankHighlightButton()
        end
        -- Refresca el filtro si ya hay expansión seleccionada
        if ItemEraConfig.highlightExpansionID then
            addon.Highlight:HighlightBankByExpansion(ItemEraConfig.highlightExpansionID)
            if ReagentBankFrame and ReagentBankFrame:IsShown() then
                addon.Highlight:HighlightReagentBankByExpansion(ItemEraConfig.highlightExpansionID)
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        addon.Highlight:CreateBagHighlightButton()
        -- Refresca el filtro si ya hay expansión seleccionada
        if ItemEraConfig.highlightExpansionID then
            addon.Highlight:HighlightBagsByExpansion(ItemEraConfig.highlightExpansionID)
        end
    elseif event == "REAGENTBANK_PURCHASED" then
        if ReagentBankFrame and ReagentBankFrame:IsShown() then
            addon.Highlight:CreateReagentBankHighlightButton()
            if ItemEraConfig.highlightExpansionID then
                addon.Highlight:HighlightReagentBankByExpansion(ItemEraConfig.highlightExpansionID)
            end
        end
    elseif event == "GUILDBANKFRAME_OPENED" then
        addon.Highlight:CreateGuildBankHighlightButton()
        if ItemEraConfig.highlightExpansionID then
            addon.Highlight:HighlightGuildBankByExpansion(ItemEraConfig.highlightExpansionID)
        end
    elseif event == "GUILDBANKFRAME_CLOSED" then
        -- Limpia overlays en banco de hermandad y reinicia selección
        ItemEraConfig.highlightExpansionID = nil
        for col = 1, 7 do
            for row = 1, 14 do
                local button = _G["GuildBankColumn" .. col .. "Button" .. row]
                if button and button.searchOverlay then
                    button.searchOverlay:Hide()
                end
            end
        end
    elseif event == "BANKFRAME_CLOSED" or event == "BAG_CLOSED" then
        -- Reinicia la selección al cerrar banco o bolsas
        ItemEraConfig.highlightExpansionID = nil
        -- Limpia overlays en bolsas
        for bag = 0, NUM_BAG_SLOTS do
            local numSlots = C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerNumSlots(bag) or
                GetContainerNumSlots(bag)
            for slot = 1, numSlots do
                local button = _G["ContainerFrame" .. (bag + 1) .. "Item" .. slot]
                if button and button.searchOverlay then
                    button.searchOverlay:Hide()
                end
            end
        end
        -- Limpia overlays en banco
        for slot = 1, NUM_BANKGENERIC_SLOTS do
            local button = _G["BankFrameItem" .. slot]
            if button and button.searchOverlay then
                button.searchOverlay:Hide()
            end
        end
        -- Limpia overlays en banco de componentes
        for slot = 1, 98 do
            local button = _G["ReagentBankFrameItem" .. slot]
            if button and button.searchOverlay then
                button.searchOverlay:Hide()
            end
        end
    end
end)

-- Refresca el filtro al instante tras seleccionar una expansión (en bolsas, banco y banco de componentes)
hooksecurefunc(Highlight, "HighlightBagsByExpansion", function(self, expID)
    -- Forzar refresco visual de las bolsas
    if ContainerFrame_UpdateAll then
        ContainerFrame_UpdateAll()
    end
end)

hooksecurefunc(Highlight, "HighlightBankByExpansion", function(self, expID)
    -- Forzar refresco visual del banco
    if BankFrameItem1 and BankFrame:IsShown() then
        for slot = 1, NUM_BANKGENERIC_SLOTS do
            local button = _G["BankFrameItem" .. slot]
            if button and button.Update then button:Update() end
        end
    end
end)

hooksecurefunc(Highlight, "HighlightReagentBankByExpansion", function(self, expID)
    -- Forzar refresco visual del banco de componentes
    if ReagentBankFrame and ReagentBankFrame:IsShown() then
        for slot = 1, 98 do
            local button = _G["ReagentBankFrameItem" .. slot]
            if button and button.Update then button:Update() end
        end
    end
end)

hooksecurefunc(Highlight, "HighlightGuildBankByExpansion", function(self, expID)
    -- Forzar refresco visual del banco de hermandad
    if GuildBankFrame and GuildBankFrame:IsShown() then
        for col = 1, 7 do
            for row = 1, 14 do
                local button = _G["GuildBankColumn" .. col .. "Button" .. row]
                if button and button.Update then button:Update() end
            end
        end
    end
end)
