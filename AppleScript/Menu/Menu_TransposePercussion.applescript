on errorMessage(displayMessage)
	tell application "System Events"
		set theAlertText to "JetStream has encountered some turbulence..."
		set theAlertMessage to displayMessage
		display alert theAlertText message theAlertMessage as critical
	end tell
end errorMessage

on chooseMenuItem(theMenuName, theMenuItemName)
	tell application "System Events"
		set appName to name of the first process whose frontmost is true
	end tell

	if appName does not contain "Finale" then
		errorMessage("Finale is not in focus, please try again")
		return false
	end if

	try
		tell application "System Events"
			tell process appName
				set activeMenuItem to enabled of menu item theMenuItemName of menu theMenuName of menu bar 1
				if activeMenuItem is true then
					click menu item theMenuItemName of menu theMenuName of menu bar 1
					return true 
				else
					error 
				end if
			end tell
		end tell
	on error
		errorMessage(theMenuItemName & " wasn't able to be selected.\n\nPlease be sure the region you selected is using a Percussion Notation Style and that Finale is in focus and try again.")
		return false
	end try
end chooseMenuItem

chooseMenuItem("Utilities", "Transpose Percussion Notes�")