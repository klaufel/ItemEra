ItemEra = ItemEra or {}
ItemEra.Settings = {}

---@class ItemEraSettings
---@field showExpansionInTooltip boolean
---@field showRarityFilter boolean
---@field bankFilterEnabled boolean
---@field tooltipColor '"class"'|'"rarity"'|'"expansion"'

-- 🎯 Valores por defecto
local defaults = {
    showExpansionInTooltip = true,
    showRarityFilter = true,
    bankFilterEnabled = true,
    tooltipColor = "class", -- puede ser: "class", "rarity", "expansion"
}

-- 🧩 Tipos esperados
local schema = {
    showExpansionInTooltip = "boolean",
    showRarityFilter = "boolean",
    bankFilterEnabled = "boolean",
    tooltipColor = "string",
}

-- ✅ Valores válidos para claves específicas
local allowedValues = {
    tooltipColor = {
        class = true,
        rarity = true,
        expansion = true,
    }
}

-- 🔄 Inicializar configuración
function ItemEra.Settings:Initialize()
    if not ItemEraDB then
        ItemEraDB = {}
    end

    for key, defaultValue in pairs(defaults) do
        if ItemEraDB[key] == nil then
            ItemEraDB[key] = defaultValue
        end
    end

    self.db = ItemEraDB
end

-- 📥 Obtener valor
---@param key string
function ItemEra.Settings:Get(key)
    return self.db and self.db[key]
end

-- 📤 Establecer valor con validación
---@param key string
---@param value any
function ItemEra.Settings:Set(key, value)
    local expectedType = schema[key]
    if not expectedType then
        print("|cffff0000[ItemEra]|r Unknown setting:", key)
        return
    end

    -- Validación por tipo
    if type(value) ~= expectedType then
        print("|cffff0000[ItemEra]|r Invalid type for", key, "- expected", expectedType)
        return
    end

    -- Validación por valores permitidos
    if allowedValues[key] and not allowedValues[key][value] then
        print("|cffff0000[ItemEra]|r Invalid value for", key, "- value:", value)
        return
    end

    self.db[key] = value
end

-- 🔁 Alternar booleanos
---@param key string
function ItemEra.Settings:Toggle(key)
    if self.db and type(self.db[key]) == "boolean" then
        self.db[key] = not self.db[key]
        return self.db[key]
    end
end
