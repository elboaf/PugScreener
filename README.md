# PugScreener Addon for Turtle WoW

PugScreener has a companion app that monitors the exported file for changes. The companion app in no way interacts with the game client whatsoever, and would not violate any of the turtle wow rules https://turtlecraft.gg/rules

## Overview
PugScreener is a lightweight addon for Turtle WoW that helps you track and export the names of players who whisper you, perfect for managing PUG (Pick-Up Group) recruitment or tracking contacts.

## Features
- **Automatic tracking**: When enabled, automatically exports unique player names from whispers to a text file
- **Manual name addition**: Manually add player names via slash commands
- **Duplicate prevention**: Won't export the same player twice while tracking is active
- **Server name filtering**: Automatically removes server/realm suffixes from names
- **Simple toggle**: Easy on/off control with memory reset

## Installation
1. Download the addon files
2. Extract to your WoW folder: `World of Warcraft/Interface/AddOns/PugScreener/`
3. Ensure you have the following files in the folder:
   - `PugScreener.toc`
   - `PugScreener.lua`
4. Restart WoW or type `/reload` in-game
5. Install AutoHotKey https://www.autohotkey.com/
6. Edit the PugScreener.ahk fileToMonitor line with the path to your TurtleWow Imports directory
7. Run PugScreener.ahk

## Requirements
- Turtle WoW client (WoW 1.12)
- superwow.dll mod (for ExportFile functionality)

## Commands

### Basic Commands
- `/pugscreen on` - Enable automatic whisper tracking
- `/pugscreen off` - Disable tracking and clear memory
- `/pugscreen` or `/pugscreen help` - Show command list

### Manual Name Addition
- `/pugscreen <playername>` - Manually add a player to the file
- `/pugscreener <playername>` - Same as above (alternative command)
