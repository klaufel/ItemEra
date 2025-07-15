local _, ItemEra = ...

local frame = CreateFrame("Frame")

local handlers = ItemEra.Events or {}

frame:SetScript("OnEvent", function(self, event, ...)
    if handlers[event] then
        handlers[event](self, event, ...)
    end
end)

---[Documentation](https://warcraft.wiki.gg/wiki/API_Frame_RegisterEvent)
---@param eventName FrameEvent
---@param callback function|nil
function ItemEra:RegisterEvent(eventName, callback)
    handlers[eventName] = callback
    frame:RegisterEvent(eventName)
end
