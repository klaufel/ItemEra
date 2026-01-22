local _, ItemEra = ...
ItemEra.Filters = {}

function ItemEra.Filters:Initialize()
    local isBaganatorLoaded = ItemEra.Utils:IsBaganatorLoaded()

    -- Si Baganator está cargado, usamos la integración con Baganator
    -- en lugar de los filtros nativos de ItemEra
    if isBaganatorLoaded then
        if ItemEra.DB_SETTINGS.global.settings.enabledBaganatorIntegration then
            ItemEra.Filters_Baganator:Initialize()
        end
        -- No inicializar los filtros nativos cuando Baganator está activo
        -- ya que Baganator reemplaza las interfaces de inventario/banco
        return
    end

    -- Filtros nativos de ItemEra (solo cuando Baganator NO está cargado)
    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersInventory then
        ItemEra.Filters_Inventory:Initialize()
    end

    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersBank then
        ItemEra.Filters_Bank:Initialize()
    end

    if ItemEra.DB_SETTINGS.global.settings.enabledFiltersGuildBank then
        ItemEra.Filters_GuildBank:Initialize()
    end
end
