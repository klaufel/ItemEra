local addonName, addon = ...
local Utils = {}
addon.Utils = Utils

function Utils.toRGB(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
        tonumber("0x" .. hex:sub(3, 4)) / 255,
        tonumber("0x" .. hex:sub(5, 6)) / 255
end

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
