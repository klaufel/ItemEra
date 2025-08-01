local _, ItemEra = ...
ItemEra.ItemData = {}

local ItemExpansionOrigin = {
    DB = 'DB',
    DB_EXCLUDED = 'DB_EXCLUDED',
    GAME = 'GAME'
}

function ItemEra.ItemData:GetItemDBVersion(itemID)
    local patch = ItemEra.DB.ITEM[itemID]
    if patch and type(patch) == "string" then
        local major = patch:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
        if major then
            local shortPatch = patch and patch:match("^(%d+%.%d+)") or nil
            local patchName = ItemEra.DB.PATCH[shortPatch]

            return {
                expansionID = tonumber(major) - 1,
                expansionPatch = patch,
                expansionPatchShort = shortPatch,
                expansionPatchName = patchName
            }
        end
    else
        return nil
    end
end

function ItemEra.ItemData:GetMountDBVersion(itemID)
    local patch = ItemEra.DB.MOUNT[itemID]



    if patch and type(patch) == "string" then
        local major = patch:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
        if major then
            local shortPatch = patch and patch:match("^(%d+%.%d+)") or nil
            local patchName = ItemEra.DB.PATCH[shortPatch]

            return {
                itemID = itemID,
                origin = ItemExpansionOrigin.DB,
                expansionID = tonumber(major) - 1,
                expansionPatch = patch,
                expansionPatchShort = shortPatch,
                expansionPatchName = patchName
            }
        end
    else
        return nil
    end
end

function ItemEra.ItemData:GetItemDBVersionExcluded(itemID)
    local expansionExcludedId = ItemEra.DB.ITEM_EXCLUDED[itemID]
    return expansionExcludedId or nil
end

function ItemEra.ItemData:GetItemExpansionID(itemID)
    if not itemID then return nil end
    local expansionID = select(15, C_Item.GetItemInfo(itemID))
    local origin = ItemExpansionOrigin.GAME
    local expansionPatch = nil
    local expansionPatchName = nil

    if not ItemEra.CONFIG.DISABLED_DB then
        local expansionExcludedID = ItemEra.ItemData:GetItemDBVersionExcluded(itemID)
        if (expansionExcludedID) then
            expansionID = expansionExcludedID
            origin = ItemExpansionOrigin.DB_EXCLUDED
        end

        local itemDBVersion = ItemEra.ItemData:GetItemDBVersion(itemID)
        if (itemDBVersion) then
            expansionID = itemDBVersion.expansionID
            expansionPatch = itemDBVersion.expansionPatch
            expansionPatchName = itemDBVersion.expansionPatchName
            origin = ItemExpansionOrigin.DB
        end
    end


    return {
        itemID = itemID,
        expansionID = expansionID,
        origin = origin,
        expansionPatch = expansionPatch,
        expansionPatchName = expansionPatchName
    }
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
