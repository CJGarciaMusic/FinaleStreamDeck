on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theMenuItemName of menu theMenuName of menu bar 1
                set getItem to value of attribute "AXEnabled" of menu item theSubMenuItem of menu theMenuItemName of menu bar 1
                if getItem then
                    click menu item theSubMenuItem of menu theMenuItemName of menu bar 1
                else
                    tell application "System Events"
                        set theAlertText to "A Stream Deck error has occurred."
                        set theAlertMessage to "Please click into a text frame and try again."
                        display alert theAlertText message theAlertMessage as critical
                        return false
                    end tell
                end if
                end tell
            end tell
		return true
	on error
        tell application "System Events"
            set theAlertText to "A Stream Deck error has occurred."
            set theAlertMessage to theMenuItemName & " - " & theSubMenuItem & " wasn't able to be selected.\n\nPlease try again."
            display alert theAlertText message theAlertMessage as critical
            return false
        end tell
	end try
end subMenuItem

subMenuItem("Tools", "Text", "Word Wrap")