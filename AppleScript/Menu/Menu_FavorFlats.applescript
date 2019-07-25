on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	try
		tell application "System Events"
			tell process appName
				click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
				click menu item "Respell Notes" of menu "Utilities" of menu bar 1
			end tell
		end tell
		return true
	on error
		tell application "System Events"
			set theAlertText to "A Stream Deck error has occurred."
			set theAlertMessage to "The " & theSubMenuItem & " tool wasn't able to be selected.\n\nPlease try again."
			display alert theAlertText message theAlertMessage as critical
			return false
		end tell
	end try
end subMenuItem

subMenuItem("Finale", "Enharmonic Spelling", "Favor Flats")