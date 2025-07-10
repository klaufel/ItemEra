local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")

if not L then
    return
end

-- @Translator: Maple Saint @nanjuekaien1

L["COMMON.ADDON_LOADED"] = "[ItemEra]: 插件已加载"
L["COMMON.SAVE"] = "保存"
L["COMMON.CANCEL"] = "取消"
L["COMMON.FILTER"] = "过滤"

L["SETTINGS.TITLE"] = "设置"
L["SETTINGS.RESET_TO_DEFAULT"] = "恢复为默认设置"
L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "启用资料片信息"
L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "在物品提示信息中显示资料片"
L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "在物品提示信息中显示其来源的资料片。"
L["SETTINGS.EXPANSION_FILTER.TITLE"] = "显示资料片过滤"
L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "启用按资料片过滤物品的功能。"

L["TOOLTIP.EXPANSION"] = "资料片："
L["TOOLTIP.ORIGIN"] = "来源："
L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "按资料片过滤物品"
L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "按资料片过滤物品(公会银行)"
L["FILTER.CLICK_CHOOSE_EXPANSION"] = "点击选择资料片"
