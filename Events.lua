local frame = CreateFrame("Frame")

local handlers = ItemEra.Events or {}

frame:SetScript("OnEvent", function(self, event, ...)
    if handlers[event] then
        handlers[event](self, event, ...)
    end
end)

function ItemEra:RegisterEvent(eventName, callback)
    handlers[eventName] = callback
    frame:RegisterEvent(eventName)
end
