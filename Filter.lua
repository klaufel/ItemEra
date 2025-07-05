local addonName, addon = ...
local Filter = {}
addon.Filter = Filter

-- Function to highlight items with expansionID = 3 in Account Bank
function Filter:HighlightFirstSlot()
    if not AccountBankPanel or not AccountBankPanel:IsShown() then
        print("AccountBankPanel not available")
        return
    end

    print("Trying to find items with expansionID = 3...")

    -- Use Blizzard's native method to enumerate items
    local selectedTabID = AccountBankPanel:GetSelectedTabID()
    if not selectedTabID or selectedTabID == -1 then -- PURCHASE_TAB_ID = -1
        print("No valid tab selected")
        return
    end

    print("Selected tab ID:", selectedTabID)

    -- Use the native EnumerateValidItems method from BankPanelMixin
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        local bankTabID = itemButton:GetBankTabID()
        local containerSlotID = itemButton:GetContainerSlotID()

        print("Checking item button - Tab:", bankTabID, "Slot:", containerSlotID)

        -- Get item info using the same method as Blizzard
        local itemInfo = C_Container.GetContainerItemInfo(bankTabID, containerSlotID)
        if itemInfo and itemInfo.itemID then
            local itemExpansionID = select(15, GetItemInfo(itemInfo.itemID))
            print("Item ID:", itemInfo.itemID, "expansionID:", itemExpansionID)

            if itemExpansionID and itemExpansionID == 3 then
                print("Found item with expansionID = 3 in slot:", containerSlotID)

                -- Use the native SetMatchesSearch method (same as search filtering)
                itemButton:SetMatchesSearch(false)
                print("Applied filter to item with expansionID = 3")
            end
        end
    end
end

-- Function to clear highlighting
function Filter:ClearHighlight()
    print("Clearing highlights using native search API...")

    if not AccountBankPanel then
        return
    end

    -- Use native method to clear all filters
    for itemButton in AccountBankPanel:EnumerateValidItems() do
        itemButton:SetMatchesSearch(true)
    end
end

-- Initialize the filter functionality
function Filter:Init()
    print("Filter:Init() called")

    -- Use modern event registration
    local frame = CreateFrame("Frame")
    EventRegistry:RegisterCallback("BankFrame.OnShow", function()
        print("BankFrame shown via EventRegistry")
        if AccountBankPanel and AccountBankPanel:IsShown() then
            print("Account bank is shown, highlighting first slot")
            Filter:HighlightFirstSlot()
        end
    end, frame)

    EventRegistry:RegisterCallback("BankFrame.OnHide", function()
        print("BankFrame hidden via EventRegistry")
        Filter:ClearHighlight()
    end, frame)

    -- Fallback to traditional events if modern callbacks don't work
    frame:RegisterEvent("ADDON_LOADED")
    frame:RegisterEvent("BANKFRAME_OPENED")
    frame:RegisterEvent("BANKFRAME_CLOSED")

    frame:SetScript("OnEvent", function(self, event, ...)
        print("Event received:", event)

        if event == "ADDON_LOADED" and ... == addonName then
            print("ItemEra addon loaded")
        elseif event == "BANKFRAME_OPENED" then
            print("Bank frame opened")

            if AccountBankPanel and AccountBankPanel:IsShown() then
                print("Account bank is shown, highlighting first slot")
                Filter:HighlightFirstSlot()
            end
        elseif event == "BANKFRAME_CLOSED" then
            print("Bank frame closed")
            Filter:ClearHighlight()
        end
    end)

    -- Use modern secure hook for AccountBankPanel if available
    if AccountBankPanel then
        print("AccountBankPanel exists, setting up modern hooks")

        -- Use EventRegistry for AccountBankPanel if available
        if EventRegistry then
            EventRegistry:RegisterCallback("AccountBankPanel.OnShow", function()
                print("AccountBankPanel shown via EventRegistry")
                Filter:HighlightFirstSlot()
            end, frame)
        end

        -- Fallback to traditional hook
        if AccountBankPanel.Show then
            hooksecurefunc(AccountBankPanel, "Show", function()
                print("AccountBankPanel:Show() called")
                Filter:HighlightFirstSlot()
            end)
        end
    end
end

local frame = CreateFrame("Frame")
EventRegistry:RegisterCallback("BankFrame.OnShow", function()
    print("BankFrame shown via EventRegistry")

    if AccountBankPanel and AccountBankPanel:IsShown() then
        print("Account bank is shown, highlighting first slot")
        Filter:HighlightFirstSlot()
    end
end, frame)

EventRegistry:RegisterCallback("BankFrame.OnHide", function()
    print("BankFrame hidden via EventRegistry")
    Filter:ClearHighlight()
end, frame)

-- Fallback to traditional events if modern callbacks don't work
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("BANKFRAME_OPENED")
frame:RegisterEvent("BANKFRAME_CLOSED")

frame:SetScript("OnEvent", function(self, event, ...)
    print("Event received:", event)

    if event == "ADDON_LOADED" and ... == addonName then
        print("ItemEra addon loaded")
    elseif event == "BANKFRAME_OPENED" then
        print("Bank frame opened")

        if AccountBankPanel and AccountBankPanel:IsShown() then
            print("Account bank is shown, highlighting first slot")
            Filter:HighlightFirstSlot()
        end
    elseif event == "BANKFRAME_CLOSED" then
        print("Bank frame closed")
        Filter:ClearHighlight()
    end
end)

-- Use modern secure hook for AccountBankPanel if available
if AccountBankPanel then
    print("AccountBankPanel exists, setting up modern hooks")

    -- Use EventRegistry for AccountBankPanel if available
    if EventRegistry then
        EventRegistry:RegisterCallback("AccountBankPanel.OnShow", function()
            print("AccountBankPanel shown via EventRegistry")
            Filter:HighlightFirstSlot()
        end, frame)
    end

    -- Fallback to traditional hook
    if AccountBankPanel.Show then
        hooksecurefunc(AccountBankPanel, "Show", function()
            print("AccountBankPanel:Show() called")
            Filter:HighlightFirstSlot()
        end)
    end
end
