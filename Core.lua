local addonName, addon = ...
_G[addonName] = addon

local L = L or {} -- La tabla L global ya está definida por los archivos de idioma
addon.L = L

print(L)

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

    print("ItemEra addon loaded successfully!")
end

addon:Init()
