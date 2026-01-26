local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")

if not L then
    return
end

-- @Translator: ZamestoTV

L["SELECT_EXPANSION"] = "Выбрать дополнение"
L["ALL_EXPANSION"] = "Все дополнения"
L["EXPANSION"] = "Дополнение:"
L["PROFESSION"] = "Профессия:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Фильтруйте и отображайте информацию о дополнении для ваших предметов."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Подсказка"
L["SETTINGS_SUBPAGE_FILTERS"] = "Фильтры"

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

L["SETTINGS_DISCORD_NAME"] = "Присоединиться к Discord"
L["SETTINGS_DISCORD_DESC"] = "Присоединяйтесь к нашему сообществу Discord для поддержки и обновлений"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Скопируйте эту ссылку, чтобы присоединиться к нашему Discord:"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Украшения предметов"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Показывает значки дополнений на предметах в вашем инвентаре."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Включить украшения предметов"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] =
"Показывает маленький значок дополнения на каждом предмете в ваших сумках. Наведите курсор на значок, чтобы увидеть название дополнения."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Интеграция с Baganator"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator обнаружен!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator не обнаружен."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] =
"ItemEra добавит значки дополнений в углы предметов в Baganator. Встроенные фильтры отключены, когда Baganator активен."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] =
"Установите Baganator для использования интеграции категорий по дополнениям."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Включить интеграцию с Baganator"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Показывает значки дополнений на предметах при использовании Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Интеграция с Bagnon"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon обнаружен!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon не обнаружен."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] =
"ItemEra добавит фильтры дополнений в Bagnon. Встроенные фильтры отключены, когда Bagnon активен."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Установите Bagnon для использования интеграции фильтров по дополнениям."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Включить интеграцию с Bagnon"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Показывает выбор фильтра по дополнениям при использовании Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Дополнительно"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "Переопределение API"
L["SETTINGS_API_HOOK_DESCRIPTION"] =
"Переопределяет функцию C_Item.GetItemInfo игры, чтобы ВСЕ аддоны получали исправленные идентификаторы дополнений ItemEra вместо стандартных значений игры."
L["SETTINGS_API_HOOK_WARNING"] =
"Предупреждение: Эта функция является экспериментальной и изменяет основную функцию игры. Это может вызвать проблемы совместимости с другими аддонами. Используйте на свой страх и риск."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Включить переопределение API"
L["SETTINGS_API_HOOK_ENABLED_DESC"] =
"Заменить C_Item.GetItemInfo для глобального возврата идентификаторов дополнений ItemEra"
