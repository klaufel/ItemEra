local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Settings = {}

local defaults = {
    global = {
        settings = {
            showExpansionName = true,
            showExpansionLogo = true,
            showExpansionLiteral = true
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
    local isDisabled = ItemEra.DB_SETTINGS.global.settings.showExpansionName == false and
        ItemEra.DB_SETTINGS.global.settings.showExpansionLogo == false
    local expansionID = 10
    local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(expansionID)
    local tooltipPreview = not isDisabled and expansionText ~= "" and expansionText or
        "|cffff0000" .. L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] .. "|r"

    return L["SETTINGS_TOOLTIP_PREVIEW_NAME"] .. "\n\n\n" .. tooltipPreview
end


local function GetOptions()
    return {
        type = "group",
        name = L["SETTINGS_NAME"],
        desc = L["SETTINGS_DESC"],
        args = {
            header = {
                type = "header",
                name = L["SETTINGS_HEADER_NAME"],
                order = 1,
            },
            description = {
                type = "description",
                name = L["SETTINGS_DESCRIPTION_NAME"],
                order = 2,
            },

            showExpansionLiteral = {
                type = "toggle",
                name = L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"],
                desc = L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"],
                width = "full",
                disabled = ItemEra.DB_SETTINGS.global.settings.showExpansionName == false and
                    ItemEra.DB_SETTINGS.global.settings.showExpansionLogo == false,
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
                order = 998,
            },
            preview = {
                type = "description",
                name = GetTooltipPreview,
                order = 999,
                fontSize = "medium",
                width = "full",
            },

        },
    }
end

function ItemEra.Settings:Initialize()
    ItemEra.DB_SETTINGS = LibStub("AceDB-3.0"):New("ItemEraDB", defaults, true)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("ItemEra", GetOptions)

    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ItemEra", "ItemEra")
end
