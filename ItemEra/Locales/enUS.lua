local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if not L then
    return
end

L["SELECT_EXPANSION"] = "Select expansion"
L["ALL_EXPANSION"] = "All expansions"
L["EXPANSION"] = "Expansion:"
L["PROFESSION"] = "Profession:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Filter and display expansion information for your items."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Tooltip"
L["SETTINGS_SUBPAGE_FILTERS"] = "Filters"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Expansion Display"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure ItemEra display options."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "'Expansion' literal"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Shows the 'Expansion' literal before the name and logo in tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Expansion name"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Shows the expansion name next to the icon in tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Expansion logo"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Shows the expansion logo next to the icon in tooltips"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "Profession Display"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "Configure profession display options for crafting reagents."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "'Profession' literal"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "Shows the 'Profession' literal before the name and icon in tooltips"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "Profession name"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "Shows the profession name in tooltips"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "Profession icon"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "Shows the profession icon in tooltips"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "Wrap profession text"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "Wraps the profession text to multiple lines when it's too long"

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
L["SETTINGS_RESET_NAME"] = "Default settings"
L["SETTINGS_RESET_DESC"] = "Resets all settings to their default values"

L["SETTINGS_DISCORD_NAME"] = "Join Discord"
L["SETTINGS_DISCORD_DESC"] = "Join our Discord community for support and updates"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Copy this link to join our Discord:"

L["SETTINGS_FEATURES_POPUP_NAME"] = "What's New"
L["SETTINGS_FEATURES_POPUP_DESC"] = "See what's new in this version"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Item Decorations"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Show expansion icons on items in your inventory."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Enable item decorations"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] = "Shows a small expansion icon on each item in your bags. Hover over the icon to see the expansion name."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Baganator Integration"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator detected!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator not detected."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] = "ItemEra will add expansion icons to item corners in Baganator. Native filters are disabled when Baganator is active."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] = "Install Baganator to use expansion category integration."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Enable Baganator Integration"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Show expansion icons on items when using Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Bagnon Integration"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon detected!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon not detected."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] = "ItemEra will add expansion filters to Bagnon. Native filters are disabled when Bagnon is active."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Install Bagnon to use expansion filter integration."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Enable Bagnon Integration"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Show expansion filter dropdown when using Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Advanced"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "API Override"
L["SETTINGS_API_HOOK_DESCRIPTION"] = "Override the game's C_Item.GetItemInfo function so that ALL addons receive ItemEra's corrected expansion IDs instead of the game's default values."
L["SETTINGS_API_HOOK_WARNING"] = "Warning: This is an experimental feature that modifies a core game function. It may cause compatibility issues with other addons. Use at your own risk."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Enable API Override"
L["SETTINGS_API_HOOK_ENABLED_DESC"] = "Replace C_Item.GetItemInfo to return ItemEra's expansion IDs globally"

-- Features Popup
L["FEATURES_POPUP_TITLE"] = "What's New"
L["FEATURES_POPUP_VERSION"] = "Version"
L["FEATURES_POPUP_CLOSE"] = "Close"
L["FEATURES_POPUP_DONT_SHOW_AGAIN"] = "Don't show again for this version"
L["FEATURES_POPUP_CONTENT"] = [[
|cff00ff00Hey! What's new in this version?|r

|cffffd700Crafting Reagents|r
Now the tooltip shows which professions use each reagent. Based on all in-game recipes and linked to their profession. Updated database with support for reagent ranks.

You can customize how professions are displayed (icon + name, name only, or icon only).

|cffffd700In the previous version:|r
- Filter support for Baganator and Bagnon (using internal search)
- More configuration options in the completely redesigned "Settings" section

Thank you for using ItemEra!
]]
