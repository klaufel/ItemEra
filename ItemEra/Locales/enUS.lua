local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if not L then
    return
end

L["SELECT_EXPANSION"] = "Select expansion"
L["ALL_EXPANSION"] = "All expansions"
L["EXPANSION"] = "Expansion:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Expansion Display"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure ItemEra display options."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Show 'Expansion' literal"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Shows the 'Expansion' literal before the name and logo in tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Show expansion name"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Shows the expansion name next to the icon in tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Show expansion logo"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Shows the expansion logo next to the icon in tooltips"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(Tooltip will not be shown)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Tooltip preview:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Key Modifier"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Use key modifier"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] = "Only shows expansion information when a modifier key is held down."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Modifier key"
L["SETTINGS_KEY_MODIFIER_DESC"] = "Select the modifier key that will be used to show expansion information."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Expansion Filters"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "Enable or disable expansion filters in different game windows."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Inventory"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Enables expansion filters in inventory bags"

L["SETTINGS_FILTERS_BANK_NAME"] = "Personal Bank"
L["SETTINGS_FILTERS_BANK_DESC"] = "Enables expansion filters in the personal bank"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Guild Bank"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Enables expansion filters in the guild bank"

L["SETTINGS_RELOAD_REQUIRED"] = "Filter changes require reloading the interface (/reload) to apply."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "Filter changes require reloading the interface to apply."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Reload now"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Later"
L["SETTINGS_RESET_NAME"] = "Reset settings"
L["SETTINGS_RESET_DESC"] = "Resets all settings to their default values"
