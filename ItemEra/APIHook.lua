local _, ItemEra = ...
ItemEra.APIHook = {}

local Original_GetItemInfo = C_Item.GetItemInfo

ItemEra.APIHook.Original_GetItemInfo = Original_GetItemInfo

local function GetCorrectedExpansionID(itemID)
    if not itemID or ItemEra.CONFIG.DISABLED_DB then
        return nil
    end

    local expansionExcludedID = ItemEra.DB.ITEM_EXCLUDED[itemID]
    if expansionExcludedID then
        return expansionExcludedID
    end

    local patch = ItemEra.DB.ITEM[itemID]
    if patch and type(patch) == "string" then
        local major = patch:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
        if major then
            return tonumber(major) - 1
        end
    end

    return nil
end

local function Hooked_GetItemInfo(itemID)
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel,
    itemType, itemSubType, itemStackCount, itemEquipLoc,
    itemTexture, sellPrice, classID, subclassID, bindType,
    expacID, setID, isCraftingReagent = Original_GetItemInfo(itemID)

    if not itemName then
        return itemName, itemLink, itemQuality, itemLevel, itemMinLevel,
            itemType, itemSubType, itemStackCount, itemEquipLoc,
            itemTexture, sellPrice, classID, subclassID, bindType,
            expacID, setID, isCraftingReagent
    end

    if ItemEra.DB_SETTINGS and ItemEra.DB_SETTINGS.global.settings.enabledAPIHook then
        local correctedExpansionID = GetCorrectedExpansionID(itemID)
        if correctedExpansionID then
            expacID = correctedExpansionID
        end
    end

    return itemName, itemLink, itemQuality, itemLevel, itemMinLevel,
        itemType, itemSubType, itemStackCount, itemEquipLoc,
        itemTexture, sellPrice, classID, subclassID, bindType,
        expacID, setID, isCraftingReagent
end

function ItemEra.APIHook:Initialize()
    -- Only hook if the setting is enabled
    if ItemEra.DB_SETTINGS and ItemEra.DB_SETTINGS.global.settings.enabledAPIHook then
        C_Item.GetItemInfo = Hooked_GetItemInfo
    end
end

function ItemEra.APIHook:SetEnabled(enabled)
    if enabled then
        C_Item.GetItemInfo = Hooked_GetItemInfo
    else
        C_Item.GetItemInfo = Original_GetItemInfo
    end
end

function ItemEra.APIHook:IsHooked()
    return C_Item.GetItemInfo == Hooked_GetItemInfo
end
