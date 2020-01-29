on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream Alert"
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on subMenuItem(theMenuName, theMenuItemName, theSubMenuItem)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell
	
	if appName does not contain "Finale" then
		errorMessage("Please make sure Finale is the front application")
		return false
	end if
	
	try
		tell application "System Events"
			tell process appName
				set activeMenuItem to enabled of menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
				if item 1 of activeMenuItem is true then
					click menu item theSubMenuItem of menu of menu item theMenuItemName of menu theMenuName of menu bar 1
					click menu item "Smart Shape Options�" of menu theMenuItemName of menu bar 1
					click pop up button 2 of window "Smart Shape Options"
					click menu item "Custom Line" of menu 1 of pop up button 2 of window "Smart Shape Options"
					click button 5 of window "Smart Shape Options"
					return true
				else
					error
				end if
			end tell
		end tell
	on error
		errorMessage("The " & theSubMenuItem & " tool wasn't able to be selected.\n\nPlease be sure your document is in focus and try again.")
		return false
	end try
end subMenuItem

subMenuItem("Tools", "Smart Shape", "Custom Line")