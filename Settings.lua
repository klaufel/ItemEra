local addonName, addon = ...
local Config = {}
addon.Config = Config

-- Referencia al sistema de localización con fallback defensivo
addon.L = addon.L or {}
if not getmetatable(addon.L) then
    setmetatable(addon.L, { __index = function(t, k) return k end })
end
local L = addon.L

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
    print("ItemEra:", setting, "key changed:", value)
end

-- Add settings

-- Setting: showExpansionTooltip
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


-- Setting: showExpansionFilter
local showExpansionFilter = Settings.RegisterAddOnSetting(
    category,
    "ItemEra_" .. "showExpansionFilter",
    "showExpansionFilter",
    ItemEraConfig,
    type(true),
    L["SETTINGS.EXPANSION_FILTER.TITLE"],
    true
)
showExpansionFilter:SetValueChangedCallback(OnSettingChanged)
Settings.CreateCheckbox(category, showExpansionFilter, L["SETTINGS.EXPANSION_FILTER.TOOLTIP"])

-- Register category
Settings.RegisterAddOnCategory(category)
