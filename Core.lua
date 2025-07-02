local addonName, addon = ...
_G[addonName] = addon

-- Inicialización de variables globales y datos
ItemEraConfig = ItemEraConfig or {}

addon.expansionColorsHex = {
    [0]  = "#F4BF2A", -- Classic
    [1]  = "#CBD86C", -- The Burning Crusade
    [2]  = "#9DC6E5", -- Wrath of the Lich King
    [3]  = "#8E3C14", -- Cataclysm
    [4]  = "#5FB177", -- Mists of Pandaria
    [5]  = "#D77500", -- Warlords of Draenor
    [6]  = "#D9E342", -- Legion
    [7]  = "#C4C6C5", -- Battle for Azeroth
    [8]  = "#F9F8F6", -- Shadowlands
    [9]  = "#B6B6BA", -- Dragonflight
    [10] = "#EA551F", -- War Within
    [11] = "#5C1FEA", -- Midnight
}

addon.expansionColors = {}
for k, hex in pairs(addon.expansionColorsHex) do
    addon.expansionColors[k] = { addon.Utils.toRGB(hex) }
end

addon.expansionNames = {
    [0] = "Classic",
    [1] = "The Burning Crusade",
    [2] = "Wrath of the Lich King",
    [3] = "Cataclysm",
    [4] = "Mists of Pandaria",
    [5] = "Warlords of Draenor",
    [6] = "Legion",
    [7] = "Battle for Azeroth",
    [8] = "Shadowlands",
    [9] = "Dragonflight",
    [10] = "War Within",
}

function addon:Init()
    if self.Config and self.Config.Init then self.Config:Init() end
    if self.Tooltip and self.Tooltip.Init then self.Tooltip:Init() end

    -- Debug: mostrar información del idioma
    local locale = GetLocale and GetLocale() or "unknown"
    print("ItemEra Debug: Client locale is " .. locale)

    print(addon.L["COMMON.ADDON_LOADED"])
end

-- Comando de chat para debug
SLASH_ITEMERA1 = "/itemera"
SLASH_ITEMERA2 = "/ie"
SlashCmdList["ITEMERA"] = function(msg)
    local command = string.lower(msg or "")

    if command == "debug" then
        ItemEraConfig.debug = not ItemEraConfig.debug
        local status = ItemEraConfig.debug and "enabled" or "disabled"
        print("ItemEra Debug: Debug mode " .. status)
    elseif command == "reload" or command == "refresh" then
        print("ItemEra: Reloading filters...")
        if addon.Filters then
            addon.Filters:ClearContainerFilter("bank")
            addon.Filters:ClearContainerFilter("reagentBank")
            C_Timer.After(0.5, function()
                addon.Filters:CreateContainerFilter("bank")
                addon.Filters:CreateContainerFilter("reagentBank")
            end)
        end
    elseif command == "test" then
        print("ItemEra Test:")
        print("  Filters module loaded: " .. (addon.Filters and "Yes" or "No"))
        print("  Expansion names: " .. (addon.expansionNames and "Yes" or "No"))
        print("  Bank frame visible: " .. (BankFrame and BankFrame:IsShown() and "Yes" or "No"))
        if addon.Filters then
            print("  Available filter functions: CreateContainerFilter, ClearContainerFilter")
        end
    elseif command == "debugbank" then
        if addon.Filters and addon.Filters.DebugContainerFilter then
            addon.Filters:DebugContainerFilter("bank")
        else
            print("ItemEra: Debug function not available")
        end
    elseif command == "debugreagent" then
        if addon.Filters and addon.Filters.DebugContainerFilter then
            addon.Filters:DebugContainerFilter("reagentBank")
        else
            print("ItemEra: Debug function not available")
        end
    else
        print("ItemEra Commands:")
        print("  /itemera debug - Toggle debug mode")
        print("  /itemera reload - Refresh bag filter")
        print("  /itemera test - Test module loading")
        print("  /itemera debugbank - Debug bank filter")
        print("  /itemera debugreagent - Debug reagent bank filter")
    end
end

addon:Init()
