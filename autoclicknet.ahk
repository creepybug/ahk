#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
#InstallMouseHook

range := 100

$F3::

Send {Shift down}

click
MouseMove, range, range, 5, R
click
MouseMove, range, range, 5, R
click

MouseMove, (-2*range), (-1*range), 5, R
click
MouseMove, range, range, 5, R
click
MouseMove, range, range, 5, R
click

MouseMove, (-2*range), (-1*range), 5, R
click
MouseMove, range, range, 5, R
click
MouseMove, range, range, 5, R
click

Send {Shift up}

return 


