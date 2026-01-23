local addonName, ItemEra = ...

ItemEra.Filters_Bagnon = {}

local currentFilter = nil
local dropdownFrame = nil
local containerFrame = nil

-- Function to apply the expansion filter in Bagnon
local function ApplyExpansionFilter(expansionID)
    if not Bagnon then
        return
    end

    currentFilter = expansionID

    if expansionID == nil then
        -- Clear the search filter
        Bagnon.canSearch = nil
        Bagnon.search = nil
        Bagnon:SendSignal('SEARCH_TOGGLED', nil)
        Bagnon:SendSignal('SEARCH_CHANGED', nil)
    else
        local searchTerm = ItemEra.Utils.ExpansionSearchTermsBagnon[expansionID]
        if searchTerm then
            -- Enable search mode first
            Bagnon.canSearch = true
            Bagnon:SendSignal('SEARCH_TOGGLED', 'inventory')
            -- Then apply the search term
            Bagnon.search = searchTerm
            Bagnon:SendSignal('SEARCH_CHANGED', searchTerm)
        end
    end
end

-- Create and attach the dropdown to Bagnon's inventory frame
local function CreateExpansionDropdown()
    if not Bagnon or not Bagnon.Frames then
        return nil
    end

    -- Create a container frame
    containerFrame = CreateFrame("Frame", "ItemEraBagnonFilterContainer", UIParent)
    containerFrame:SetSize(150, 26)
    containerFrame:Hide()

    -- Create the dropdown using ItemEra's utility
    dropdownFrame = ItemEra.Filters_Utils.CreateDropdown(
        containerFrame,
        "ItemEraBagnonDropdown",
        {
            position = "LEFT",
            x = 0,
            y = 0,
            width = 140,
            height = 22
        },
        nil,
        function(expansionID)
            ApplyExpansionFilter(expansionID)
        end
    )

    return containerFrame
end

-- Position the dropdown relative to the Bagnon frame
local function PositionDropdown(bagnonFrame)
    if not containerFrame or not bagnonFrame then
        return
    end

    containerFrame:SetParent(bagnonFrame)
    containerFrame:ClearAllPoints()
    -- Position at the top left of the Bagnon frame
    containerFrame:SetPoint("TOPLEFT", bagnonFrame, "TOPLEFT", 2, 24)
    containerFrame:SetFrameStrata("HIGH")
    containerFrame:Show()
end

-- Hook into Bagnon's frame show/hide events
local function HookBagnonFrames()
    if not Bagnon or not Bagnon.Frames then
        return false
    end

    -- Hook the inventory frame
    local inventoryFrame = Bagnon.Frames:Get('inventory')
    if inventoryFrame then
        -- Position the dropdown when the frame is shown
        inventoryFrame:HookScript("OnShow", function(self)
            if containerFrame then
                PositionDropdown(self)
            end
        end)

        -- Hide and reset the dropdown when the frame is hidden
        inventoryFrame:HookScript("OnHide", function()
            if containerFrame then
                containerFrame:Hide()
            end
            -- Clear the filter when the bag is closed
            currentFilter = nil
            if dropdownFrame and dropdownFrame.Reset then
                dropdownFrame:Reset()
            end
            -- Clear the search
            if Bagnon then
                Bagnon.canSearch = nil
                Bagnon.search = nil
                Bagnon:SendSignal('SEARCH_TOGGLED', nil)
                Bagnon:SendSignal('SEARCH_CHANGED', nil)
            end
        end)

        -- If the frame is already shown, position the dropdown
        if inventoryFrame:IsShown() then
            PositionDropdown(inventoryFrame)
        end

        return true
    end

    return false
end

local function SetupBagnonIntegration()
    if not Bagnon then
        return
    end

    -- Create the dropdown
    CreateExpansionDropdown()

    -- Try to hook the frames immediately
    if not HookBagnonFrames() then
        -- If frames aren't ready yet, wait and try again
        C_Timer.After(0.5, function()
            HookBagnonFrames()
        end)
    end
end

function ItemEra.Filters_Bagnon:Initialize()
    if not ItemEra.Utils:IsBagnonLoaded() then
        return
    end

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function(self)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        -- Delay initialization to ensure Bagnon is fully loaded
        C_Timer.After(1, function()
            SetupBagnonIntegration()
        end)
    end)
end

function ItemEra.Filters_Bagnon:GetCurrentFilter()
    return currentFilter
end

function ItemEra.Filters_Bagnon:ClearFilter()
    ApplyExpansionFilter(nil)
    if dropdownFrame and dropdownFrame.Reset then
        dropdownFrame:Reset()
    end
end
