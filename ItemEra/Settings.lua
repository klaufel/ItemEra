local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Settings = {}

local defaults = {
    global = {
        settings = {
            enabledTooltip = true,
            enabledFiltersBank = true,
            enabledFiltersGuildBank = true,
            enabledFiltersInventory = true,
            showExpansionName = true,
            showExpansionLogo = true,
            showExpansionLiteral = true,
            useKeyModifier = false,
            keyModifier = ItemEra.Utils.KeyModifiers.SHIFT
        }
    }
}

local function handleUpdateSettingsValue(info, value)
    local key = info[#info]
    ItemEra.DB_SETTINGS.global.settings[key] = value
    LibStub("AceConfigRegistry-3.0"):NotifyChange("ItemEra")
end

local function handleGetSettingsValue(info)
    local key = info[#info]
    return ItemEra.DB_SETTINGS.global.settings[key]
end

local function GetTooltipPreview()
    local isDisabled = not ItemEra.DB_SETTINGS.global.settings.showExpansionName and
        not ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
    local expansionID = 10
    local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(expansionID)
    local tooltipPreview = not isDisabled and expansionText ~= "" and expansionText or
        "|cffff0000" .. L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] .. "|r"

    return L["SETTINGS_TOOLTIP_PREVIEW_NAME"] .. "\n\n\n" .. tooltipPreview
end


local function GetOptions()
    return {
        type = "group",
        name = "ItemEra - Filter Expansion Items",
        args = {
            tooltipHeader = {
                type = "header",
                name = L["SETTINGS_TOOLTIP_HEADER_NAME"],
                order = 1,
            },
            tooltipDescription = {
                type = "description",
                name = L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"],
                order = 2,
            },
            showExpansionLiteral = {
                type = "toggle",
                name = L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"],
                desc = L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"],
                width = "full",
                disabled = function()
                    return not ItemEra.DB_SETTINGS.global.settings.showExpansionName and
                        not ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
                end,
                order = 10,
                get = handleGetSettingsValue,
                set = handleUpdateSettingsValue,
            },
            showExpansionName = {
                type = "toggle",
                name = L["SETTINGS_SHOW_EXPANSION_NAME_NAME"],
                desc = L["SETTINGS_SHOW_EXPANSION_NAME_DESC"],
                width = "full",
                order = 10,
                get = handleGetSettingsValue,
                set = handleUpdateSettingsValue,
            },
            showExpansionLogo = {
                type = "toggle",
                name = L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"],
                desc = L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"],
                width = "full",
                order = 10,
                get = handleGetSettingsValue,
                set = handleUpdateSettingsValue,
            },
            spacer1 = {
                type = "description",
                name = "\n\n\n",
                order = 11,
            },
            preview = {
                type = "description",
                name = GetTooltipPreview,
                order = 12,
                fontSize = "medium",
                width = "full",
            },
            spacer2 = {
                type = "description",
                name = "\n",
                order = 50,
            },
            keyModifierHeader = {
                type = "header",
                name = L["SETTINGS_KEY_MODIFIER_HEADER_NAME"],
                order = 60,
            },
            useKeyModifier = {
                type = "toggle",
                name = L["SETTINGS_USE_KEY_MODIFIER_NAME"],
                desc = "Solo muestra la información de expansión cuando se mantiene presionada una tecla modificadora",
                width = "full",
                order = 70,
                get = handleGetSettingsValue,
                set = handleUpdateSettingsValue,
            },
            keyModifier = {
                type = "select",
                name = L["SETTINGS_KEY_MODIFIER_NAME"],
                desc = L["SETTINGS_KEY_MODIFIER_DESC"],
                width = "full",
                order = 80,
                disabled = function() return not ItemEra.DB_SETTINGS.global.settings.useKeyModifier end,
                values = {
                    [ItemEra.Utils.KeyModifiers.ALT] = "Alt",
                    [ItemEra.Utils.KeyModifiers.CTRL] = "Control",
                    [ItemEra.Utils.KeyModifiers.SHIFT] = "Shift",
                },
                get = handleGetSettingsValue,
                set = handleUpdateSettingsValue,
            },
        },
    }
end

function ItemEra.Settings:Initialize()
    ItemEra.DB_SETTINGS = LibStub("AceDB-3.0"):New("ItemEraDB", defaults, true)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("ItemEra", GetOptions)

    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ItemEra", "ItemEra")
end
