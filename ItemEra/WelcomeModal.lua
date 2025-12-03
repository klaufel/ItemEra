local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.WelcomeModal = {}

local AceGUI = LibStub("AceGUI-3.0")

-- Función para crear y mostrar el modal de bienvenida
function ItemEra.WelcomeModal:Show()
    -- Verificar si el modal ya se mostró
    if ItemEra.DB_SETTINGS.global.settings.welcomeModalShown then
        return
    end

    -- Crear el frame principal del modal
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("ItemEra - " .. L["WELCOME_MODAL_TITLE"])
    frame:SetWidth(600)
    frame:SetHeight(450)
    frame:SetLayout("Flow")

    -- Centrar el modal en la pantalla
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

    -- Logo del addon
    local logo = AceGUI:Create("Icon")
    logo:SetImage("Interface\\AddOns\\ItemEra\\Assets\\Addon\\Logo.tga")
    logo:SetImageSize(64, 64)
    logo:SetRelativeWidth(1.0)
    frame:AddChild(logo)

    -- Título de bienvenida
    local welcomeTitle = AceGUI:Create("Heading")
    welcomeTitle:SetText(L["WELCOME_MODAL_WELCOME_TITLE"])
    welcomeTitle:SetRelativeWidth(1.0)
    frame:AddChild(welcomeTitle)

    -- Descripción principal
    local description = AceGUI:Create("Label")
    description:SetText(L["WELCOME_MODAL_DESCRIPTION"])
    description:SetRelativeWidth(1.0)
    description:SetFontObject(GameFontNormal)
    frame:AddChild(description)

    -- Espaciador
    local spacer1 = AceGUI:Create("Label")
    spacer1:SetText(" ")
    spacer1:SetRelativeWidth(1.0)
    frame:AddChild(spacer1)

    -- Características nuevas
    local featuresTitle = AceGUI:Create("Heading")
    featuresTitle:SetText(L["WELCOME_MODAL_FEATURES_TITLE"])
    featuresTitle:SetRelativeWidth(1.0)
    frame:AddChild(featuresTitle)

    -- Lista de características
    local featuresList = AceGUI:Create("Label")
    featuresList:SetText(L["WELCOME_MODAL_FEATURES_LIST"])
    featuresList:SetRelativeWidth(1.0)
    featuresList:SetFontObject(GameFontNormal)
    frame:AddChild(featuresList)

    -- Espaciador
    local spacer2 = AceGUI:Create("Label")
    spacer2:SetText(" ")
    spacer2:SetRelativeWidth(1.0)
    frame:AddChild(spacer2)

    -- Grupo de botones
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetRelativeWidth(1.0)
    frame:AddChild(buttonGroup)

    -- Botón de configuración
    local configButton = AceGUI:Create("Button")
    configButton:SetText(L["WELCOME_MODAL_CONFIG_BUTTON"])
    configButton:SetWidth(150)
    configButton:SetCallback("OnClick", function()
        -- Abrir la configuración del addon
        InterfaceOptionsFrame_OpenToCategory("ItemEra")
        InterfaceOptionsFrame_OpenToCategory("ItemEra") -- Llamar dos veces para WoW Classic compatibility
        frame:Release()
    end)
    buttonGroup:AddChild(configButton)

    -- Espaciador entre botones
    local buttonSpacer = AceGUI:Create("Label")
    buttonSpacer:SetText("   ")
    buttonSpacer:SetWidth(50)
    buttonGroup:AddChild(buttonSpacer)

    -- Botón de cerrar
    local closeButton = AceGUI:Create("Button")
    closeButton:SetText(L["WELCOME_MODAL_CLOSE_BUTTON"])
    closeButton:SetWidth(150)
    closeButton:SetCallback("OnClick", function()
        frame:Release()
    end)
    buttonGroup:AddChild(closeButton)

    -- Espaciador
    local spacer3 = AceGUI:Create("Label")
    spacer3:SetText(" ")
    spacer3:SetRelativeWidth(1.0)
    frame:AddChild(spacer3)

    -- Checkbox para no mostrar de nuevo
    local dontShowAgain = AceGUI:Create("CheckBox")
    dontShowAgain:SetLabel(L["WELCOME_MODAL_DONT_SHOW_AGAIN"])
    dontShowAgain:SetValue(false)
    dontShowAgain:SetCallback("OnValueChanged", function(widget, event, value)
        if value then
            ItemEra.DB_SETTINGS.global.settings.welcomeModalShown = true
        end
    end)
    frame:AddChild(dontShowAgain)

    -- Callback para cuando se cierra el frame
    frame:SetCallback("OnClose", function(widget)
        -- Marcar como mostrado si el checkbox está marcado
        if dontShowAgain:GetValue() then
            ItemEra.DB_SETTINGS.global.settings.welcomeModalShown = true
        end
        widget:Release()
    end)

    -- Mostrar el frame
    frame:Show()
end

-- Función para resetear el estado del modal (útil para testing)
function ItemEra.WelcomeModal:Reset()
    ItemEra.DB_SETTINGS.global.settings.welcomeModalShown = false
end
