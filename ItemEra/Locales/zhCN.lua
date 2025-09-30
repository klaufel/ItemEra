local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")

if not L then
    return
end

-- @Translator: Maple Saint @nanjuekaien1

L["SELECT_EXPANSION"] = "选择扩展"
L["ALL_EXPANSION"] = "所有扩展"
L["EXPANSION"] = "扩展:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "扩展显示"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "配置ItemEra的显示选项。"

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "显示'扩展'文字"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "在工具提示中显示名称和标志之前的'扩展'文字"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "显示扩展名称"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "在工具提示中显示图标旁边的扩展名称"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "显示扩展标志"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "在工具提示中显示图标旁边的扩展标志"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "（不会显示工具提示）"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "工具提示预览："

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "修饰键"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "使用修饰键"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] = "仅在按住修饰键时显示扩展信息。"

L["SETTINGS_KEY_MODIFIER_NAME"] = "修饰键"
L["SETTINGS_KEY_MODIFIER_DESC"] = "选择用于显示扩展信息的修饰键。"

L["SETTINGS_FILTERS_HEADER_NAME"] = "扩展过滤器"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "在游戏的不同窗口中启用或禁用扩展过滤器。"

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "背包"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "在背包中启用扩展过滤器"

L["SETTINGS_FILTERS_BANK_NAME"] = "个人银行"
L["SETTINGS_FILTERS_BANK_DESC"] = "在个人银行中启用扩展过滤器"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "公会银行"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "在公会银行中启用扩展过滤器"

L["SETTINGS_RELOAD_REQUIRED"] = "过滤器更改需要重新加载界面（/reload）才能生效。"
L["SETTINGS_RELOAD_POPUP_TEXT"] = "过滤器更改需要重新加载界面才能生效。"
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "立即重新加载"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "稍后"
L["SETTINGS_RESET_NAME"] = "重置设置"
L["SETTINGS_RESET_DESC"] = "将所有设置重置为默认值"
