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
        name = "ItemEra - Filter Expansion Items",
        args = {
            br01 = {
                type = "description",
                name = "\n",
                order = 0,
            },
            tooltipHeader = {
                type = "header",
                name = L["SETTINGS_TOOLTIP_HEADER_NAME"],
                order = 1,
            },
            tooltipDescription = {
                type = "description",
                name = "\n\n" .. L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] .. "\n\n",
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
                order = 10,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            showExpansionLogo = {
                type = "toggle",
                name = L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"],
                desc = L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"],
                width = "full",
                order = 10,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
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
                name = "\n\n",
                order = 50,
            },
            keyModifierHeader = {
                type = "header",
                name = L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] .. "\n",
                order = 60,
            },
            useKeyModifier = {
                type = "toggle",
                name = L["SETTINGS_USE_KEY_MODIFIER_NAME"],
                desc = "Solo muestra la información de expansión cuando se mantiene presionada una tecla modificadora",
                width = "full",
                order = 70,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            keyModifier = {
                type = "select",
                name = L["SETTINGS_KEY_MODIFIER_NAME"] .. "\n",
                desc = L["SETTINGS_KEY_MODIFIER_DESC"],
                width = "80",
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
            spacer3 = {
                type = "description",
                name = "\n\n",
                order = 90,
            },
            filtersHeader = {
                type = "header",
                name = L["SETTINGS_FILTERS_HEADER_NAME"],
                order = 100,
            },
            filtersDescription = {
                type = "description",
                name = "\n\n" .. L["SETTINGS_FILTERS_DESCRIPTION_NAME"] .. "\n\n",
                order = 110,
            },
            enabledFiltersInventory = {
                type = "toggle",
                name = L["SETTINGS_FILTERS_INVENTORY_NAME"],
                desc = L["SETTINGS_FILTERS_INVENTORY_DESC"],
                width = "auto",
                order = 120,
                disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            enabledFiltersBank = {
                type = "toggle",
                name = L["SETTINGS_FILTERS_BANK_NAME"],
                desc = L["SETTINGS_FILTERS_BANK_DESC"],
                width = "auto",
                order = 120,
                disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            enabledFiltersGuildBank = {
                type = "toggle",
                name = L["SETTINGS_FILTERS_GUILD_BANK_NAME"],
                desc = L["SETTINGS_FILTERS_GUILD_BANK_DESC"],
                width = "auto",
                order = 120,
                disabled = function() return ItemEra.Utils:IsBaganatorLoaded() end,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            spacer4 = {
                type = "description",
                name = "\n\n",
                order = 130,
            },
            baganatorHeader = {
                type = "header",
                name = L["SETTINGS_BAGANATOR_HEADER_NAME"] or "Baganator Integration",
                order = 140,
            },
            baganatorDescription = {
                type = "description",
                name = function()
                    if ItemEra.Utils:IsBaganatorLoaded() then
                        return "\n\n|cff00ff00" .. (L["SETTINGS_BAGANATOR_DETECTED"] or "Baganator detected!") .. "|r " .. (L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] or "ItemEra will add expansion icons to item corners in Baganator. Native filters are disabled when Baganator is active.") .. "\n\n"
                    else
                        return "\n\n|cff888888" .. (L["SETTINGS_BAGANATOR_NOT_DETECTED"] or "Baganator not detected.") .. "|r " .. (L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] or "Install Baganator to use expansion category integration.") .. "\n\n"
                    end
                end,
                order = 150,
            },
            enabledBaganatorIntegration = {
                type = "toggle",
                name = L["SETTINGS_BAGANATOR_ENABLED_NAME"] or "Enable Baganator Integration",
                desc = L["SETTINGS_BAGANATOR_ENABLED_DESC"] or "Show expansion icons on items when using Baganator",
                width = "full",
                order = 160,
                disabled = function() return not ItemEra.Utils:IsBaganatorLoaded() end,
                get = HandleGetSettingsValue,
                set = HandleUpdateSettingsValue,
            },
            -- spacer5 = {
            --     type = "description",
            --     name = "\n\n",
            --     order = 130,
            -- },
            -- decorationsHeader = {
            --     type = "header",
            --     name = L["SETTINGS_DECORATIONS_HEADER_NAME"],
            --     order = 140,
            -- },
            -- decorationsDescription = {
            --     type = "description",
            --     name = "\n\n" .. L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] .. "\n\n",
            --     order = 150,
            -- },
            -- enabledDecorations = {
            --     type = "toggle",
            --     name = L["SETTINGS_DECORATIONS_ENABLED_NAME"],
            --     desc = L["SETTINGS_DECORATIONS_ENABLED_DESC"],
            --     width = "full",
            --     order = 160,
            --     get = HandleGetSettingsValue,
            --     set = HandleUpdateSettingsValue,
            -- },
            bdes = {
                type = "description",
                name = "\n",
                order = 800,
            },
            brlast = {
                type = "header",
                name = "",
                order = 900,
            },
            brreset = {
                type = "description",
                name = "\n",
                order = 900,
            },
            reset = {
                type = "execute",
                name = L["SETTINGS_RESET_NAME"],
                desc = L["SETTINGS_RESET_DESC"],
                order = 901,
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
