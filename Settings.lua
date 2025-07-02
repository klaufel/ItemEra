local addonName, addon = ...
local L = addon.L or _G.ItemEra_Locale or {}
local Config = {}
addon.Config = Config

function Config:GetShowExpansionTooltip()
    if Settings and Settings.GetValue then
        local ok, value = pcall(Settings.GetValue, "ItemEra_showExpansionTooltip")
        if ok and type(value) == "boolean" then
            return value
        end
    end
    return ItemEraConfig and ItemEraConfig.showExpansionTooltip ~= false
end

ItemEraConfig = ItemEraConfig or {}

local category = Settings.RegisterVerticalLayoutCategory("ItemEra")

local function OnSettingChanged(setting, value)
    print("ItemEra: `showExpansionTooltip` key changed:", value)
end


local showExpansionTooltip = Settings.RegisterAddOnSetting(
    category,
    "ItemEra_" .. "showExpansionTooltip",
    "showExpansionTooltip",
    ItemEraConfig,
    type(true),
    L["SETTINGS.EXPANSION_TOOLTIP.TITLE"],
    true
)

showExpansionTooltip:SetValueChangedCallback(OnSettingChanged)
Settings.CreateCheckbox(category, showExpansionTooltip, L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"])

Settings.RegisterAddOnCategory(category)
