#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


/*
	How to use.
	In most games W is used to "move" forward. Thus when calling this function
	it will simulate a W key down. You can call this function from any hotkey
	in you're script. Press the key once to move forward, press it again to 
	stop moving. Clicking the left mouse button or press/release W also
	will stop you're character from moving.
	
	Place this file in you're Authotkey library folder. Which is here:
	%Userprofile%\documents\AutoHotkey\lib\
	
	Give it the following name:
	AutoWalk.ahk
	
	Simply call this function from some hotkey in you're script. For example:
	
	~w::
	AutoWalk()
	Return
	
*/
#InstallKeybdHook
#InstallMouseHook

global AnyKey			;Declaring variable AnyKey as global variable. Variables in functions are local to that function.

while(1)
{
	Home::
	AutoWalk()
	{
		AnyKey:=A_ThisHotkey					;Placing last pressed hotkey in variable AnyKey.
		AnyKey:=StrReplace(AnyKey, "~")			;Remove the tilde character from variable Anykey, for none blocked hotkeys.
		If(AnyKey = "w")						;Check to see if the hotkey is also the w key.
		{
			KeyWait, w, T0.5			;Waiting half a second for w to be physically released.
			If(errorlevel = 1)			;When w is still down after 500ms errorlevel is set to 1. You're probably walking manually.
			{
				KeyWait, w			;Waiting for w key to be released.
				exit				;W is physically released, so we can exit here since movement is stopped.
			}
		}	
		keywait, %AnyKey%							;Waiting for the hotkey to be released.
		If not W_VirtState:=GetKeyState("w")		;When the virtual status of the w key is not down, when W_VirtState is 0. Do whatever comes below.
		{
			SendInput, {w down}						;Virtually pressing w down. Virtual (logical state) is whatever your O.S. thinks the key status is in. Physical is the actual state on you're keyboard.
			Send {Shift down}
			keywait, %AnyKey%
			Loop
			{	;When you're hotkey, Lbutton or w key is physically pressed down, variable KeyState will be set to 1. The body of the "if" statement will then execute.
				If(KeyState:=GetKeyState(AnyKey, "P") || KeyState:=GetKeyState("Lbutton", "P") || KeyState:=GetKeyState("w", "P"))
				{
					keywait, %AnyKey%			;Waiting for you're hotkey to be released.
					SendInput, {w up}			;Virtually sending w up. Stop moving.
					Send {Shift up}
					break						;Breaking free from the loop.
				}
				sleep, 100			;Sleeping 1/10th of a second each time the loop is iterated. Prevents the function from using to much CPU cycles.
			}						;You can increase the sleep period, but the function will be less responsive.
		}
	}
}
Return
