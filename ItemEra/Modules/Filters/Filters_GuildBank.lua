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
                itemExpansionID = ItemEra.ItemData:GetItemExpansionID(itemID)
            end
        end
        FiltersUtils.ToggleButtonMatch(button, itemExpansionID, expansionID)
    end
end

function FiltersGuildBank.Update()
    FiltersGuildBank.HighlightGuildBankByExpansion(guildBankExpansionFilter)
end

function FiltersGuildBank.Reset()
    FiltersGuildBank.HighlightGuildBankByExpansion(nil)
    guildBankExpansionFilter = nil
    if GuildBankFilterDropdown then GuildBankFilterDropdown:Reset() end
end

function FiltersGuildBank.Initialize()
    ItemEra:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.GuildBanker then return end
        if not GuildBankFilterDropdown then
            local dropdownParams = { x = 18, y = -28, width = 200 }

            GuildBankFilterDropdown = FiltersUtils.CreateDropdown(GuildBankFrame, "GuildBankFilterDropdown",
                dropdownParams, guildBankExpansionFilter,
                function(expansionID)
                    guildBankExpansionFilter = expansionID
                    FiltersGuildBank.Update()
                end)
        else
            GuildBankFilterDropdown:Show()
        end
    end)

    ItemEra:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED", FiltersGuildBank.Update)

    ItemEra:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE', function(_, _, arg)
        if arg ~= Enum.PlayerInteractionType.GuildBanker then return end
        FiltersGuildBank.Reset()
    end)
end

ItemEra.FiltersGuildBank = FiltersGuildBank
