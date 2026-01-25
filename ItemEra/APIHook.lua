local _, ItemEra = ...
ItemEra.APIHook = {}

-- Store the original function BEFORE hooking
local Original_GetItemInfo = C_Item.GetItemInfo

-- Expose the original function for internal use (avoids infinite loops)
ItemEra.APIHook.Original_GetItemInfo = Original_GetItemInfo

-- Internal function to get the corrected expansionID without calling the hooked API
local function GetCorrectedExpansionID(itemID)
    if not itemID or ItemEra.CONFIG.DISABLED_DB then
        return nil
    end

    -- Priority 1: Check ITEM_EXCLUDED database
    local expansionExcludedID = ItemEra.DB.ITEM_EXCLUDED[itemID]
    if expansionExcludedID then
        return expansionExcludedID
    end

    -- Priority 2: Check ITEM database
    local patch = ItemEra.DB.ITEM[itemID]
    if patch and type(patch) == "string" then
        local major = patch:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
        if major then
            return tonumber(major) - 1
        end
    end

    -- No override found, return nil to use original value
    return nil
end

-- Hooked version of C_Item.GetItemInfo
local function Hooked_GetItemInfo(itemID)
    -- Call the original function
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel,
    itemType, itemSubType, itemStackCount, itemEquipLoc,
    itemTexture, sellPrice, classID, subclassID, bindType,
    expacID, setID, isCraftingReagent = Original_GetItemInfo(itemID)

    -- If the original returned nil (item not cached), return as-is
    if not itemName then
        return itemName, itemLink, itemQuality, itemLevel, itemMinLevel,
            itemType, itemSubType, itemStackCount, itemEquipLoc,
            itemTexture, sellPrice, classID, subclassID, bindType,
            expacID, setID, isCraftingReagent
    end

    -- Check if we should override the expansionID
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

-- Function to enable/disable the hook at runtime (requires reload for full effect)
function ItemEra.APIHook:SetEnabled(enabled)
    if enabled then
        C_Item.GetItemInfo = Hooked_GetItemInfo
    else
        C_Item.GetItemInfo = Original_GetItemInfo
    end
end

-- Utility function to check if the hook is currently active
function ItemEra.APIHook:IsHooked()
    return C_Item.GetItemInfo == Hooked_GetItemInfo
end
