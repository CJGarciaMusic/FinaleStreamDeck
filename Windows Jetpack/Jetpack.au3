#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Author: CJ Garcia
 Script Function: Stream Deck Finale Jetpack UI automation tools for Windows
#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>

Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

CheckIfActive()
Func MsgError($text)
    MsgBox($MB_OK, "StreamDeck Error", $text)
EndFunc

Func LuaMenu($luaNum)
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4])
   Send($luaNum)
   ControlClick ("[CLASS:#32770]", "", "OK")
EndFunc

Func MenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3])
EndFunc

Func SubmenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4])
EndFunc

Func SubsubmenuItem()
   WinMenuSelectItem("[CLASS:Finale]", "", $CmdLine[2], $CmdLine[3], $CmdLine[4], $CmdLine[5])
EndFunc

Func FilterItems($actionType)
   If $actionType = "Filter" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Edit Filter...")
   ElseIf $actionType = "Clear" Then
	  WinMenuSelectItem("[CLASS:Finale]", "", "&Edit", "Cl&ear Selected Items...")
   EndIf
   ControlClick("[CLASS:#32770]", "", "&None")
   Local $myArray = StringSplit($CmdLine[2], "|")
   For $a1 = 1 To (UBound($myArray) - 1)
	  ControlClick("[CLASS:#32770]", "", $myArray[$a1])
   Next
   ControlClick("[CLASS:#32770]", "", "OK")
EndFunc

Func CheckIfActive()
    Local $frontWin = WinGetTitle("[ACTIVE]")
    Local $myResult = StringInStr($frontWin, "Finale")
    If $myResult = 1 Then
      If $CmdLine[1] = "Lua" Then
		 LuaMenu($CmdLine[5])
	  ElseIf $CmdLine[1] = "Menu" Then
		 MenuItem()
	  ElseIf $CmdLine[1] = "Submenu" Then
		 SubmenuItem()
	  ElseIf $CmdLine[1] = "Subsubmenu" Then
		 SubsubmenuItem()
	  ElseIf ($CmdLine[1] = "Filter") Or ($CmdLine[1] = "Clear") Then
		 FilterItems($CmdLine[1])
	  EndIf
	Else
        MsgError("Finale does not appear to be in focus. Please try again.")
    EndIf
EndFunc