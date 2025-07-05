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
    [0] = _G.EXPANSION_NAME0,
    [1] = _G.EXPANSION_NAME1,
    [2] = _G.EXPANSION_NAME2,
    [3] = _G.EXPANSION_NAME3,
    [4] = _G.EXPANSION_NAME4,
    [5] = _G.EXPANSION_NAME5,
    [6] = _G.EXPANSION_NAME6,
    [7] = _G.EXPANSION_NAME7,
    [8] = _G.EXPANSION_NAME8,
    [9] = _G.EXPANSION_NAME9,
    [10] = _G.EXPANSION_NAME10,
}


function GetExpansionsInOrder()
    local ordered = {}
    for id = 0, 10 do
        if addon.expansionNames[id] then
            table.insert(ordered, { id = id, name = addon.expansionNames[id] })
        end
    end
    return ordered
end

addon.GetExpansionsInOrder = GetExpansionsInOrder

function Dump(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

addon.Dump = Dump
