local _, ItemEra = ...
ItemEra.ItemData = {}

function ItemEra.ItemData:GetItemDBInfo(itemID)
    if not itemID or not ItemEra.itemIdToVersionId then return nil end
    return ItemEra.itemIdToVersionId[itemID]
end

function ItemEra.ItemData:GetExpansionIdFromItemDB(itemID)
    local version = ItemEra.versionIdToVersion[itemID]
    if version and type(version) == "string" then
        local major = version:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
        if major then
            return tonumber(major) - 1
        end
    end
end

function ItemEra.ItemData:GetItemDBVersionExcluded(itemID)
    local expansionExcludedId = ItemEra.Utils.ExpansionItemsExcluded[itemID]
    return expansionExcludedId or nil
end

function ItemEra.ItemData:GetItemDBVersion(itemID)
    local itemDBID = ItemEra.ItemData:GetItemDBInfo(itemID)

    if (not itemDBID or not ItemEra.versionIdToVersion) then
        return nil
    end

    local version = ItemEra.ItemData:GetExpansionIdFromItemDB(itemDBID)
    if version then return version end
    return nil
end

function ItemEra.ItemData:GetItemExpansionID(itemID)
    if not itemID then return nil end

    local expansionExcludedID = ItemEra.ItemData:GetItemDBVersionExcluded(itemID)
    if (expansionExcludedID) then return expansionExcludedID end

    local expansionDBID = ItemEra.ItemData:GetItemDBVersion(itemID)
    if (expansionDBID) then return expansionDBID end

    local expansionID = select(15, C_Item.GetItemInfo(itemID))
    return expansionID
end

function ItemEra.ItemData:GetExpansionColor(expansionID)
    if not expansionID then return nil end

    local colorHex = ItemEra.Utils.ExpansionColorsHex[expansionID]
    if colorHex then
        return ItemEra.Utils:toRGB(colorHex)
    end

    return nil
end

function ItemEra.ItemData:GetExpansionName(expansionID)
    if not expansionID then return nil end
    return ItemEra.Utils.ExpansionNames[expansionID]
end
