local addonName, ItemEra = ...

ItemEra.Filters_Baganator = {}

local currentFilter = nil
local dropdownFrame = nil

-- Function to apply the search filter in Baganator
local function ApplyExpansionFilter(expansionID)
    if not Baganator or not Baganator.CallbackRegistry then
        return
    end

    currentFilter = expansionID

    if expansionID == nil then
        Baganator.CallbackRegistry:TriggerEvent("SearchTextChanged", "")
    else
        local searchTerm = ItemEra.Utils.ExpansionSearchTermsBaganator[expansionID]
        if searchTerm then
            Baganator.CallbackRegistry:TriggerEvent("SearchTextChanged", searchTerm)
        end
    end
end

-- Register the custom region in Baganator
local function RegisterExpansionFilterRegion()
    if not Baganator or not Baganator.API or not Baganator.API.RegisterRegion then
        return false
    end

    -- Create a container frame for the dropdown
    local container = CreateFrame("Frame", "ItemEraExpansionFilterContainer", UIParent)
    container:SetSize(150, 26)

    -- Use ItemEra's dropdown
    dropdownFrame = ItemEra.Filters_Utils.CreateDropdown(
        container,
        "ItemEraExpansionDropdown",
        {
            position = "LEFT",
            x = -130,
            y = 24,
            width = 140,
            height = 22
        },
        nil,
        function(expansionID)
            ApplyExpansionFilter(expansionID)
        end
    )

    -- Register the region in Baganator (position: top_left of backpack)
    Baganator.API.RegisterRegion(
        "ItemEra",
        "itemera_expansion",
        "backpack",
        "top_left",
        container
    )

    -- Listen for bag close to clear the filter
    if Baganator.CallbackRegistry then
        Baganator.CallbackRegistry:RegisterCallback("BagHide", function()
            currentFilter = nil
            if dropdownFrame and dropdownFrame.Reset then
                dropdownFrame:Reset()
            end
        end, "ItemEraFilter")
    end

    return true
end

local function SetupBaganatorIntegration()
    if not Baganator then
        return
    end

    RegisterExpansionFilterRegion()
end

function ItemEra.Filters_Baganator:Initialize()
    if not ItemEra.Utils:IsBaganatorLoaded() then
        return
    end

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function(self)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        C_Timer.After(1, function()
            SetupBaganatorIntegration()
        end)
    end)
end

function ItemEra.Filters_Baganator:GetCurrentFilter()
    return currentFilter
end

function ItemEra.Filters_Baganator:ClearFilter()
    ApplyExpansionFilter(nil)
    if dropdownFrame and dropdownFrame.Reset then
        dropdownFrame:Reset()
    end
end
