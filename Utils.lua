local _, ItemEra = ...
ItemEra.Utils = {}

-- Mix key-value pairs from other tables (...) into object. This is commonly used to create
-- class "instances" with a particular interface.
function ItemEra.Utils.Mixin(object, ...)
    for i = 1, select("#", ...) do
        local mixin = select(i, ...)
        for k, v in pairs(mixin) do
            object[k] = v
        end
    end

    return object
end

function ItemEra.Utils:toRGB(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
        tonumber("0x" .. hex:sub(3, 4)) / 255,
        tonumber("0x" .. hex:sub(5, 6)) / 255
end

ItemEra.Utils.ExpansionColorsHex = {
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

ItemEra.Utils.ExpansionColors = {}
for k, hex in pairs(ItemEra.Utils.ExpansionColorsHex) do
    ItemEra.Utils.ExpansionColors[k] = { ItemEra.Utils:toRGB(hex) }
end

ItemEra.Utils.ExpansionNames = {
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
    [10] = "The War Within"
}


function ItemEra.Utils:GetExpansionsInOrder()
    local ordered = {}
    for id = 0, 10 do
        if ItemEra.Utils.ExpansionNames[id] then
            table.insert(ordered, { id = id, name = ItemEra.Utils.ExpansionNames[id] })
        end
    end
    return ordered
end

function ItemEra.Utils:Dump(t, indent)
    assert(type(t) == "table", "PrintTable() called for non-table!")

    local indentString = ""
    for i = 1, indent do
        indentString = indentString .. "  "
    end

    for k, v in pairs(t) do
        if type(v) ~= "table" then
            if type(v) == "string" then
                print(indentString, k, "=", v)
            end
        else
            print(indentString, k, "=")
            print(indentString, "  {")
            PrintTable(v, indent + 2)
            print(indentString, "  }")
        end
    end
end
