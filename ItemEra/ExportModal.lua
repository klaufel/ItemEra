local ItemEra = LibStub("AceAddon-3.0"):GetAddon("ItemEra")
local AceGUI = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ItemEra")

-- JSON Serialization Utility
local JSON = {}

function JSON:Escape(str)
    if type(str) ~= "string" then
        return tostring(str)
    end

    str = str:gsub("\\", "\\\\")
    str = str:gsub('"', '\\"')
    str = str:gsub("\n", "\\n")
    str = str:gsub("\r", "\\r")
    str = str:gsub("\t", "\\t")
    return str
end

function JSON:Encode(value, indent)
    -- Minified JSON encoding (single line, no formatting)
    if type(value) == "nil" then
        return "null"
    elseif type(value) == "boolean" then
        return value and "true" or "false"
    elseif type(value) == "number" then
        return tostring(value)
    elseif type(value) == "string" then
        return '"' .. self:Escape(value) .. '"'
    elseif type(value) == "table" then
        -- Check if it's an array (sequential numeric keys)
        local isArray = true
        local count = 0
        for k, v in pairs(value) do
            count = count + 1
            if type(k) ~= "number" or k ~= count then
                isArray = false
                break
            end
        end

        if isArray then
            -- Array
            local parts = {}
            for i, v in ipairs(value) do
                table.insert(parts, self:Encode(v))
            end
            if #parts == 0 then
                return "[]"
            end
            return "[" .. table.concat(parts, ",") .. "]"
        else
            -- Object
            local parts = {}
            -- Sort keys for consistent output
            local keys = {}
            for k in pairs(value) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)

            for _, k in ipairs(keys) do
                local v = value[k]
                local key = type(k) == "string" and k or tostring(k)
                table.insert(parts, '"' .. self:Escape(key) .. '":' .. self:Encode(v))
            end
            if #parts == 0 then
                return "{}"
            end
            return "{" .. table.concat(parts, ",") .. "}"
        end
    else
        return '"' .. tostring(value) .. '"'
    end
end

-- Export Modal
local ExportModal = {}
ItemEra.ExportModal = ExportModal

local currentFrame = nil

function ExportModal:GetCalendarEventType(calendarType)
    local types = {
        [0] = "RAID_LOCKOUT",
        [1] = "RAID_RESET",
        [2] = "DUNGEON_RESET",
        [3] = "EVENT",
        [4] = "HOLIDAY",
        [5] = "BATTLEGROUND",
        [6] = "DARKMOON_FAIRE",
        [7] = "ARCHAEOLOGY",
        [8] = "TIMEWALKING"
    }
    return types[calendarType] or "UNKNOWN"
end

function ExportModal:BuildExportData()
    -- Open the calendar to ensure data is loaded
    if C_AddOns then
        C_AddOns.LoadAddOn("Blizzard_Calendar")
    else
        LoadAddOn("Blizzard_Calendar")
    end

    local data = {
        exportDate = date("%Y-%m-%d %H:%M:%S"),
        timezone = date("%z"),
        addonVersion = C_AddOns and C_AddOns.GetAddOnMetadata("ItemEra", "Version") or
            GetAddOnMetadata("ItemEra", "Version") or "Unknown",
        gameEvents = {},
        gameHolidays = {}
    }

    -- Get current date
    local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()

    -- First, open the calendar to ensure it's initialized
    C_Calendar.OpenCalendar()

    -- PART 1: Export Calendar Events (raid lockouts, personal events, etc.)
    local monthsBackward = 6 -- Scan 6 months back (reduced to prevent freezing)
    local monthsForward = 6  -- Scan 6 months forward (reduced to prevent freezing)
    local calendarEventsFound = 0

    -- Scan backward (previous year)
    for monthOffset = -monthsBackward, -1 do
        -- Set the calendar to the specific month
        C_Calendar.SetAbsMonth(currentCalendarTime.month, currentCalendarTime.year)
        C_Calendar.SetMonth(monthOffset)

        local monthInfo = C_Calendar.GetMonthInfo()

        if monthInfo then
            -- Scan all days in the month
            for day = 1, monthInfo.numDays do
                local numDayEvents = C_Calendar.GetNumDayEvents(0, day)

                for eventIndex = 1, numDayEvents do
                    local eventInfo = C_Calendar.GetDayEvent(0, day, eventIndex)

                    if eventInfo then
                        -- Skip personal calendar events, only include game events
                        if eventInfo.calendarType ~= "PLAYER" and eventInfo.calendarType ~= "GUILD_EVENT" and
                            eventInfo.calendarType ~= "RAID_LOCKOUT" and eventInfo.calendarType ~= "RAID_RESET" then
                            table.insert(data.gameEvents, eventInfo)
                            calendarEventsFound = calendarEventsFound + 1
                        end
                    end
                end
            end
        end
    end

    -- Scan forward (current month + next year)
    for monthOffset = 0, monthsForward - 1 do
        -- Set the calendar to the specific month
        C_Calendar.SetAbsMonth(currentCalendarTime.month, currentCalendarTime.year)
        C_Calendar.SetMonth(monthOffset)

        local monthInfo = C_Calendar.GetMonthInfo()

        if monthInfo then
            -- Scan all days in the month
            for day = 1, monthInfo.numDays do
                local numDayEvents = C_Calendar.GetNumDayEvents(0, day)

                for eventIndex = 1, numDayEvents do
                    local eventInfo = C_Calendar.GetDayEvent(0, day, eventIndex)

                    if eventInfo then
                        -- Skip personal calendar events, only include game events
                        if eventInfo.calendarType ~= "PLAYER" and eventInfo.calendarType ~= "GUILD_EVENT" and
                            eventInfo.calendarType ~= "RAID_LOCKOUT" and eventInfo.calendarType ~= "RAID_RESET" then
                            table.insert(data.gameEvents, eventInfo)
                            calendarEventsFound = calendarEventsFound + 1
                        end
                    end
                end
            end
        end
    end

    -- PART 2: Export Game Holidays (lightweight - only current month forward)
    -- Note: Holidays repeat yearly, so we don't need to scan backward
    local holidaysFound = 0

    -- Only scan forward for holidays to reduce processing time
    for monthOffset = 0, monthsForward - 1 do
        C_Calendar.SetAbsMonth(currentCalendarTime.month, currentCalendarTime.year)
        C_Calendar.SetMonth(monthOffset)

        local monthInfo = C_Calendar.GetMonthInfo()
        if monthInfo then
            -- Check each day for holidays (sample every 7 days to reduce load)
            for day = 1, monthInfo.numDays, 7 do
                local numHolidays = C_Calendar.GetNumDayEvents(0, day)

                -- Check if any events are holidays
                for holidayIndex = 1, numHolidays do
                    local holidayInfo = C_Calendar.GetHolidayInfo(0, day, holidayIndex)

                    if holidayInfo and holidayInfo.name then
                        table.insert(data.gameHolidays, holidayInfo)
                        holidaysFound = holidaysFound + 1
                    end
                end
            end
        end
    end

    -- Add statistics and debug info
    data.statistics = {
        totalGameEvents = calendarEventsFound,
        totalGameHolidays = holidaysFound,
        totalEvents = calendarEventsFound + holidaysFound,
        monthsScannedBackward = monthsBackward,
        monthsScannedForward = monthsForward,
        totalMonthsScanned = monthsBackward + monthsForward,
        scanCenterMonth = currentCalendarTime.month,
        scanCenterYear = currentCalendarTime.year
    }

    -- Add a note if no events were found
    if calendarEventsFound == 0 and holidaysFound == 0 then
        data.note =
        "No events found. This could mean: 1) The calendar is empty, 2) The calendar needs to be opened manually first, or 3) You need to log into a character that has calendar permissions."
    end

    return data
end

function ExportModal:BuildMultiYearExportData(years, progressCallback)
    -- Open the calendar to ensure data is loaded
    if C_AddOns then
        C_AddOns.LoadAddOn("Blizzard_Calendar")
    else
        LoadAddOn("Blizzard_Calendar")
    end

    local data = {
        exportDate = date("%Y-%m-%d %H:%M:%S"),
        timezone = date("%z"),
        addonVersion = C_AddOns and C_AddOns.GetAddOnMetadata("ItemEra", "Version") or
            GetAddOnMetadata("ItemEra", "Version") or "Unknown",
        gameEvents = {},
        gameHolidays = {},
        yearsExported = years
    }

    C_Calendar.OpenCalendar()

    local calendarEventsFound = 0
    local holidaysFound = 0
    local monthsProcessed = 0
    local totalMonths = #years * 12

    -- Process each year and month incrementally
    local yearIndex = 1
    local monthIndex = 1

    local function processNextMonth()
        if yearIndex > #years then
            -- Finished processing all years
            data.statistics = {
                totalGameEvents = calendarEventsFound,
                totalGameHolidays = holidaysFound,
                totalEvents = calendarEventsFound + holidaysFound,
                totalMonthsScanned = monthsProcessed,
                yearsScanned = #years
            }

            if calendarEventsFound == 0 and holidaysFound == 0 then
                data.note = "No events found in the specified years."
            end

            if progressCallback then
                progressCallback(true, data) -- Finished
            end
            return
        end

        local year = years[yearIndex]
        local month = monthIndex

        -- Set calendar to specific month and year
        C_Calendar.SetAbsMonth(month, year)

        local monthInfo = C_Calendar.GetMonthInfo()

        if monthInfo then
            -- Scan all days in the month
            for day = 1, monthInfo.numDays do
                local numDayEvents = C_Calendar.GetNumDayEvents(0, day)

                for eventIndex = 1, numDayEvents do
                    local eventInfo = C_Calendar.GetDayEvent(0, day, eventIndex)

                    if eventInfo then
                        -- Skip personal calendar events, only include game events
                        if eventInfo.calendarType ~= "PLAYER" and eventInfo.calendarType ~= "GUILD_EVENT" and
                            eventInfo.calendarType ~= "RAID_LOCKOUT" and eventInfo.calendarType ~= "RAID_RESET" then
                            table.insert(data.gameEvents, eventInfo)
                            calendarEventsFound = calendarEventsFound + 1
                        end
                    end
                end

                -- Check for holidays
                for holidayIndex = 1, numDayEvents do
                    local holidayInfo = C_Calendar.GetHolidayInfo(0, day, holidayIndex)

                    if holidayInfo and holidayInfo.name then
                        table.insert(data.gameHolidays, holidayInfo)
                        holidaysFound = holidaysFound + 1
                    end
                end
            end
        end

        monthsProcessed = monthsProcessed + 1

        -- Update progress
        if progressCallback then
            local progress = (monthsProcessed / totalMonths) * 100
            progressCallback(false, nil, progress, year, month) -- Not finished yet
        end

        -- Move to next month
        monthIndex = monthIndex + 1
        if monthIndex > 12 then
            monthIndex = 1
            yearIndex = yearIndex + 1
        end

        -- Schedule next month processing with a small delay to avoid freezing
        C_Timer.After(0.05, processNextMonth)
    end

    -- Start processing
    processNextMonth()
end

function ExportModal:BuildSingleYearExportData(year, progressCallback)
    -- Open the calendar to ensure data is loaded
    if C_AddOns then
        C_AddOns.LoadAddOn("Blizzard_Calendar")
    else
        LoadAddOn("Blizzard_Calendar")
    end

    local data = {
        exportDate = date("%Y-%m-%d %H:%M:%S"),
        timezone = date("%z"),
        addonVersion = C_AddOns and C_AddOns.GetAddOnMetadata("ItemEra", "Version") or
            GetAddOnMetadata("ItemEra", "Version") or "Unknown",
        gameEvents = {},
        gameHolidays = {},
        yearExported = year
    }

    C_Calendar.OpenCalendar()

    local calendarEventsFound = 0
    local holidaysFound = 0
    local monthsProcessed = 0
    local daysProcessed = 0
    local totalMonths = 12

    -- Process each month and day incrementally
    local monthIndex = 1
    local dayIndex = 1
    local currentMonthInfo = nil

    local function processNextDay()
        -- Check if we need to move to the next month
        if not currentMonthInfo or dayIndex > currentMonthInfo.numDays then
            monthIndex = monthIndex + 1
            dayIndex = 1

            if monthIndex > 12 then
                -- Finished processing the year
                data.statistics = {
                    totalGameEvents = calendarEventsFound,
                    totalGameHolidays = holidaysFound,
                    totalEvents = calendarEventsFound + holidaysFound,
                    totalMonthsScanned = monthsProcessed,
                    totalDaysScanned = daysProcessed,
                    yearScanned = year
                }

                if calendarEventsFound == 0 and holidaysFound == 0 then
                    data.note = "No events found in the specified year."
                end

                if progressCallback then
                    progressCallback(true, data) -- Finished
                end
                return
            end

            -- Set calendar to the new month
            C_Calendar.SetAbsMonth(monthIndex, year)
            currentMonthInfo = C_Calendar.GetMonthInfo()
            monthsProcessed = monthsProcessed + 1
        end

        if currentMonthInfo then
            local day = dayIndex
            local numDayEvents = C_Calendar.GetNumDayEvents(0, day)

            -- Process all events for this day
            for eventIndex = 1, numDayEvents do
                local eventInfo = C_Calendar.GetDayEvent(0, day, eventIndex)

                if eventInfo then
                    -- Skip personal calendar events, only include game events
                    if eventInfo.calendarType ~= "PLAYER" and eventInfo.calendarType ~= "GUILD_EVENT" and
                        eventInfo.calendarType ~= "RAID_LOCKOUT" and eventInfo.calendarType ~= "RAID_RESET" then
                        table.insert(data.gameEvents, eventInfo)
                        calendarEventsFound = calendarEventsFound + 1
                    end
                end
            end

            -- Check for holidays
            for holidayIndex = 1, numDayEvents do
                local holidayInfo = C_Calendar.GetHolidayInfo(0, day, holidayIndex)

                if holidayInfo and holidayInfo.name then
                    table.insert(data.gameHolidays, holidayInfo)
                    holidaysFound = holidaysFound + 1
                end
            end

            daysProcessed = daysProcessed + 1
        end

        -- Update progress
        if progressCallback then
            -- Calculate progress: (completed months * 30 + current day) / (12 * 30)
            local estimatedTotalDays = 365
            local estimatedProgress = (daysProcessed / estimatedTotalDays) * 100
            progressCallback(false, nil, estimatedProgress, year, monthIndex) -- Not finished yet
        end

        -- Move to next day
        dayIndex = dayIndex + 1

        -- Schedule next day processing with a minimal delay to avoid freezing
        C_Timer.After(0.01, processNextDay)
    end

    -- Start processing
    C_Calendar.SetAbsMonth(1, year)
    currentMonthInfo = C_Calendar.GetMonthInfo()
    processNextDay()
end

function ExportModal:Show()
    -- Close existing frame if open
    if currentFrame then
        currentFrame:Release()
        currentFrame = nil
    end

    -- Create main frame
    local frame = AceGUI:Create("Frame")
    currentFrame = frame

    frame:SetTitle("ItemEra - " .. (L["Export Calendar Events"] or "Export Calendar Events"))
    frame:SetWidth(700)
    frame:SetHeight(550)
    frame:SetLayout("Flow")
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        currentFrame = nil
    end)

    -- Header Section
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetFullWidth(true)
    headerGroup:SetLayout("Flow")
    frame:AddChild(headerGroup)

    -- Icon
    local icon = AceGUI:Create("Icon")
    icon:SetImage("Interface\\AddOns\\ItemEra\\assets\\icon.tga")
    icon:SetImageSize(48, 48)
    icon:SetWidth(60)
    headerGroup:AddChild(icon)

    -- Title
    local title = AceGUI:Create("Heading")
    title:SetText(L["Export Calendar Events"] or "Export Calendar Events")
    title:SetFullWidth(true)
    headerGroup:AddChild(title)

    -- Description
    local description = AceGUI:Create("Label")
    description:SetText(L["Export all game calendar events to JSON format. Copy the text below and save it to a file."] or
        "Export all game calendar events to JSON format. Copy the text below and save it to a file.")
    description:SetFullWidth(true)
    description:SetFontObject(GameFontHighlight)
    headerGroup:AddChild(description)

    -- Spacer
    local spacer1 = AceGUI:Create("Label")
    spacer1:SetText(" ")
    spacer1:SetFullWidth(true)
    headerGroup:AddChild(spacer1)

    -- Generate JSON button
    local generateButton = AceGUI:Create("Button")
    generateButton:SetText(L["Generate JSON Export"] or "Generate JSON Export")
    generateButton:SetWidth(200)

    -- Store reference to editbox
    local editBoxRef = nil

    generateButton:SetCallback("OnClick", function()
        generateButton:SetDisabled(true)
        generateButton:SetText(L["Generating..."] or "Generating...")

        -- Use C_Timer to avoid blocking
        C_Timer.After(0.1, function()
            local success, result = pcall(function()
                local exportData = ExportModal:BuildExportData()
                return JSON:Encode(exportData)
            end)

            if success then
                if editBoxRef then
                    editBoxRef:SetText(result)
                    print("|cff00ff00ItemEra:|r " ..
                        (L["JSON export generated successfully! Select all text and copy it."] or
                            "JSON export generated successfully! Select all text and copy it."))
                end
            else
                if editBoxRef then
                    editBoxRef:SetText("|cffff0000Error generating export:|r\n" .. tostring(result))
                end
                print("|cffff0000ItemEra:|r Error generating export: " .. tostring(result))
            end

            generateButton:SetDisabled(false)
            generateButton:SetText(L["Generate JSON Export"] or "Generate JSON Export")
        end)
    end)
    headerGroup:AddChild(generateButton)

    -- Year Export Buttons
    local year2024Button = AceGUI:Create("Button")
    year2024Button:SetText(L["Export 2024"] or "Export 2024")
    year2024Button:SetWidth(130)

    year2024Button:SetCallback("OnClick", function()
        year2024Button:SetDisabled(true)
        generateButton:SetDisabled(true)
        year2024Button:SetText(L["Exporting... 0%"] or "Exporting... 0%")

        if editBoxRef then
            editBoxRef:SetText(L["Processing year 2024... Please wait."] or
                "Processing year 2024... Please wait.")
        end

        ExportModal:BuildSingleYearExportData(2024,
            function(finished, data, progress, currentYear, currentMonth)
                if finished then
                    -- Export complete
                    local success, result = pcall(function()
                        return JSON:Encode(data)
                    end)

                    if success then
                        if editBoxRef then
                            editBoxRef:SetText(result)
                            print("|cff00ff00ItemEra:|r " ..
                                (L["Year 2024 export generated successfully!"] or
                                    "Year 2024 export generated successfully!"))
                        end
                    else
                        if editBoxRef then
                            editBoxRef:SetText("|cffff0000Error generating export:|r\n" .. tostring(result))
                        end
                        print("|cffff0000ItemEra:|r Error generating export: " .. tostring(result))
                    end

                    year2024Button:SetDisabled(false)
                    generateButton:SetDisabled(false)
                    year2024Button:SetText(L["Export 2024"] or "Export 2024")
                else
                    local progressText = string.format(
                        L["Exporting... %.0f%%"] or "Exporting... %.0f%%", progress)
                    year2024Button:SetText(progressText)
                end
            end)
    end)
    headerGroup:AddChild(year2024Button)

    local year2025Button = AceGUI:Create("Button")
    year2025Button:SetText(L["Export 2025"] or "Export 2025")
    year2025Button:SetWidth(130)

    year2025Button:SetCallback("OnClick", function()
        year2025Button:SetDisabled(true)
        generateButton:SetDisabled(true)
        year2025Button:SetText(L["Exporting... 0%"] or "Exporting... 0%")

        if editBoxRef then
            editBoxRef:SetText(L["Processing year 2025... Please wait."] or
                "Processing year 2025... Please wait.")
        end

        ExportModal:BuildSingleYearExportData(2025,
            function(finished, data, progress, currentYear, currentMonth)
                if finished then
                    -- Export complete
                    local success, result = pcall(function()
                        return JSON:Encode(data)
                    end)

                    if success then
                        if editBoxRef then
                            editBoxRef:SetText(result)
                            print("|cff00ff00ItemEra:|r " ..
                                (L["Year 2025 export generated successfully!"] or
                                    "Year 2025 export generated successfully!"))
                        end
                    else
                        if editBoxRef then
                            editBoxRef:SetText("|cffff0000Error generating export:|r\n" .. tostring(result))
                        end
                        print("|cffff0000ItemEra:|r Error generating export: " .. tostring(result))
                    end

                    year2025Button:SetDisabled(false)
                    generateButton:SetDisabled(false)
                    year2025Button:SetText(L["Export 2025"] or "Export 2025")
                else
                    local progressText = string.format(
                        L["Exporting... %.0f%%"] or "Exporting... %.0f%%", progress)
                    year2025Button:SetText(progressText)
                end
            end)
    end)
    headerGroup:AddChild(year2025Button)

    local year2026Button = AceGUI:Create("Button")
    year2026Button:SetText(L["Export 2026"] or "Export 2026")
    year2026Button:SetWidth(130)

    year2026Button:SetCallback("OnClick", function()
        year2026Button:SetDisabled(true)
        generateButton:SetDisabled(true)
        year2026Button:SetText(L["Exporting... 0%"] or "Exporting... 0%")

        if editBoxRef then
            editBoxRef:SetText(L["Processing year 2026... Please wait."] or
                "Processing year 2026... Please wait.")
        end

        ExportModal:BuildSingleYearExportData(2026,
            function(finished, data, progress, currentYear, currentMonth)
                if finished then
                    -- Export complete
                    local success, result = pcall(function()
                        return JSON:Encode(data)
                    end)

                    if success then
                        if editBoxRef then
                            editBoxRef:SetText(result)
                            print("|cff00ff00ItemEra:|r " ..
                                (L["Year 2026 export generated successfully!"] or
                                    "Year 2026 export generated successfully!"))
                        end
                    else
                        if editBoxRef then
                            editBoxRef:SetText("|cffff0000Error generating export:|r\n" .. tostring(result))
                        end
                        print("|cffff0000ItemEra:|r Error generating export: " .. tostring(result))
                    end

                    year2026Button:SetDisabled(false)
                    generateButton:SetDisabled(false)
                    year2026Button:SetText(L["Export 2026"] or "Export 2026")
                else
                    local progressText = string.format(
                        L["Exporting... %.0f%%"] or "Exporting... %.0f%%", progress)
                    year2026Button:SetText(progressText)
                end
            end)
    end)
    headerGroup:AddChild(year2026Button)

    -- JSON Output Section
    local outputGroup = AceGUI:Create("SimpleGroup")
    outputGroup:SetFullWidth(true)
    outputGroup:SetFullHeight(true)
    outputGroup:SetLayout("Fill")
    frame:AddChild(outputGroup)

    -- Regular EditBox for JSON output (better performance than MultiLineEditBox)
    local editBox = AceGUI:Create("EditBox")
    editBoxRef = editBox
    editBox:SetLabel(L["JSON Export Output:"] or "JSON Export Output:")
    editBox:SetFullWidth(true)
    editBox:SetText(L["Click a button above to generate export"] or "Click a button above to generate export")
    editBox:DisableButton(true)
    outputGroup:AddChild(editBox)

    -- Footer Section
    local footerGroup = AceGUI:Create("SimpleGroup")
    footerGroup:SetFullWidth(true)
    footerGroup:SetLayout("Flow")
    frame:AddChild(footerGroup)

    -- Instructions
    local instructions = AceGUI:Create("Label")
    instructions:SetText("|cffFFD700" .. (L["Tip:"] or "Tip:") .. "|r " ..
        (L["Use Ctrl+A to select all text, then Ctrl+C to copy."] or
            "Use Ctrl+A to select all text, then Ctrl+C to copy."))
    instructions:SetFullWidth(true)
    instructions:SetFontObject(GameFontNormalSmall)
    footerGroup:AddChild(instructions)

    -- Close Button
    local closeButton = AceGUI:Create("Button")
    closeButton:SetText(L["Close"] or "Close")
    closeButton:SetWidth(120)
    closeButton:SetCallback("OnClick", function()
        frame:Hide()
    end)
    footerGroup:AddChild(closeButton)
end

return ExportModal
