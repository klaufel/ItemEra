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
            enabledBagnonIntegration = true,
            enabledAPIHook = false,
            showExpansionName = true,
            showExpansionLogo = true,
            showExpansionLiteral = true,
            showProfessionLiteral = true,
            showProfessionName = true,
            showProfessionIcon = true,
            wrapProfessionText = false,
            useKeyModifier = false,
            keyModifier = ItemEra.Utils.KeyModifiers.SHIFT,
            lastShownFeaturesPopupKey = nil
        }
    }
}

local function HandleUpdateSettingsValue(info, value)
    local key = info[#info]
    ItemEra.DB_SETTINGS.global.settings[key] = value

    if key == "enabledFiltersInventory" or key == "enabledFiltersBank" or key == "enabledFiltersGuildBank" or key == "enabledDecorations" or key == "enabledBaganatorIntegration" or key == "enabledBagnonIntegration" or key == "enabledAPIHook" then
        StaticPopup_Show("ITEMERA_RELOAD_UI")
    end

    LibStub("AceConfigRegistry-3.0"):NotifyChange("ItemEra")
end

local function HandleGetSettingsValue(info)
    local key = info[#info]
    return ItemEra.DB_SETTINGS.global.settings[key]
end


local function GetTooltipPreview(type)
    local isExpansionDisabled = not ItemEra.DB_SETTINGS.global.settings.showExpansionName and
        not ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
    local isProfessionDisabled = not ItemEra.DB_SETTINGS.global.settings.showProfessionName and
        not ItemEra.DB_SETTINGS.global.settings.showProfessionIcon

    if (type == 'expansion') then
        local expansionID = 11 -- MN
        local expansionText = ItemEra.Utils:GetExpansionTextByExpansionID(expansionID)
        local expansionPreview = not isExpansionDisabled and expansionText ~= "" and expansionText or
            "|cffff0000" .. L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] .. "|r"
        return expansionPreview
    end
    if (type == 'profession') then
        local itemID = 14047 -- Runecloth
        local professionText = ItemEra.Utils:GetProfessionTextByItemID(itemID)
        local professionPreview = not isProfessionDisabled and professionText ~= "" and professionText or
            "|cffff0000" .. L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] .. "|r"
        return professionPreview
    end


    return ""
end

local function GetOptions()
    return {
        type = "group",
        name = "ItemEra - Filter Expansion Items",
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
                        width = 1,
                        disabled = function()
                            return not ItemEra.DB_SETTINGS.global.settings.showExpansionName and
                                not ItemEra.DB_SETTINGS.global.settings.showExpansionLogo
                        end,
                        order = 5,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showExpansionLogo = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"],
                        desc = L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"],
                        width = 1,
                        order = 6,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showExpansionName = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_EXPANSION_NAME_NAME"],
                        desc = L["SETTINGS_SHOW_EXPANSION_NAME_DESC"],
                        width = 1,
                        order = 7,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    spacerPreviewExpansion = {
                        type = "description",
                        name = "\n",
                        order = 10,
                    },
                    previewExpansion = {
                        type = "description",
                        name = GetTooltipPreview("expansion"),
                        order = 11,
                        fontSize = "medium",
                        width = 3,
                    },
                    spacer1 = {
                        type = "description",
                        name = "\n",
                        order = 20,
                    },
                    professionHeader = {
                        type = "header",
                        name = L["SETTINGS_PROFESSION_HEADER_NAME"],
                        order = 25,
                    },
                    professionDescription = {
                        type = "description",
                        name = "\n" .. L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] .. "\n\n",
                        order = 26,
                    },
                    showProfessionLiteral = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"],
                        desc = L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"],
                        width = 1,
                        disabled = function()
                            return not ItemEra.DB_SETTINGS.global.settings.showProfessionName and
                                not ItemEra.DB_SETTINGS.global.settings.showProfessionIcon
                        end,
                        order = 30,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showProfessionIcon = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_PROFESSION_ICON_NAME"],
                        desc = L["SETTINGS_SHOW_PROFESSION_ICON_DESC"],
                        width = 1,
                        order = 31,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    showProfessionName = {
                        type = "toggle",
                        name = L["SETTINGS_SHOW_PROFESSION_NAME_NAME"],
                        desc = L["SETTINGS_SHOW_PROFESSION_NAME_DESC"],
                        width = 1,
                        order = 32,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    wrapProfessionText = {
                        type = "toggle",
                        name = L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"],
                        desc = L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"],
                        width = "full",
                        disabled = function()
                            return not ItemEra.DB_SETTINGS.global.settings.showProfessionName and
                                not ItemEra.DB_SETTINGS.global.settings.showProfessionIcon
                        end,
                        order = 33,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    spacerPreviewProfession = {
                        type = "description",
                        name = "\n",
                        order = 34,
                    },
                    previewProfession = {
                        type = "description",
                        name = GetTooltipPreview("profession"),
                        order = 35,
                        fontSize = "medium",
                        width = ItemEra.DB_SETTINGS.global.settings.wrapProfessionText and 1 or 3,
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
                                return "\n|cff00ff00" ..
                                    L["SETTINGS_BAGANATOR_DETECTED"] ..
                                    "|r " .. L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] .. "\n\n"
                            else
                                return "\n|cff888888" ..
                                    L["SETTINGS_BAGANATOR_NOT_DETECTED"] ..
                                    "|r " .. L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] .. "\n\n"
                            end
                        end,
                        order = 101,
                    },
                    enabledBaganatorIntegration = {
                        type = "toggle",
                        name = '(Experimental) ' .. L["SETTINGS_BAGANATOR_ENABLED_NAME"],
                        desc = L["SETTINGS_BAGANATOR_ENABLED_DESC"],
                        width = "full",
                        order = 110,
                        disabled = function() return not ItemEra.Utils:IsBaganatorLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                    spacer2 = {
                        type = "description",
                        name = "\n\n",
                        order = 150,
                    },
                    bagnonHeader = {
                        type = "header",
                        name = L["SETTINGS_BAGNON_HEADER_NAME"],
                        order = 200,
                    },
                    bagnonDescription = {
                        type = "description",
                        name = function()
                            if ItemEra.Utils:IsBagnonLoaded() then
                                return "\n|cff00ff00" ..
                                    L["SETTINGS_BAGNON_DETECTED"] ..
                                    "|r " .. L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] .. "\n\n"
                            else
                                return "\n|cff888888" ..
                                    L["SETTINGS_BAGNON_NOT_DETECTED"] ..
                                    "|r " .. L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] .. "\n\n"
                            end
                        end,
                        order = 201,
                    },
                    enabledBagnonIntegration = {
                        type = "toggle",
                        name = '(Experimental) ' .. L["SETTINGS_BAGNON_ENABLED_NAME"],
                        desc = L["SETTINGS_BAGNON_ENABLED_DESC"],
                        width = "full",
                        order = 210,
                        disabled = function() return not ItemEra.Utils:IsBagnonLoaded() end,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                },
            },
            advanced = {
                type = "group",
                name = L["SETTINGS_SUBPAGE_ADVANCED"],
                order = 3,
                args = {
                    apiHookHeader = {
                        type = "header",
                        name = L["SETTINGS_API_HOOK_HEADER_NAME"],
                        order = 1,
                    },
                    apiHookDescription = {
                        type = "description",
                        name = "\n" .. L["SETTINGS_API_HOOK_DESCRIPTION"] .. "\n\n",
                        order = 2,
                    },
                    apiHookWarning = {
                        type = "description",
                        name = "|cffff9900" .. L["SETTINGS_API_HOOK_WARNING"] .. "|r\n\n",
                        order = 3,
                    },
                    enabledAPIHook = {
                        type = "toggle",
                        name = '(Experimental) ' .. L["SETTINGS_API_HOOK_ENABLED_NAME"],
                        desc = L["SETTINGS_API_HOOK_ENABLED_DESC"],
                        width = "full",
                        order = 10,
                        get = HandleGetSettingsValue,
                        set = HandleUpdateSettingsValue,
                    },
                },
            },
            resetButton = {
                type = "execute",
                name = L["SETTINGS_RESET_NAME"],
                desc = L["SETTINGS_RESET_DESC"],
                order = 0,
                width = 1.2,
                func = function()
                    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersInventory ~= defaults.global.settings.enabledFiltersInventory or
                        ItemEra.DB_SETTINGS.global.settings.enabledFiltersBank ~= defaults.global.settings.enabledFiltersBank or
                        ItemEra.DB_SETTINGS.global.settings.enabledFiltersGuildBank ~= defaults.global.settings.enabledFiltersGuildBank then
                        StaticPopup_Show("ITEMERA_RELOAD_UI")
                    end
                    ItemEra.DB_SETTINGS:ResetDB()
                end
            },
            discordButton = {
                type = "execute",
                name = L["SETTINGS_DISCORD_NAME"],
                desc = L["SETTINGS_DISCORD_DESC"],
                order = 0.1,
                width = 1.2,
                func = function()
                    StaticPopup_Show("ITEMERA_DISCORD_LINK")
                end
            },
            featuresPopupButton = {
                type = "execute",
                name = L["SETTINGS_FEATURES_POPUP_NAME"],
                desc = L["SETTINGS_FEATURES_POPUP_DESC"],
                order = 0.2,
                width = 1.2,
                func = function()
                    ItemEra.FeaturesPopup:Show()
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

StaticPopupDialogs["ITEMERA_DISCORD_LINK"] = {
    text = L["SETTINGS_DISCORD_POPUP_TEXT"],
    button1 = "OK",
    hasEditBox = true,
    editBoxWidth = 250,
    OnShow = function(self, data)
        local editBox = self.editBox or _G[self:GetName() .. "EditBox"]
        if editBox then
            editBox:SetText("https://discord.gg/xABSSjqpNW")
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
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
