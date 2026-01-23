local addonName, ItemEra = ...

ItemEra.Filters_Baganator = {}

local currentFilter = nil
local dropdownFrame = nil
local isApplyingFilter = false
local currentSearchTerm = nil

-- Clear focus from search box
local function ClearSearchFocus()
    -- Try to clear focus from any active edit box
    local searchBox = BaganatorSearchBox or _G["BaganatorSearchBox"]
    if searchBox and searchBox.ClearFocus then
        searchBox:ClearFocus()
    end
    -- Also try the global focus clear
    if GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus() then
        GetCurrentKeyBoardFocus():ClearFocus()
    end
end

-- Function to apply the search filter in Baganator
local function ApplyExpansionFilter(expansionID)
    if not Baganator or not Baganator.CallbackRegistry then
        return
    end

    currentFilter = expansionID
    isApplyingFilter = true

    if expansionID == nil then
        currentSearchTerm = nil
        Baganator.CallbackRegistry:TriggerEvent("SearchTextChanged", "")
    else
        local searchTerm = ItemEra.Utils.ExpansionSearchTermsBaganator[expansionID]
        if searchTerm then
            currentSearchTerm = searchTerm
            Baganator.CallbackRegistry:TriggerEvent("SearchTextChanged", searchTerm)
        end
    end

    isApplyingFilter = false

    -- Clear focus from search box after a short delay
    C_Timer.After(0.01, ClearSearchFocus)
end

-- Reset the dropdown when user types manually
local function ResetDropdownIfNeeded()
    currentFilter = nil
    currentSearchTerm = nil
    if dropdownFrame and dropdownFrame.Reset then
        dropdownFrame:Reset()
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
            ResetDropdownIfNeeded()
        end, "ItemEraFilter")

        -- Listen for manual search text changes to reset the dropdown
        Baganator.CallbackRegistry:RegisterCallback("SearchTextChanged", function(_, searchText)
            -- If we're not the ones applying the filter, reset the dropdown
            if not isApplyingFilter then
                -- Check if the search text is different from what we set
                if currentSearchTerm == nil or searchText ~= currentSearchTerm then
                    ResetDropdownIfNeeded()
                end
            end
        end, "ItemEraSearchListener")
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
