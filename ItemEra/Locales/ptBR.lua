local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptBR")

if not L then
    return
end

L["SELECT_EXPANSION"] = "Selecionar expansão"
L["ALL_EXPANSION"] = "Todas as expansões"
L["EXPANSION"] = "Expansão:"
L["PROFESSION"] = "Profissão:"

L["SETTINGS_MAIN_DESCRIPTION"] = "Filtra e exibe informações da expansão para seus itens."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "Tooltip"
L["SETTINGS_SUBPAGE_FILTERS"] = "Filtros"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "Exibição de expansão"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "Configure as opções de exibição do ItemEra."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "Literal 'Expansão'"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "Mostra o literal 'Expansão' antes do nome e logo nos tooltips"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "Nome da expansão"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "Mostra o nome da expansão ao lado do ícone nos tooltips"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "Logo da expansão"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "Mostra o logo da expansão ao lado do ícone nos tooltips"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "Exibição de profissão"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "Configure as opções de exibição de profissão para reagentes de fabricação."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "Literal 'Profissão'"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "Mostra o literal 'Profissão' antes do nome e ícone nos tooltips"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "Nome da profissão"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "Mostra o nome da profissão nos tooltips"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "Ícone da profissão"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "Mostra o ícone da profissão nos tooltips"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "Quebrar texto da profissão"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "Quebra o texto da profissão em várias linhas quando é muito longo"

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

L["SETTINGS_DISCORD_NAME"] = "Entrar no Discord"
L["SETTINGS_DISCORD_DESC"] = "Entre na nossa comunidade Discord para suporte e atualizações"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "Copie este link para entrar no nosso Discord:"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "Decorações de itens"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "Mostra ícones de expansão nos itens do seu inventário."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "Habilitar decorações de itens"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] =
"Mostra um pequeno ícone de expansão em cada item das suas bolsas. Passe o mouse sobre o ícone para ver o nome da expansão."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Integração com Baganator"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator detectado!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator não detectado."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] =
"ItemEra adicionará ícones de expansão nos cantos dos itens no Baganator. Os filtros nativos são desabilitados quando o Baganator está ativo."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] = "Instale o Baganator para usar a integração de categorias por expansão."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Habilitar integração com Baganator"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Mostra ícones de expansão nos itens quando usa o Baganator"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Integração com Bagnon"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon detectado!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon não detectado."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] =
"ItemEra adicionará filtros de expansão ao Bagnon. Os filtros nativos são desabilitados quando o Bagnon está ativo."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Instale o Bagnon para usar a integração de filtros por expansão."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Habilitar integração com Bagnon"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Mostra o seletor de filtro por expansão quando usa o Bagnon"

L["SETTINGS_SUBPAGE_ADVANCED"] = "Avançado"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "Substituição da API"
L["SETTINGS_API_HOOK_DESCRIPTION"] =
"Substitui a função C_Item.GetItemInfo do jogo para que TODOS os addons recebam os IDs de expansão corrigidos do ItemEra em vez dos valores padrão do jogo."
L["SETTINGS_API_HOOK_WARNING"] =
"Aviso: Este recurso é experimental e modifica uma função principal do jogo. Pode causar problemas de compatibilidade com outros addons. Use por sua conta e risco."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "Ativar substituição da API"
L["SETTINGS_API_HOOK_ENABLED_DESC"] =
"Substituir C_Item.GetItemInfo para retornar globalmente os IDs de expansão do ItemEra"
