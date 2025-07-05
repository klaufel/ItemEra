local addonName, addon = ...
local Config = {}
addon.Config = Config

-- Referencia al sistema de localización con fallback defensivo
addon.L = addon.L or {}
if not getmetatable(addon.L) then
    setmetatable(addon.L, { __index = function(t, k) return k end })
end
local L = addon.L

function Config:GetSetting(setting)
    if Settings and Settings.GetValue then
        local ok, value = pcall(Settings.GetValue, "ItemEra_" .. setting)
        if ok and type(value) == "boolean" then
            return value
        end
    end
    return ItemEraSaved and ItemEraSaved[setting] ~= false
end

ItemEraSaved = ItemEraSaved or {}

local category = Settings.RegisterVerticalLayoutCategory("ItemEra")

local function OnSettingChanged(setting, value)
    if ItemEraSaved.debug then
        print("ItemEra:", setting, "key changed:", value)
    end
end

-- Add settings

-- Setting: showExpansionTooltip
local showExpansionTooltip = Settings.RegisterAddOnSetting(
    category,
    "ItemEra_" .. "showExpansionTooltip",
    "showExpansionTooltip",
    ItemEraSaved,
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
    ItemEraSaved,
    type(true),
    L["SETTINGS.EXPANSION_FILTER.TITLE"],
    true
)
showExpansionFilter:SetValueChangedCallback(OnSettingChanged)
Settings.CreateCheckbox(category, showExpansionFilter, L["SETTINGS.EXPANSION_FILTER.TOOLTIP"])

function addon:InitializeSettings()
    -- Bank Filter Settings
    if not ItemEraSaved.bankFilter then
        ItemEraSaved.bankFilter = {
            enabled = true,
            rememberSelection = false,
            showFilterCount = true
        }
    end
end

-- Register category
Settings.RegisterAddOnCategory(category)
