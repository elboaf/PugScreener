#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; CONFIGURATION - Change these values as needed
fileToMonitor := "C:\Users\Administrator\Desktop\twmoa_1172\Imports\pugscreener.txt"  ; Path to your text file
checkInterval := 1000           ; Check every second (1000ms)

; Initialize variables
lastModTime := 0
lastContent := ""

; Set up monitoring timer
SetTimer, MonitorFile, %checkInterval%
return

MonitorFile:
    ; Get current modification time
    FileGetTime, currentModTime, %fileToMonitor%
    
    ; Check if file has been modified
    if (currentModTime != lastModTime) {
        lastModTime := currentModTime
        
        ; Read the file
        FileRead, content, %fileToMonitor%
        
        ; Trim whitespace
        content := Trim(content, " `t`n`r")
        
        ; Check if content has changed and is not empty
        if (content != "" && content != lastContent) {
            lastContent := content
            
            ; Build and open the URL
            url := "https://turtlecraft.gg/armory/Ambershire/" . content
            Run, %url%
            
            ; Optional notification
            ;MsgBox, 64, URL Opened, Opening: %url%
        }
    }
return

; Hotkey to manually trigger reading
F1::
    FileRead, content, %fileToMonitor%
    content := Trim(content, " `t`n`r")
    if (content != "") {
        url := "https://turtlecraft.gg/armory/Ambershire/" . content
        Run, %url%
    }
return

; Exit hotkey

^Esc::ExitApp
