local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")

if not L then
    return
end

-- @Translator: Maple Saint @nanjuekaien1

L["SELECT_EXPANSION"] = "选择扩展"
L["ALL_EXPANSION"] = "所有扩展"
L["EXPANSION"] = "扩展:"
L["PROFESSION"] = "专业:"

L["SETTINGS_MAIN_DESCRIPTION"] = "为您的物品筛选和显示扩展信息。"
L["SETTINGS_SUBPAGE_TOOLTIP"] = "工具提示"
L["SETTINGS_SUBPAGE_FILTERS"] = "过滤器"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "扩展显示"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "配置ItemEra的显示选项。"

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "'扩展'文字"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "在工具提示中显示名称和标志之前的'扩展'文字"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "扩展名称"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "在工具提示中显示图标旁边的扩展名称"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "扩展标志"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "在工具提示中显示图标旁边的扩展标志"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "专业显示"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "配置制作材料的专业显示选项。"

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "'专业'文字"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "在工具提示中显示名称和图标之前的'专业'文字"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "专业名称"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "在工具提示中显示专业名称"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "专业图标"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "在工具提示中显示专业图标"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "专业文字换行"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "当专业文字过长时，将其换行显示"

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

L["SETTINGS_DISCORD_NAME"] = "加入Discord"
L["SETTINGS_DISCORD_DESC"] = "加入我们的Discord社区获取支持和更新"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "复制此链接加入我们的Discord："

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "物品装饰"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "在您背包中的物品上显示扩展图标。"
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "启用物品装饰"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] = "在背包中每个物品上显示一个小扩展图标。将鼠标悬停在图标上可查看扩展名称。"

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Baganator集成"
L["SETTINGS_BAGANATOR_DETECTED"] = "检测到Baganator！"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "未检测到Baganator。"
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] = "ItemEra将在Baganator中为物品角落添加扩展图标。当Baganator激活时，原生过滤器将被禁用。"
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] = "安装Baganator以使用按扩展分类的类别集成。"
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "启用Baganator集成"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "使用Baganator时在物品上显示扩展图标"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Bagnon集成"
L["SETTINGS_BAGNON_DETECTED"] = "检测到Bagnon！"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "未检测到Bagnon。"
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] = "ItemEra将在Bagnon中添加扩展过滤器。当Bagnon激活时，原生过滤器将被禁用。"
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "安装Bagnon以使用按扩展过滤的集成。"
L["SETTINGS_BAGNON_ENABLED_NAME"] = "启用Bagnon集成"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "使用Bagnon时显示扩展过滤器选择器"

L["SETTINGS_SUBPAGE_ADVANCED"] = "高级"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "API 覆盖"
L["SETTINGS_API_HOOK_DESCRIPTION"] = "覆盖游戏的 C_Item.GetItemInfo 函数，使所有插件都能接收到 ItemEra 修正后的资料片 ID，而不是游戏的默认值。"
L["SETTINGS_API_HOOK_WARNING"] = "警告：此功能为实验性功能，会修改游戏的核心函数，可能会导致与其他插件的兼容性问题。请自行承担风险。"
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "启用 API 覆盖"
L["SETTINGS_API_HOOK_ENABLED_DESC"] = "替换 C_Item.GetItemInfo 以全局返回 ItemEra 的资料片 ID"
