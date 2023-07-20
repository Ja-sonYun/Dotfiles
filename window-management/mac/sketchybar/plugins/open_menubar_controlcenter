#!/usr/bin/osascript

tell application "System Events" to tell process "Control Center"
	set one to menu bar 1's menu bar items's attribute "AXDescription"'s value
	set num to 0
	repeat with two in one
		set tt to two as text
		set num to num + 1
		if tt = "Control Center" then
			set num2 to num
		end if
	end repeat

	click menu bar item num2 of menu bar 1
end tell
