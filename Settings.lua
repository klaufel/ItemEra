-- Configuración moderna de ItemEra para WoW 11.0.2+

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

function Config:Init()
    -- Aquí puedes inicializar el panel de configuración si es necesario
end

ItemEraConfig = ItemEraConfig or {}

local category = Settings.RegisterVerticalLayoutCategory("ItemEra")

local function OnSettingChanged(setting, value)
    -- Puedes poner aquí un print si quieres debuggear
    print("ItemEra: `showExpansionTooltip` key changed:", value)
end

local name = L["Show expansion tooltip on items"] or "Show expansion tooltip on items"
local variable = "showExpansionTooltip"
local variableKey = "showExpansionTooltip"
local variableTbl = ItemEraConfig
local defaultValue = true

local setting = Settings.RegisterAddOnSetting(
    category,
    "ItemEra_" .. variable, -- variable (nombre único global)
    variableKey,            -- clave dentro de la tabla
    variableTbl,            -- tabla donde se guarda la variable
    type(defaultValue),     -- tipo ("boolean")
    name,                   -- nombre visible
    defaultValue            -- valor por defecto
)
setting:SetValueChangedCallback(OnSettingChanged)

local tooltip = L["Show the expansion source in the item tooltip."] or "Show the expansion source in the item tooltip."
Settings.CreateCheckbox(category, setting, tooltip)

-- Configuración para el filtro de expansión (futuro)
local filterName = L["Show expansion filter"] or "Show expansion filter"
local filterVariable = "showExpansionFilter"
local filterVariableKey = "showExpansionFilter"
local filterDefaultValue = true
local filterTooltip = L["Enable expansion filter in the UI (future feature)."] or
"Enable expansion filter in the UI (future feature)."

local filterSetting = Settings.RegisterAddOnSetting(
    category,
    "ItemEra_" .. filterVariable,
    filterVariableKey,
    variableTbl,
    type(filterDefaultValue),
    filterName,
    filterDefaultValue
)
-- Puedes añadir un callback si lo necesitas en el futuro
Settings.CreateCheckbox(category, filterSetting, filterTooltip)

Settings.RegisterAddOnCategory(category)
