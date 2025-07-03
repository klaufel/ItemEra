local addonName, addon = ...
_G[addonName] = addon

SLASH_ITEMERA1 = "/itemera"
SLASH_ITEMERA2 = "/ie"

SlashCmdList["ITEMERA"] = function(msg)
    local command = string.lower(msg or "")

    if command == "debug" then
        ItemEraSaved.debug = not ItemEraSaved.debug
        local status = ItemEraSaved.debug and "enabled" or "disabled"
        print("ItemEra Debug: Debug mode " .. status)
    elseif command == "reload" or command == "refresh" then
        print("ItemEra: Reloading filters...")
        if addon.Filters then
            addon.Filters:ClearContainerFilter("bank")
            addon.Filters:ClearContainerFilter("reagentBank")
            C_Timer.After(0.5, function()
                addon.Filters:CreateContainerFilter("bank")
                addon.Filters:CreateContainerFilter("reagentBank")
            end)
        end
    elseif command == "test" then
        print("ItemEra Test:")
        print("  Filters module loaded: " .. (addon.Filters and "Yes" or "No"))
        print("  Expansion names: " .. (addon.expansionNames and "Yes" or "No"))
        print("  Bank frame visible: " .. (BankFrame and BankFrame:IsShown() and "Yes" or "No"))
        if addon.Filters then
            print("  Available filter functions: CreateContainerFilter, ClearContainerFilter")
        end
    elseif command == "debugbank" then
        if addon.Filters and addon.Filters.DebugContainerFilter then
            addon.Filters:DebugContainerFilter("bank")
        else
            print("ItemEra: Debug function not available")
        end
    elseif command == "lang" then
        print("ItemEra: Current locale: " .. GetLocale())
    elseif command == "debugreagent" then
        if addon.Filters and addon.Filters.DebugContainerFilter then
            addon.Filters:DebugContainerFilter("reagentBank")
        else
            print("ItemEra: Debug function not available")
        end
    else
        print("ItemEra Commands:")
        print("  /itemera debug - Toggle debug mode")
        print("  /itemera reload - Refresh bag filter")
        print("  /itemera test - Test module loading")
        print("  /itemera debugbank - Debug bank filter")
        print("  /itemera debugreagent - Debug reagent bank filter")
    end
end
