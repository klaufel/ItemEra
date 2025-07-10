local _, ItemEra = ...
ItemEra.ItemData = {}

function ItemEra.ItemData:GetItemDBInfo(itemID)
    if not itemID or not ItemEra.itemIdToVersionId then return nil end
    return ItemEra.itemIdToVersionId[itemID]
end

function ItemEra.ItemData:GetItemDBVersion(itemID)
    local itemVersionId = ItemEra.ItemData:GetItemDBInfo(itemID)

    if (not itemVersionId or not ItemEra.versionIdToVersion) then
        return nil
    end

    local version = ItemEra.versionIdToVersion[itemVersionId]
    if version and version.major then
        return version.major - 1
    end
    return nil
end

function ItemEra.ItemData:GetItemExpansionID(itemID)
    if not itemID then return nil end
    local itemInfo = ItemEra.ItemData:GetItemInfo(itemID)
    return itemInfo and itemInfo.expansionID or nil
end

function ItemEra.ItemData:GetItemInfo(itemID)
    if not itemID then return nil end

    local itemData = {}
    local
    itemName,
    itemLink,
    itemQuality,
    itemLevel,
    itemMinLevel,
    itemType,
    itemSubType,
    itemStackCount,
    itemEquipLoc,
    itemTexture,
    sellPrice,
    classID,
    subclassID,
    bindType,
    expansionID,
    setID,
    isCraftingReagent = C_Item.GetItemInfo(itemID)



    if itemName then
        itemData.itemName = itemName
        itemData.itemLink = itemLink
        itemData.itemQuality = itemQuality
        itemData.itemLevel = itemLevel
        itemData.itemMinLevel = itemMinLevel
        itemData.itemType = itemType
        itemData.itemSubType = itemSubType
        itemData.itemStackCount = itemStackCount
        itemData.itemEquipLoc = itemEquipLoc
        itemData.itemTexture = itemTexture
        itemData.sellPrice = sellPrice
        itemData.classID = classID
        itemData.subclassID = subclassID
        itemData.bindType = bindType
        itemData.expansionID = ItemEra.ItemData:GetItemDBVersion(itemID) or expansionID
        itemData.setID = setID
        itemData.isCraftingReagent = isCraftingReagent
    end

    return itemData
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
