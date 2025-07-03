-- WoW API Type Definitions for IDE Support
-- Based on Ketho/BlizzardInterfaceResources
-- Only include this file for development - not needed for runtime

---@meta

---@class GameTooltip : Frame
---@field SetBagItem function
---@field SetInventoryItem function
---@field SetHyperlink function
---@field SetMerchantItem function
---@field SetBankItem function
---@field SetGuildBankItem function
---@field SetReagentBankItem function
---@field GetItem function
---@field AddLine function
---@field Show function

---@class ItemRefTooltip : GameTooltip

---@class C_Container
---@field GetContainerItemLink function
---@field GetContainerNumSlots function

-- Global functions
---@param bagID number
---@param slot number
---@return string|nil
function GetContainerItemLink(bagID, slot) end

---@param bagID number
---@return number
function GetContainerNumSlots(bagID) end

---@param itemID number
---@return string, string, number, number, number, string, string, string, string, string, number, string, number, string, number
function GetItemInfo(itemID) end

---@param tab number
---@param slot number
---@return string|nil
function GetGuildBankItemLink(tab, slot) end

---@return number
function GetCurrentGuildBankTab() end

-- Global constants
NUM_BAG_SLOTS = 4
NUM_BANKGENERIC_SLOTS = 28
REAGENTBANK_CONTAINER = -3

-- Global frames
---@type GameTooltip
GameTooltip = nil

---@type ItemRefTooltip
ItemRefTooltip = nil

---@type Frame|nil
BankFrame = nil

---@type Frame|nil
ReagentBankFrame = nil

---@type Frame|nil
GuildBankFrame = nil

---@type Frame|nil
ContainerFrame1 = nil
