local addonName, ItemEra = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

ItemEra.Filters_Baganator = {}

-- Mapeo de expansionID de ItemEra a términos de búsqueda de Baganator/Syndicator
local ExpansionSearchTerms = {
    [0]  = "classic",           -- Classic
    [1]  = "tbc",               -- The Burning Crusade
    [2]  = "wotlk",             -- Wrath of the Lich King
    [3]  = "cataclysm",         -- Cataclysm
    [4]  = "mop",               -- Mists of Pandaria
    [5]  = "wod",               -- Warlords of Draenor
    [6]  = "legion",            -- Legion
    [7]  = "bfa",               -- Battle for Azeroth
    [8]  = "shadowlands",       -- Shadowlands
    [9]  = "dragonflight",      -- Dragonflight
    [10] = "tww",               -- The War Within
    [11] = "midnight",          -- Midnight
}

-- Prefijo para identificar categorías creadas por ItemEra
local CATEGORY_PREFIX = "itemera_expansion_"

-- Prioridades para ordenar las categorías (más reciente = mayor prioridad)
local ExpansionPriorities = {
    [0]  = -110,  -- Classic (más antiguo)
    [1]  = -100,  -- TBC
    [2]  = -90,   -- WotLK
    [3]  = -80,   -- Cataclysm
    [4]  = -70,   -- MoP
    [5]  = -60,   -- WoD
    [6]  = -50,   -- Legion
    [7]  = -40,   -- BfA
    [8]  = -30,   -- Shadowlands
    [9]  = -20,   -- Dragonflight
    [10] = -10,   -- TWW
    [11] = 0,     -- Midnight (más reciente)
}

local function GetBaganatorAddonTable()
    -- Intentar obtener la tabla interna de Baganator
    -- Baganator expone algunas funciones a través del global Baganator
    return Baganator
end

local function IsBaganatorCategoryViewEnabled()
    -- Verificar si Baganator está en modo de vista de categorías
    local baganator = GetBaganatorAddonTable()
    if baganator and baganator.Config and baganator.Config.Get then
        -- La opción "view_type" determina si está en vista de categorías
        local viewType = baganator.Config.Get("view_type")
        return viewType == "category"
    end
    return false
end

local function CreateExpansionCategories()
    local baganator = GetBaganatorAddonTable()
    if not baganator then
        return false
    end

    -- Verificar que tenemos acceso a la API necesaria
    if not baganator.API then
        return false
    end

    -- Registrar un widget de esquina para mostrar el icono de expansión en los items
    if baganator.API.RegisterCornerWidget then
        local function OnUpdate(cornerFrame, details)
            -- Obtener la expansión del item usando ItemEra
            if details and details.itemID then
                local itemData = ItemEra.ItemData:GetItemExpansionID(details.itemID)
                if itemData and itemData.expansionID then
                    local expansionID = itemData.expansionID
                    local logoPath = ItemEra.Utils:GetExpansionLogoById(expansionID)
                    local color = ItemEra.Utils.ExpansionColors[expansionID]

                    if logoPath and color then
                        cornerFrame.Icon:SetTexture(logoPath)
                        cornerFrame.Icon:SetVertexColor(1, 1, 1, 1)
                        cornerFrame:Show()
                        return true
                    end
                end
            end
            cornerFrame:Hide()
            return false
        end

        local function OnInit(cornerFrame)
            cornerFrame.Icon = cornerFrame:CreateTexture(nil, "ARTWORK")
            cornerFrame.Icon:SetAllPoints()
            cornerFrame.Icon:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)
        end

        -- Registrar el widget con posición por defecto en la esquina inferior derecha
        baganator.API.RegisterCornerWidget(
            "ItemEra Expansion",      -- label
            "itemera_expansion",      -- id
            OnUpdate,                  -- onUpdate callback
            OnInit,                    -- onInit callback
            "bottom_right"            -- defaultPosition
        )
    end

    return true
end

local function SetupBaganatorIntegration()
    -- Esta función se ejecutará cuando Baganator esté completamente cargado
    if not Baganator then
        return
    end

    -- Crear las categorías de expansión
    CreateExpansionCategories()

    -- Registrar callbacks para cuando cambie la configuración
    if Baganator.CallbackRegistry then
        Baganator.CallbackRegistry:RegisterCallback("SettingChanged", function(_, settingName)
            if settingName == "corner_widgets" then
                -- Actualizar si cambian los widgets de esquina
            end
        end, "ItemEra")
    end
end

function ItemEra.Filters_Baganator:Initialize()
    if not ItemEra.Utils:IsBaganatorLoaded() then
        return
    end

    -- Esperar a que el jugador entre al juego para asegurar que Baganator está inicializado
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function(self, event)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")

        -- Dar tiempo a Baganator para inicializarse completamente
        C_Timer.After(1, function()
            SetupBaganatorIntegration()
        end)
    end)
end

-- Función para verificar si las categorías de ItemEra están activas en Baganator
function ItemEra.Filters_Baganator:IsExpansionWidgetActive()
    if Baganator and Baganator.API and Baganator.API.IsCornerWidgetActive then
        return Baganator.API.IsCornerWidgetActive("itemera_expansion")
    end
    return false
end