-- PugScreener addon for Turtle WoW
-- Tracks unique player whispers and exports them to file

-- Initialize variables
PUG_SCREENER_ENABLED = false
PUG_SCREENER_PLAYERS = {}

-- Simple string trim function for WoW 1.12
local function trim(str)
    if not str then return "" end
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

-- Function to add a player to the file
local function addPlayerToFile(playerName)
    if not playerName or playerName == "" then
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener: No player name provided")
        return false
    end
    
    -- Clean up the name (remove server/realm if present)
    local cleanName = string.gsub(playerName, "%-[^%-]+$", "")
    
    -- Export to file using superwow.dll's ExportFile function
    if ExportFile then
        ExportFile("pugscreener", cleanName .. "\n")
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener: Added " .. cleanName .. " to pugscreener.txt")
        
        -- Add to tracked players if tracking is enabled
        if PUG_SCREENER_ENABLED then
            PUG_SCREENER_PLAYERS[cleanName] = true
        end
        
        return true
    else
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener ERROR: ExportFile function not found")
        return false
    end
end

-- Slash command handler
SLASH_PUGSCREENER1 = "/pugscreen"
SLASH_PUGSCREENER2 = "/pugscreener" -- Alternative slash command
SlashCmdList["PUGSCREENER"] = function(msg)
    local command = ""
    if msg then
        command = string.lower(trim(msg))
    end
    
    -- Check if the command is just a player name (no spaces means it's likely a name)
    if command == "" then
        -- Show help
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener commands:")
        DEFAULT_CHAT_FRAME:AddMessage("/pugscreen on - Enable whisper tracking")
        DEFAULT_CHAT_FRAME:AddMessage("/pugscreen off - Disable whisper tracking")
        DEFAULT_CHAT_FRAME:AddMessage("/pugscreen <name> - Manually add a player to the file")
        DEFAULT_CHAT_FRAME:AddMessage("/pugscreener <name> - Same as above")
    elseif command == "on" then
        PUG_SCREENER_ENABLED = true
        PUG_SCREENER_PLAYERS = {} -- Reset player list
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener: ON - Tracking unique whispers")
    elseif command == "off" then
        PUG_SCREENER_ENABLED = false
        PUG_SCREENER_PLAYERS = {} -- Clear player list
        DEFAULT_CHAT_FRAME:AddMessage("PugScreener: OFF")
    else
        -- Check if it might be a player name
        -- If it doesn't match our other commands, assume it's a player name
        local playerName = trim(msg) -- Use the original input (case sensitive)
        addPlayerToFile(playerName)
    end
end

-- Create frame for event handling
local pugFrame = CreateFrame("Frame")
pugFrame:RegisterEvent("CHAT_MSG_WHISPER")
pugFrame:SetScript("OnEvent", function()
    if event == "CHAT_MSG_WHISPER" and PUG_SCREENER_ENABLED then
        local playerName = arg2
        
        if playerName and playerName ~= "" then
            -- Clean up the name (remove server/realm if present)
            local cleanName = string.gsub(playerName, "%-[^%-]+$", "")
            
            -- Check if this is a new unique player
            if cleanName ~= "" and not PUG_SCREENER_PLAYERS[cleanName] then
                -- Use our function to add the player
                addPlayerToFile(playerName)
            end
        end
    end
end)

-- Initialization message

DEFAULT_CHAT_FRAME:AddMessage("PugScreener loaded. Type /pugscreen for commands.")
