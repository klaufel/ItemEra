local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptBR")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Selecionar expansão"
L["ALL_EXPANSION"] = "Todas as expansões"
L["EXPANSION"] = "Expansão:"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Exibição de expansão"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure as opções de exibição do ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Mostrar literal 'Expansão'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Mostra o literal 'Expansão' antes do nome e logo nos tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Mostrar nome da expansão"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Mostra o nome da expansão ao lado do ícone nos tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Mostrar logo da expansão"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Mostra o logo da expansão ao lado do ícone nos tooltips"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(O tooltip não será mostrado)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "Visualização do tooltip:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "Tecla modificadora"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "Usar tecla modificadora"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] =
"Mostra as informações da expansão apenas quando uma tecla modificadora é mantida pressionada."

L["SETTINGS_KEY_MODIFIER_NAME"] = "Tecla modificadora"
L["SETTINGS_KEY_MODIFIER_DESC"] =
"Seleciona a tecla modificadora que será usada para mostrar as informações da expansão."

L["SETTINGS_FILTERS_HEADER_NAME"] = "Filtros de expansão"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "Habilita ou desabilita os filtros de expansão em diferentes janelas do jogo."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "Inventário"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "Habilita os filtros de expansão nas bolsas do inventário"

L["SETTINGS_FILTERS_BANK_NAME"] = "Banco pessoal"
L["SETTINGS_FILTERS_BANK_DESC"] = "Habilita os filtros de expansão no banco pessoal"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "Banco da guilda"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "Habilita os filtros de expansão no banco da guilda"

L["SETTINGS_RELOAD_REQUIRED"] = "Mudanças nos filtros requerem recarregar a interface (/reload) para serem aplicadas."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "Mudanças nos filtros requerem recarregar a interface para serem aplicadas."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "Recarregar agora"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "Mais tarde"
L["SETTINGS_RESET_NAME"] = "Redefinir configurações"
L["SETTINGS_RESET_DESC"] = "Redefinir todas as configurações para seus valores padrão"
