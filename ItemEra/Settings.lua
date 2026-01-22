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
            enabledDecorations = false,
            enabledBaganatorIntegration = true,
            showExpansionName = true,
            showExpansionLogo = true,
            showExpansionLiteral = true,
            useKeyModifier = false,
            keyModifier = ItemEra.Utils.KeyModifiers.SHIFT
        }
    }
}

local function HandleUpdateSettingsValue(info, value)
    local key = info[#info]
    ItemEra.DB_SETTINGS.global.settings[key] = value

    if key == "enabledFiltersInventory" or key == "enabledFiltersBank" or key == "enabledFiltersGuildBank" or key == "enabledDecorations" or key == "enabledBaganatorIntegration" then
        StaticPopup_Show("ITEMERA_RELOAD_UI")
    end

    LibStub("AceConfigRegistry-3.0"):NotifyChange("ItemEra")
end

local function HandleGetSettingsValue(info)
    local key = info[#info]
    return ItemEra.DB_SETTINGS.global.settings[key]
end


local function GetTooltipPreview()
    local isDisabled = not ItemEra.DB_SETTINGS.global.settings.showExpansionName and
        not ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
    local expansionID = 11 -- MN
    local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(expansionID)
    local tooltipPreview = not isDisabled and expansionText ~= "" and expansionText or
        "|cffff0000" .. L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] .. "|r"

    return L["SETTINGS_TOOLTIP_PREVIEW_NAME"] .. "\n\n\n" .. tooltipPreview
end

local function GetOptions()
    return {
        type = "group",
        name = "ItemEra",
        childGroups = "tab",
        args = {
            tooltip = {
                type = "group",
                name = L["SETTINGS_SUBPAGE_TOOLTIP"],
                order = 1,
                args = {
                    tooltipHeader = {
                        type = "header",
                        name = L["SETTINGS_TOOLTIP_HEADER_NAME"],
                        order = 1,
                    },
                    tooltipDescription = {
                        type = "description",
                        name = "\n" .. L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] .. "\n\n",
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
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showExpansionName = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_EXPANSION_NAME_NAME"],
                        desc = L["SETTINGS_SHOW_EXPANSION_NAME_DESC"],
                        width = "full",
                        order = 11,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showExpansionLogo = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"],
                        desc = L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"],
                        width = "full",
                        order = 12,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    spacer1 = {
                        type = "description",
                        name = "\n\n",
                        order = 20,
                    },
                    preview = {
                        type = "description",
                        name = GetTooltipPreview,
                        order = 21,
                        fontSize = "medium",
                        width = "full",
                    },
                    spacer2 = {
                        type = "description",
                        name = "\n\n",
                        order = 50,
                    },
                    keyModifierHeader = {
                        type = "header",
                        name = L["SETTINGS_KEY_MODIFIER_HEADER_NAME"],
                        order = 60,
                    },
                    keyModifierDescription = {
                        type = "description",
                        name = "\n" .. L["SETTINGS_USE_KEY_MODIFIER_DESC"] .. "\n\n",
                        order = 61,
                    },
                    useKeyModifier = {
                        type = "toggle",
                        name = L["SETTINGS_USE_KEY_MODIFIER_NAME"],
                        desc = L["SETTINGS_USE_KEY_MODIFIER_DESC"],
                        width = "full",
                        order = 70,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    keyModifier = {
                        type = "select",
                        name = L["SETTINGS_KEY_MODIFIER_NAME"],
                        desc = L["SETTINGS_KEY_MODIFIER_DESC"],
                        width = "normal",
                        order = 80,
                        disabled = function() return not ItemEra.DB_SETTINGS.global.settings.useKeyModifier end,
                        values = {
                            [ItemEra.Utils.KeyModifiers.ALT] = "Alt",
                            [ItemEra.Utils.KeyModifiers.CTRL] = "Control",
                            [ItemEra.Utils.KeyModifiers.SHIFT] = "Shift",
                        },
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                },
            },
            filters = {
                type = "group",
                name = L["SETTINGS_SUBPAGE_FILTERS"],
                order = 2,
                args = {
                    filtersHeader = {
                        type = "header",
                        name = L["SETTINGS_FILTERS_HEADER_NAME"],
                        order = 1,
                    },
                    filtersDescription = {
                        type = "description",
                        name = "\n" .. L["SETTINGS_FILTERS_DESCRIPTION_NAME"] .. "\n\n",
                        order = 2,
                    },
                    enabledFiltersInventory = {
                        type = "toggle",
                        name = L["SETTINGS_FILTERS_INVENTORY_NAME"],
                        desc = L["SETTINGS_FILTERS_INVENTORY_DESC"],
                        width = "full",
                        order = 10,
                        disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    enabledFiltersBank = {
                        type = "toggle",
                        name = L["SETTINGS_FILTERS_BANK_NAME"],
                        desc = L["SETTINGS_FILTERS_BANK_DESC"],
                        width = "full",
                        order = 11,
                        disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    enabledFiltersGuildBank = {
                        type = "toggle",
                        name = L["SETTINGS_FILTERS_GUILD_BANK_NAME"],
                        desc = L["SETTINGS_FILTERS_GUILD_BANK_DESC"],
                        width = "full",
                        order = 12,
                        disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    spacer1 = {
                        type = "description",
                        name = "\n\n",
                        order = 50,
                    },
                    baganatorHeader = {
                        type = "header",
                        name = L["SETTINGS_BAGANATOR_HEADER_NAME"],
                        order = 100,
                    },
                    baganatorDescription = {
                        type = "description",
                        name = function()
                            if ItemEra.Utils:IsBaganatorLoaded() then
                                return "\n|cff00ff00" .. L["SETTINGS_BAGANATOR_DETECTED"] .. "|r " .. L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] .. "\n\n"
                            else
                                return "\n|cff888888" .. L["SETTINGS_BAGANATOR_NOT_DETECTED"] .. "|r " .. L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] .. "\n\n"
                            end
                        end,
                        order = 101,
                    },
                    enabledBaganatorIntegration = {
                        type = "toggle",
                        name = L["SETTINGS_BAGANATOR_ENABLED_NAME"],
                        desc = L["SETTINGS_BAGANATOR_ENABLED_DESC"],
                        width = "full",
                        order = 110,
                        disabled = function() return not ItemEra.Utils:IsBaganatorLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                },
            },
            reset = {
                type = "group",
                name = L["SETTINGS_RESET_NAME"],
                order = 3,
                args = {
                    resetDescription = {
                        type = "description",
                        name = L["SETTINGS_RESET_DESC"] .. "\n\n",
                        order = 1,
                    },
                    resetButton = {
                        type = "execute",
                        name = L["SETTINGS_RESET_NAME"],
                        desc = L["SETTINGS_RESET_DESC"],
                        order = 2,
                        func = function()
                            if ItemEra.DB_SETTINGS.global.settings.enabledFiltersInventory ~= defaults.global.settings.enabledFiltersInventory or
                                ItemEra.DB_SETTINGS.global.settings.enabledFiltersBank ~= defaults.global.settings.enabledFiltersBank or
                                ItemEra.DB_SETTINGS.global.settings.enabledFiltersGuildBank ~= defaults.global.settings.enabledFiltersGuildBank then
                                StaticPopup_Show("ITEMERA_RELOAD_UI")
                            end
                            ItemEra.DB_SETTINGS:ResetDB()
                        end
                    },
                },
            },
        },
    }
end

StaticPopupDialogs["ITEMERA_RELOAD_UI"] = {
    text = L["SETTINGS_RELOAD_POPUP_TEXT"],
    button1 = L["SETTINGS_RELOAD_POPUP_BUTTON1"],
    button2 = L["SETTINGS_RELOAD_POPUP_BUTTON2"],
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function ItemEra.Settings:Initialize()
    ItemEra.DB_SETTINGS = LibStub("AceDB-3.0"):New("ItemEraDB", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("ItemEra", GetOptions)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ItemEra", "ItemEra")
end
