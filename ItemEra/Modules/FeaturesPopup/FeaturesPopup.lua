local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.FeaturesPopup = {}

local FRAME_WIDTH = 550
local FRAME_HEIGHT = 450

local FEATURES_POPUP_KEY = "2.1.0-reagentsb"

local function GetAddonVersion()
    return C_AddOns.GetAddOnMetadata(addonName, "Version") or "0.0.0"
end

local function ShouldShowFeaturesPopup()
    local lastShownKey = ItemEra.DB_SETTINGS.global.settings.lastShownFeaturesPopupKey
    return lastShownKey ~= FEATURES_POPUP_KEY
end

local function CreateFeaturesPopupFrame()
    local frame = CreateFrame("Frame", "ItemEraFeaturesPopupFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("FULLSCREEN_DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame.TitleText:SetText("ItemEra - " .. L["FEATURES_POPUP_TITLE"])

    local versionText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    versionText:SetPoint("TOP", frame.TitleText, "BOTTOM", 0, -20)
    versionText:SetText(L["FEATURES_POPUP_VERSION"] .. " " .. GetAddonVersion())
    versionText:SetTextColor(0.7, 0.7, 0.7)

    local contentText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    contentText:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -60)
    contentText:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -60)
    contentText:SetJustifyH("LEFT")
    contentText:SetJustifyV("TOP")
    contentText:SetSpacing(3)
    contentText:SetText(L["FEATURES_POPUP_CONTENT"])

    local checkBox = CreateFrame("CheckButton", "ItemEraFeaturesPopupCheckBox", frame, "UICheckButtonTemplate")
    checkBox:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 12)
    checkBox:SetSize(24, 24)

    local checkBoxText = checkBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    checkBoxText:SetPoint("LEFT", checkBox, "RIGHT", 2, 0)
    checkBoxText:SetText(L["FEATURES_POPUP_DONT_SHOW_AGAIN"])
    frame.checkBox = checkBox

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 22)
    closeButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    closeButton:SetText(L["FEATURES_POPUP_CLOSE"])
    closeButton:SetScript("OnClick", function()
        if checkBox:GetChecked() then
            ItemEra.DB_SETTINGS.global.settings.lastShownFeaturesPopupKey = FEATURES_POPUP_KEY
        end
        frame:Hide()
    end)

    local discordButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    discordButton:SetSize(100, 22)
    discordButton:SetPoint("RIGHT", closeButton, "LEFT", -8, 0)
    discordButton:SetText(L["SETTINGS_DISCORD_NAME"])
    discordButton:SetScript("OnClick", function()
        StaticPopup_Show("ITEMERA_DISCORD_LINK")
    end)

    frame.CloseButton:SetScript("OnClick", function()
        if checkBox:GetChecked() then
            ItemEra.DB_SETTINGS.global.settings.lastShownFeaturesPopupKey = FEATURES_POPUP_KEY
        end
        frame:Hide()
    end)

    tinsert(UISpecialFrames, "ItemEraFeaturesPopupFrame")

    frame:Hide()
    return frame
end

local featuresPopupFrame = nil

local function ShowFeaturesPopup()
    if not featuresPopupFrame then
        featuresPopupFrame = CreateFeaturesPopupFrame()
    end

    featuresPopupFrame.checkBox:SetChecked(false)
    featuresPopupFrame:Show()
end

function ItemEra.FeaturesPopup:Initialize()
    ItemEra:RegisterEvent("PLAYER_ENTERING_WORLD", function(_, _, isInitialLogin, isReloadingUi)
        if (isInitialLogin or isReloadingUi) and ShouldShowFeaturesPopup() then
            C_Timer.After(1, function()
                ShowFeaturesPopup()
            end)
        end
    end)
end

function ItemEra.FeaturesPopup:Show()
    ShowFeaturesPopup()
end
