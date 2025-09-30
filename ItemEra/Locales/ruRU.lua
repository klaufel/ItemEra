local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")

if not L then
    return
end

-- @Translator: ZamestoTV

L["SELECT_EXPANSION"] = "Выбрать дополнение"
L["ALL_EXPANSION"] = "Все дополнения"
L["EXPANSION"] = "Дополнение:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Отображение дополнений"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Настройте параметры отображения ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Показать текст 'Дополнение'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Показывает текст 'Дополнение' перед именем и логотипом в подсказках"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Показать название дополнения"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Показывает название дополнения рядом с иконкой в подсказках"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Показать логотип дополнения"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Показывает логотип дополнения рядом с иконкой в подсказках"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(Подсказка не будет показана)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Предварительный просмотр подсказки:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Клавиша-модификатор"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Использовать клавишу-модификатор"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] = "Показывать информацию о дополнении только при удержании клавиши-модификатора."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Клавиша-модификатор"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Выберите клавишу-модификатор, которая будет использоваться для отображения информации о дополнении."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Фильтры дополнений"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "Включает или отключает фильтры дополнений в различных окнах игры."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Инвентарь"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Включает фильтры дополнений в сумках инвентаря"

L["SETTINGS_FILTERS_BANK_NAME"] = "Личный банк"
L["SETTINGS_FILTERS_BANK_DESC"] = "Включает фильтры дополнений в личном банке"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Банк гильдии"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Включает фильтры дополнений в банке гильдии"

L["SETTINGS_RELOAD_REQUIRED"] = "Изменения фильтров требуют перезагрузки интерфейса (/reload) для применения."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "Изменения фильтров требуют перезагрузки интерфейса для применения."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Перезагрузить сейчас"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Позже"
L["SETTINGS_RESET_NAME"] = "Сбросить настройки"
L["SETTINGS_RESET_DESC"] = "Сбросить все настройки к значениям по умолчанию"
