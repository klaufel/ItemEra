local _, ItemEra = ...

local FiltersUtils = ItemEra.Filters_Utils

local FiltersGuildBank = {}

local GuildBankFilterDropdown = nil
local guildBankExpansionFilter = nil

local MAX_GUILDBANK_SLOTS_PER_TAB = 98
local NUM_SLOTS_PER_GUILDBANK_GROUP = 14

function FiltersGuildBank.HighlightGuildBankByExpansion(expansionID)
    if not GuildBankFrame or not GuildBankFrame:IsShown() then return end
    local currentTab = GetCurrentGuildBankTab()
    if not currentTab then return end
    for slot = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local itemLink = GetGuildBankItemLink(currentTab, slot)
        local index = (slot - 1) % NUM_SLOTS_PER_GUILDBANK_GROUP + 1
        local column = math.ceil(slot / NUM_SLOTS_PER_GUILDBANK_GROUP)
        local button = GuildBankFrame.Columns and GuildBankFrame.Columns[column] and
            GuildBankFrame.Columns[column].Buttons and GuildBankFrame.Columns[column].Buttons[index]
        local itemExpansionID = nil
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                local item = ItemEra.ItemData:GetItemExpansionID(itemID)
                itemExpansionID = item and item.expansionID or nil
            end
        end
        FiltersUtils.ToggleButtonMatch(button, itemExpansionID, expansionID)
    end
end

function FiltersGuildBank.Update(expansionID)
    FiltersGuildBank.HighlightGuildBankByExpansion(expansionID or nil)
end

function FiltersGuildBank.Reset()
    FiltersGuildBank.HighlightGuildBankByExpansion(nil)
    guildBankExpansionFilter = nil
    if GuildBankFilterDropdown then 
        GuildBankFilterDropdown:Hide()
        GuildBankFilterDropdown:Reset()
    end
end

function FiltersGuildBank.Initialize()
    ItemEra:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED", function()
        if not GuildBankFrame then return end -- Validate parent frame exists
        if not GuildBankFilterDropdown then
            local dropdownParams = { x = 18, y = -28, width = 200 }
            GuildBankFilterDropdown = FiltersUtils.CreateDropdown(GuildBankFrame, "GuildBankFilterDropdown",
                dropdownParams, guildBankExpansionFilter,
                function(expansionID)
                    guildBankExpansionFilter = expansionID
                    FiltersGuildBank.Update(expansionID)
                end)
        else
            -- Validate dropdown still exists and has a valid parent before showing
            if GuildBankFilterDropdown and GuildBankFilterDropdown:GetParent() then
                GuildBankFilterDropdown:Show()
            end
        end

        FiltersGuildBank.Update(guildBankExpansionFilter)
    end)

    ItemEra:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE', function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.GuildBanker then return end
        FiltersGuildBank.Reset()
    end)
end

ItemEra.Filters_GuildBank = FiltersGuildBank
