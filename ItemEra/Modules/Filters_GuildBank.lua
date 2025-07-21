local Utils = ItemEra.Filters_Utils
local _, ItemEra = ...

local Filters_GuildBank = {}

local MAX_GUILDBANK_SLOTS_PER_TAB = 98
local NUM_SLOTS_PER_GUILDBANK_GROUP = 14

function Filters_GuildBank.HighlightGuildBankByExpansion(expansionID)
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
        Utils.SetButtonHighlight(button, itemExpansionID, expansionID)
    end
end

function Filters_GuildBank.ClearGuildBankHighlight()
    if not GuildBankFrame then return end
    for slot = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
        local index = (slot - 1) % NUM_SLOTS_PER_GUILDBANK_GROUP + 1
        local column = math.ceil(slot / NUM_SLOTS_PER_GUILDBANK_GROUP)
        local button = GuildBankFrame.Columns and GuildBankFrame.Columns[column] and
            GuildBankFrame.Columns[column].Buttons and GuildBankFrame.Columns[column].Buttons[index]
        Utils.ClearButtonHighlight(button)
    end
end

ItemEra.Filters_GuildBank = Filters_GuildBank
