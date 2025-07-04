local addonName, addon = ...
local locale = GetLocale()

if locale == "zhCN" then
    addon.L = addon.L or {}
    local L = addon.L

    -- COMMON
    L["COMMON.ADDON_LOADED"] = "[ItemEra]: 插件已加载"
    L["COMMON.SAVE"] = "保存"
    L["COMMON.CANCEL"] = "取消"
    L["COMMON.FILTER"] = "过滤"

    -- SETTINGS
    L["SETTINGS.TITLE"] = "设置"
    L["SETTINGS.RESET_TO_DEFAULT"] = "恢复为默认设置"
    -- SETTINGS.EXPANSION_TOOLTIP
    L["SETTINGS.EXPANSION_TOOLTIP.ENABLE"] = "启用资料片信息"
    L["SETTINGS.EXPANSION_TOOLTIP.TITLE"] = "在物品提示信息中显示资料片"
    L["SETTINGS.EXPANSION_TOOLTIP.TOOLTIP"] = "在物品提示信息中显示其来源的资料片。"
    -- SETTINGS.EXPANSION_FILTER
    L["SETTINGS.EXPANSION_FILTER.TITLE"] = "显示资料片过滤"
    L["SETTINGS.EXPANSION_FILTER.TOOLTIP"] = "启用按资料片过滤物品的功能。"

    -- UI
    -- TOOLTIP
    L["TOOLTIP.EXPANSION"] = "资料片："
    L["TOOLTIP.ORIGIN"] = "来源："
    -- FILTER
    L["FILTER.FILTER_ITEMS_BY_EXPANSION"] = "按资料片过滤物品"
    L["FILTER.FILTER_GUILD_BANK_ITEMS_BY_EXPANSION"] = "按资料片过滤物品(公会银行)"
    L["FILTER.CLICK_CHOOSE_EXPANSION"] = "点击选择资料片"
end
