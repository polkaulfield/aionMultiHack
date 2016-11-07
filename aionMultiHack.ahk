;@Ahk2Exe-SetVersion 5.0
#NoEnv
#SingleInstance off
SendMode Input
SetWorkingDir %A_ScriptDir%
#include classMemory.ahk
#IfWinActive, AION Client (64 bit)
menu, tray, NoStandard
SetFormat, float, 0.2

;Default Values
NoaniValue := 1
EnhancedAnimation := 250
EnhancedSpeed := 0.2
Extend := 1.9
EyeValue := 3
WinTitle := "AION Client"
ProgramName := "aionMultiHack 5.0"
ConfigFile := ProgramName ".ini"
TeleportValue := 1
TimerDelay := 50
EyeHackDelay := 250
AntiGM := 1
AutoAttack := 250

;DefaultHotkeys
TpUpKey := "NumpadAdd"
TpDwnKey := "NumpadSub"
TpFwKey := "Up"
TpBkKey := "Down"
TpRKey := "Right"
TpLKey := "Left"
NoGravKey := "Numpad7"
GlideLockKey := "Numpad5"


IfExist, %ConfigFile% 
{
	IniRead, NoaniValue, %ConfigFile%, Config, NoaniValue
	IniRead, EnhancedAnimation, %ConfigFile%, Config, EnhancedAnimation
	IniRead, EnhancedSpeed, %ConfigFile%, Config, EnhancedSpeed
	IniRead, Extend, %ConfigFile%, Config, Extend
	IniRead, TeleportValue, %ConfigFile%, Config, TeleportValue
	IniRead, EyeHackDelay, %ConfigFile%, Config, EyeHackDelay
	IniRead, AntiGM, %ConfigFile%, Config, AntiGM
	IniRead, AutoAttack, %ConfigFile%, Config, AutoAttack
	;Read Hotkeys
	IniRead, TpUpKey, %ConfigFile%, Hotkeys, TpUpKey
	IniRead, TpDwnKey, %ConfigFile%, Hotkeys, TpDwnKey
	IniRead, TpFwKey, %ConfigFile%, Hotkeys, TpFwKey
	IniRead, TpBkKey, %ConfigFile%, Hotkeys, TpBkKey
	IniRead, TpRKey, %ConfigFile%, Hotkeys, TpRKey
	IniRead, TpLKey, %ConfigFile%, Hotkeys, TpLKey
	IniRead, NoGravKey, %ConfigFile%, Hotkeys, NoGravKey
	IniRead, GlideLockKey, %ConfigFile%, Hotkeys, GlideLockKey
	
}
else 
{
	IniWrite, %NoaniValue%, %ConfigFile%, Config, NoaniValue
	IniWrite, %EnhancedAnimation%, %ConfigFile%, Config, EnhancedAnimation
	IniWrite, %EnhancedSpeed%, %ConfigFile%, Config, EnhancedSpeed
	IniWrite, %Extend%, %ConfigFile%, Config, Extend
	IniWrite, %TeleportValue%, %ConfigFile%, Config, TeleportValue
	IniWrite, %EyeHackDelay%, %ConfigFile%, Config, EyeHackDelay
	IniWrite, %AntiGM%, %ConfigFile%, Config, AntiGM
	IniWrite, %AutoAttack%, %ConfigFile%, Config, AutoAttack
	;Write Hotkeys
	IniWrite, %TpUpKey%, %ConfigFile%, Hotkeys, TpUpKey
	IniWrite, %TpDwnKey%, %ConfigFile%, Hotkeys, TpDwnKey
	IniWrite, %TpFwKey%, %ConfigFile%, Hotkeys, TpFwKey
	IniWrite, %TpBkKey%, %ConfigFile%, Hotkeys, TpBkKey
	IniWrite, %TpRKey%, %ConfigFile%, Hotkeys, TpRKey
	IniWrite, %TpLKey%, %ConfigFile%, Hotkeys, TpLKey
	IniWrite, %NoGravKey%, %ConfigFile%, Hotkeys, NoGravKey
	IniWrite, %GlideLockKey%, %ConfigFile%, Hotkeys, GlideLockKey
}

TrayTip, Instructions:, Open the Aion window where you want to inject the hack and wait.
loop
{
	IfWinActive, AION Client (64bit)
	{
		WinGet, aionPID, PID, A
		TrayTip,, Injected!
		break
	}
	sleep, 500
}
TrayTip, Hooked!

Aion := new _ClassMemory("ahk_pid " aionPID)

if !isObject(aion)
{
	msgbox, 48, Failed to inject!, Try running the hack as administrator.
	exitapp
}

menu, tray, tip, %ProgramName%
menu, tray, add, %ProgramName%, ExitLabel
menu, tray, disable, %ProgramName%
menu, tray, add
menu, tray, add, No Animation, NoAnimationLabel
menu, tray, add, Enhanced Animation, EnhancedAnimationLabel
menu, tray, add, AutoAttack Hack, AutoAttackLabel
menu, tray, add, Enhanced Speed, SpeedHackLabel
menu, tray, add, Extend Hack, ExtendHackLabel
menu, tray, add, Eye Hack, EyeHackLabel
menu, tray, add, Teleport Hack, TeleportLabel
menu, tray, add, No Gravity, NoGravityLabel
menu, tray, add, Glide Lock, GlideLockLabel
menu, tray, add
menu, tray, add, Target Info, TargetInfoLabel
menu, tray, add, Anti GM, AntiGMLabel
menu, tray, add, Enable Radar, EnableRadarLabel
menu, tray, add, Enable Console, EnableConsoleLabel
menu, tray, add
menu, tray, add, Settings, SettingsLabel
menu, tray, add, Hotkeys, HotkeysLabel
menu, Tray, Add , Exit, ExitLabel

;Old offsets here, replace them to get it to work with new versions.
;Pointer Scanner from cheat engine is your friend :) */

;Character entity offsets
baseAddressGame := aion.getModuleBaseAddress("Game.dll")
baseCharAddress := baseAddressGame + 0x1149DF8
OffsetNameList := ["0x70", "0x10", "0x20", "0x378", "0x46"]
OffsetAnimationList := ["0x70", "0x10", "0x20", "0x378", "0x532"]
OffsetSpeedList := ["0x70", "0x10", "0x20", "0x378", "0x80c"]
OffsetEyeList := ["0x70", "0x10", "0x20", "0x378", "0x3a9"]
OffsetXCoordList := ["0x70", "0x10", "0x20", "0x190", "0x98"]
OffsetYCoordList := ["0x70", "0x10", "0x20", "0x190", "0x9c"]
OffsetZCoordList := ["0x70", "0x10", "0x20", "0x190", "0xa0"]
OffsetNoFallList := ["0x70", "0x10", "0x20", "0x190", "0x278"]
OffsetNoGravityList := ["0x70", "0x10", "0x20", "0x378", "0xa18"]

;Target entity offsets
baseTargetOffset := 0x114A678
baseTargetAddress := baseAddressGame + baseTargetOffset
TargetNameList := [ "0x378", "0x46"]
TargetAnimationList := [ "0x378", "0x532"]
TargetSpeedList := [ "0x378", "0x80c"]
TargetHPList := [ "0x378", "0x15bc"]
TargetTotalHPList := [ "0x378", "0x15b8"]
TargetMPList := [ "0x378", "0x15c4"]
TargetTotalMPList := [ "0x378", "0x15c0"]
TargetXCoordList := ["0x190", "0x98"]
TargetYCoordList := ["0x190", "0x9c"]
TargetZCoordList := ["0x190", "0xa0"]

;Info offsets
baseOffsetAtkSpeedInfo := 0x1580A80
AtkSpeedInfoAddress := baseAddressGame + baseOffsetAtkSpeedInfo

baseOffsetSpeedInfo := 0x1580A84
SpeedInfoAddress := baseAddressGame + baseOffsetSpeedInfo

baseOffsetAutoAttack := 0x158098C
AutoAttackAddress := baseAddressGame + baseOffsetAutoAttack

baseOffsetRange := 0x1576228
RangeAddress := baseAddressGame + baseOffsetRange

baseOffsetRange2 := 0x1580988
RangeAddress2 := baseAddressGame + baseOffsetRange2


baseOffsetName := 0x1575EE4
NameAddress := baseAddressGame + baseOffsetName

baseOffsetRadar := 0x1149DF8
RadarAddress := baseAddressGame + baseOffsetRadar
OffsetRadar := ["0x2e0", "0x2b8"]

baseOffsetConsole := 0x15E7F28
ConsoleAddress := baseAddressGame + baseOffsetConsole
OffsetConsole := 0xb8

baseOffsetAntiGM := baseAddressGame + 0x1149DF8
OffsetAntiGM := 0x15c


;Main Loop
loop
{
	Name := aion.readString(NameAddress, sizeBytes := 0, encoding := "utf-16")
	if (Name = "" AND DisablerCheck <> True) {
		menu, tray, UnCheck, No Animation
		menu, tray, UnCheck, Enhanced Animation
		menu, tray, UnCheck, Enhanced Speed
		menu, tray, UnCheck, Extend Hack
		menu, tray, UnCheck, Eye Hack
		menu, tray, UnCheck, Teleport Hack
		menu, tray, UnCheck, No Gravity
		menu, tray, UnCheck, Glide Lock
		menu, tray, disable, No Animation
		menu, tray, disable, Enhanced Animation
		menu, tray, disable, AutoAttack Hack
		menu, tray, disable, Enhanced Speed
		menu, tray, disable, Extend Hack
		menu, tray, disable, Eye Hack
		menu, tray, disable, Teleport Hack
		menu, tray, disable, No Gravity
		menu, tray, disable, Glide Lock
		menu, tray, disable, Anti GM
		menu, tray, disable, Enable Radar
		menu, tray, disable, Enable Console
		NoAniEnabled := False
		EnhancedEnabled := False
		SpeedHackEnabled := False
		EyeEnabled := False
		NoGravityEnabled := False
		GravityLocked := False
		GLideLockEnabled := False
		HeightLocked := False
		TeleportEnabled := False
		AutoAttackEnabled := False
		SetTimer, NoAnimationTimer, Delete
		SetTimer, EnhancedAnimationTimer, Delete
		SetTimer, SpeedHackTimer, Delete
		SetTimer, ExtendHackTimer, Delete
		SetTimer, EyeHackTimer, Delete
		SetTimer, NoGravityTimer, Delete
		SetTimer, GlideLockTimer, Delete
		Hotkey, Up, TeleportForward, Off
		Hotkey, Down, TeleportBackward, Off
		Hotkey, Left, TeleportLeft, Off
		Hotkey, Right, TeleportRight, Off
		Hotkey, NumpadAdd, TeleportUp, Off
		Hotkey, NumpadSub, TeleportDown, Off
		DisablerCheck := True
		}
	if (Name <> "" AND DisablerCheck <> False) {
		traytip, Welcome %Name%!, Press right click to open the menu.
		menu, tray, tip, Connected to [%Name%]
		menu, tray, enable, No Animation
		menu, tray, enable, Enhanced Animation
		menu, tray, enable, AutoAttack Hack
		menu, tray, enable, Enhanced Speed
		menu, tray, enable, Extend Hack
		menu, tray, enable, Eye Hack
		menu, tray, enable, Teleport Hack
		menu, tray, enable, No Gravity
		menu, tray, enable, Glide Lock
		menu, tray, enable, Anti GM
		menu, tray, enable, Enable Radar
		menu, tray, enable, Enable Console
		WinActivate, ahk_pid %aionPID%
		DisablerCheck := False
		}
	if !FindProc(AionPID) {
		traytip, , Aion was closed, exiting!
		sleep 1000
		ExitApp
		}
sleep 100
}

FindProc(p) {
Process, Exist, % p
Return   ErrorLevel
}

;NoAnimation Function

NoAnimationLabel:
if (NoAniEnabled) {
	SetTimer, NoAnimationTimer, Off
	sleep %TimerDelay%
	NoAniEnabled := False
	AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
	AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
	if (AnimValue = NoaniValue)
		aion.write(baseCharAddress, AtkSpeed, type := "UInt", OffsetAnimationList*)
	menu, tray, UnCheck, No Animation
	traytip, , NoAnimation disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, NoAnimationTimer, %TimerDelay%, On
	SetTimer, EnhancedAnimationTimer, Off
	sleep %TimerDelay%
	NoAniEnabled := True
	EnhancedEnabled := False
	aion.write(baseCharAddress, NoaniValue, type := "UInt", OffsetAnimationList*)
	menu, tray, ToggleCheck, No Animation
	menu, tray, UnCheck, Enhanced Animation
	traytip, , NoAnimation enabled at %NoaniValue%!
	WinActivate, ahk_pid %aionPID%
}
return

NoanimationTimer:
AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
if (AnimValue = AtkSpeed)
	aion.write(baseCharAddress, NoaniValue, type := "UInt", OffsetAnimationList*)
return

;Enhanced Animation Function

EnhancedAnimationLabel:
if (EnhancedEnabled) {
	SetTimer, EnhancedAnimationTimer, Off
	sleep %TimerDelay%
	EnhancedEnabled := False
	AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
	AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
	RestoreAnim := AnimValue + EnhancedAnimation
	if (AtkSpeed = RestoreAnim)
		aion.write(baseCharAddress, RestoreAnim, type := "UInt", OffsetAnimationList*)
	menu, tray, UnCheck, Enhanced Animation
	traytip, , Enhanced Animation disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, EnhancedAnimationTimer, %TimerDelay%, On
	SetTimer, NoAnimationTimer, Off
	sleep %TimerDelay%
	EnhancedEnabled := True
	NoAniEnabled := False
	menu, tray, ToggleCheck, Enhanced Animation
	menu, tray, UnCheck, No Animation
	traytip, , Enhanced Animation enabled at %EnhancedAnimation%!
	AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
	AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
	if (AnimValue = NoaniValue)
		aion.write(baseCharAddress, AtkSpeed, type := "UInt", OffsetAnimationList*)
	menu, tray, UnCheck, No Animation
	traytip, , Enhanced Animation enabled at %EnhancedAnimation%!
	WinActivate, ahk_pid %aionPID%
}
return

EnhancedAnimationTimer:
AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
AtkSpeedInfo := aion.read(AtkSpeedInfoAddress, type := "UInt")
if (AnimValue = AtkSpeedInfo) {
	AnimValueEnhanced := AtkSpeedInfo - EnhancedAnimation
	aion.write(baseCharAddress, AnimValueEnhanced, type := "UInt", OffsetAnimationList*)
}
return

;AutoAttack Function

AutoAttackLabel:
if (AutoAttackEnabled) {
	SetTimer, AutoAttackTimer, Off
	sleep %TimerDelay%
	AutoAttackEnabled := False
	AutoAttackValue := aion.read(AutoAttackAddress, type := "UShort")
	AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
	RestoreAutoAttack := AutoAttackValue + AutoAttack
	if (AtkSpeed = RestoreAutoAttack)
		aion.write(AutoAttackAddress, RestoreAutoAttack, type := "UShort")
	menu, tray, UnCheck, AutoAttack Hack
	traytip, , AutoAttack Hack disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, AutoAttackTimer, %TimerDelay%, On
	sleep %TimerDelay%
	AutoAttackEnabled := True
	menu, tray, ToggleCheck, AutoAttack Hack
	traytip, , AutoAttack Hack enabled at %AutoAttack%!
	AutoAttackValue := aion.read(AutoAttackAddress, type := "UShort")
	AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
	traytip, , AutoAttack Hack enabled at %AutoAttack%!
	WinActivate, ahk_pid %aionPID%
}
return

AutoAttackTimer:
AutoAttackValue := aion.read(AutoAttackAddress, type := "UShort")
AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
if (AutoAttackValue = AtkSpeed) {
	AutoAttackEnhanced := AtkSpeed - AutoAttack
	aion.write(AutoAttackAddress, AutoAttackEnhanced, type := "UShort")
}
return

;Speed Hack Function

SpeedHackLabel:
if (SpeedHackEnabled) {
	SetTimer, SpeedHackTimer, Off
	sleep %TimerDelay%
	SpeedHackEnabled := False
	SpeedValue := aion.read(baseCharAddress, type := "Float", OffsetSpeedList*)
	SpeedInfo := aion.read(SpeedInfoAddress, type := "Float")
	RestoreSpeed := SpeedValue - EnhancedSpeed
	if (SpeedInfo = RestoreSpeed)
		aion.write(baseCharAddress, RestoreSpeed, type := "Float", OffsetSpeedList*)
	menu, tray, UnCheck, Enhanced Speed
	traytip, , Enhanced Speed disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, SpeedHackTimer, %TimerDelay%, On
	SpeedHackEnabled := True
	menu, tray, Check, Enhanced Speed
	traytip, , Enhanced Speed enabled at %EnhancedSpeed%!
	WinActivate, ahk_pid %aionPID%
}
return

SpeedHackTimer:
SpeedValue := aion.read(baseCharAddress, type := "Float", OffsetSpeedList*)
SpeedInfo := aion.read(SpeedInfoAddress, type := "Float")
if (SpeedValue = SpeedInfo) {
	SpeedValueEnhanced := SpeedInfo + EnhancedSpeed
	aion.write(baseCharAddress, SpeedValueEnhanced, type := "Float", OffsetSpeedList*)
}
return

;Eye Hack Function

EyeHackLabel:
if (EyeEnabled) {
	SetTimer, EyeHackTimer, Off
	sleep %EyeHackDelay%
	EyeEnabled := False
	CheckEye := aion.read(baseCharAddress, type := "UInt", OffsetEyeList*)
	if (CheckEye = 3)
		aion.write(baseCharAddress, "0", type := "UInt", OffsetEyeList*)
	menu, tray, UnCheck, Eye Hack
	traytip, , Eye Hack disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, EyeHackTimer, %EyeHackDelay%, On
	EyeEnabled := True
	menu, tray, ToggleCheck, Eye Hack
	traytip, , Eye Hack enabled!
	WinActivate, ahk_pid %aionPID%
}
return

EyeHackTimer:
CheckEye := aion.read(baseCharAddress, type := "UInt", OffsetEyeList*)
if (CheckEye = 0 OR CheckEye = 3) {
	if (Blink) {
		aion.write(baseCharAddress, "0", type := "UInt", OffsetEyeList*)
		Blink := False
	}
	else {
		aion.write(baseCharAddress, EyeValue, type := "UInt", OffsetEyeList*)
		Blink := True
	}
}
return


;Extend Hack Function

ExtendHackLabel:
if (ExtendHackEnabled) {
	SetTimer, ExtendHackTimer, Off
	sleep %TimerDelay%
	ExtendHackEnabled := False
	RangeValue := aion.read(RangeAddress, type := "Float")
	OriginalRange := RangeValue - Extend
	aion.write(RangeAddress, OriginalRange, type := "Float")
	aion.write(RangeAddress2, OriginalRange, type := "Float")
	menu, tray, UnCheck, Extend Hack
	traytip, , Extend Hack disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	SetTimer, ExtendHackTimer, %TimerDelay%, On
	ExtendHackEnabled := True
	menu, tray, Check, Extend Hack
	traytip, , Extend Hack enabled at %Extend% meters!
	WinActivate, ahk_pid %aionPID%
}
return

ExtendHackTimer:
RangeValue := aion.read(RangeAddress, type := "Float")
if (RangeValue <> RangeValueExtend) {
	RangeValueExtend := RangeValue + Extend
	aion.write(RangeAddress, RangeValueExtend, type := "Float")
	aion.write(RangeAddress2, RangeValueExtend, type := "Float")
}
return

;Teleport Functions

TeleportLabel:
if (TeleportEnabled) {
	TeleportEnabled := False
	Hotkey, %TpFwKey%, TeleportForward, Off
	Hotkey, %TpBkKey%, TeleportBackward, Off
	Hotkey, %TpLKey%, TeleportLeft, Off
	Hotkey, %TpRKey%, TeleportRight, Off
	Hotkey, %TpUpKey%, TeleportUp, Off
	Hotkey, %TpDwnKey%, TeleportDown, Off
	menu, tray, UnCheck, Teleport Hack
	traytip, , Teleport Hack disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	TeleportEnabled := True
	Hotkey, %TpFwKey%, TeleportForward, On
	Hotkey, %TpBkKey%, TeleportBackward, On
	Hotkey, %TpLKey%, TeleportLeft, On
	Hotkey, %TpRKey%, TeleportRight, On
	Hotkey, %TpUpKey%, TeleportUp, On
	Hotkey, %TpDwnKey%, TeleportDown, On
	menu, tray, ToggleCheck, Teleport Hack
	traytip, , Teleport Hack enabled!
	WinActivate, ahk_pid %aionPID%
}
return

TeleportForward:
YCoordValue := aion.read(baseCharAddress, type := "Float", OffsetYCoordList*)
YCoordValue := YCoordValue - TeleportValue
aion.write(baseCharAddress, YCoordValue, type := "Float", OffsetYCoordList*)
return

TeleportBackward:
YCoordValue := aion.read(baseCharAddress, type := "Float", OffsetYCoordList*)
YCoordValue := YCoordValue + TeleportValue
aion.write(baseCharAddress, YCoordValue, type := "Float", OffsetYCoordList*)
return

TeleportLeft:
XCoordValue := aion.read(baseCharAddress, type := "Float", OffsetXCoordList*)
XCoordValue := XCoordValue - TeleportValue
aion.write(baseCharAddress, XCoordValue, type := "Float", OffsetXCoordList*)
return

TeleportRight:
XCoordValue := aion.read(baseCharAddress, type := "Float", OffsetXCoordList*)
XCoordValue := XCoordValue + TeleportValue
aion.write(baseCharAddress, XCoordValue, type := "Float", OffsetXCoordList*)
return

TeleportUp:
ZCoordValue := aion.read(baseCharAddress, type := "Float", OffsetZCoordList*)
ZCoordValue := ZCoordValue + TeleportValue
aion.write(baseCharAddress, ZCoordValue, type := "Float", OffsetZCoordList*)
return

TeleportDown:
ZCoordValue := aion.read(baseCharAddress, type := "Float", OffsetZCoordList*)
ZCoordValue := ZCoordValue - TeleportValue
aion.write(baseCharAddress, ZCoordValue, type := "Float", OffsetZCoordList*)
return

;Glide Lock Function

GLideLockLabel:
if (GLideLockEnabled) {
	GLideLockEnabled := False
	HeightLocked := False
	SetTimer, GlideLockTimer, Off
	sleep %TimerDelay%
	Hotkey, %GlideLockKey%, GlideLockHotkey, Off
	menu, tray, UnCheck, Glide Lock
	traytip, , Glide Lock disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	GLideLockEnabled := True
	Hotkey, %GlideLockKey%, GlideLockHotkey, On
	menu, tray, ToggleCheck, Glide Lock
	traytip, , Glide Lock enabled! Press %GlideLockKey% to lock!
	WinActivate, ahk_pid %aionPID%
}
return

GlideLockHotkey:
If (HeightLocked) {
	HeightLocked := False
	SetTimer, GlideLockTimer, Off
	traytip, , Height unlocked!
}
else {
	HeightLocked := True
	ZCoordValue := aion.read(baseCharAddress, type := "Float", OffsetZCoordList*)
	SetTimer, GlideLockTimer, 10, On
	traytip, , Height locked!
}
return

GlideLockTimer:
GlideStatus := aion.read(baseCharAddress, type := "UInt", OffsetNoGravityList*)
if (GlideStatus = "7" AND GravityLocked <> True)
	aion.write(baseCharAddress, ZCoordValue, type := "Float", OffsetZCoordList*)
else
	ZCoordValue := aion.read(baseCharAddress, type := "Float", OffsetZCoordList*)
return



;No Gravity Functions

NoGravityLabel:
if (NoGravityEnabled) {
	NoGravityEnabled := False
	GravityLocked := False
	Hotkey, %NoGravKey%, NoGravityHotkey, Off
	SetTimer, NoGravityTimer, Off
	sleep %TimerDelay%
	aion.write(baseCharAddress, "0", type := "UInt", OffsetNoGravityList*)
	aion.write(baseCharAddress, "1", type := "UInt", OffsetNoFallList*)
	menu, tray, UnCheck, No Gravity
	traytip, , No Gravity disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	NoGravityEnabled := True
	Hotkey, %NoGravKey%, NoGravityHotkey, On
	menu, tray, ToggleCheck, No Gravity
	traytip, , No Gravity enabled! Press %NoGravKey% to lock!
	WinActivate, ahk_pid %aionPID%
}
return

NoGravityHotkey:
If (GravityLocked) {
	GravityLocked := False
	SetTimer, NoGravityTimer, Off
	sleep %TimerDelay%
	aion.write(baseCharAddress, "0", type := "UInt", OffsetNoGravityList*)
	aion.write(baseCharAddress, "1", type := "UInt", OffsetNoFallList*)
	traytip, , Gravity unlocked!
}
else {
	GravityLocked := True
	SetTimer, NoGravityTimer, %TimerDelay%, On
	traytip, , Gravity locked!
}
return

NoGravityTimer:
aion.write(baseCharAddress, "5", type := "UInt", OffsetNoGravityList*)
aion.write(baseCharAddress, "0", type := "UInt", OffsetNoFallList*)
return

AntiGMLabel:
if (AntiGMDisabled) {
	AntiGMDisabled := False
	SetTimer, AntiGMTimer, Off
	menu, tray, UnCheck, Anti GM
	traytip, , Anti GM disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	AntiGMDisabled := True
	SetTimer, AntiGMTimer, %TimerDelay%, On
	menu, tray, ToggleCheck, Anti GM
	traytip, , Anti GM enabled!
	WinActivate, ahk_pid %aionPID%
}
return

AntiGMTimer:
playersOnline := aion.read(baseOffsetAntiGM, type := "UInt", OffsetAntiGM)
if (playersOnline > AntiGM) {
	Process, Close, %aionPID%
	ExitApp
}
return	

;Console Toggle

EnableConsoleLabel:
if (ConsoleDisabled) {
	ConsoleDisabled := False
	aion.write(ConsoleAddress, "1", type := "UInt", OffsetConsole)
	menu, tray, UnCheck, Enable Console
	traytip, , Console disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	ConsoleDisabled := True
	aion.write(ConsoleAddress, "0", type := "UInt", OffsetConsole)
	menu, tray, ToggleCheck, Enable Console
	traytip, , Console enabled! Press pause key to show it!
	WinActivate, ahk_pid %aionPID%
}
return

;Radar Toggle

EnableRadarLabel:
if (RadarDisabled) {
	RadarDisabled := False
	aion.write(RadarAddress, "0", type := "UInt", OffsetRadar*)
	menu, tray, UnCheck, Enable Radar
	traytip, , Radar disabled!
	WinActivate, ahk_pid %aionPID%
}
else {
	RadarDisabled := True
	aion.write(RadarAddress, "5", type := "UInt", OffsetRadar*)
	menu, tray, ToggleCheck, Enable Radar
	traytip, , Radar enabled!
	WinActivate, ahk_pid %aionPID%
}
return

TargetInfoLabel:
If (TargetEnabled) {
	TargetEnabled := False
	SetTimer, TargetTimer, Off
	sleep %TimerDelay%
	menu, tray, UnCheck, Target Info
	traytip, , Target Info Disabled!
}
else {
	TargetEnabled := True
	SetTimer, TargetTimer, %TimerDelay%, On
	menu, tray, ToggleCheck, Target Info
	traytip, , Target Info Enabled!
}
return

TargetTimer:
;Get Values
IfWinActive, AION Client (64bit)
{
	TargetName := aion.readString(baseTargetAddress, sizeBytes := 0, encoding := "utf-16", TargetNameList*)
	TargetAnimation := aion.read(baseTargetAddress, type := "UInt", TargetAnimationList*)
	TargetSpeed := aion.read(baseTargetAddress, type := "Float", TargetSpeedList*)
	TargetHP := aion.read(baseTargetAddress, type := "UInt", TargetHPList*)
	TargetMP := aion.read(baseTargetAddress, type := "UInt", TargetMPList*)
	TargetTotalHP := aion.read(baseTargetAddress, type := "UInt", TargetTotalHPList*)
	TargetTotalMP := aion.read(baseTargetAddress, type := "UInt", TargetTotalMPList*)
	TargetXCoord := aion.read(baseTargetAddress, type := "Float", TargetXCoordList*)
	TargetYCoord := aion.read(baseTargetAddress, type := "Float", TargetYCoordList*)
	TargetZCoord := aion.read(baseTargetAddress, type := "Float", TargetZCoordList*)
	if (TargetName) {
		ToolTip, Name: %TargetName% `nAtkSpeed: %TargetAnimation% `nSpeed: %TargetSpeed%`nHP: %TargetHP%`\%TargetTotalHP%`nMP: %TargetMP%`\%TargetTotalMP%`nX: %TargetXCoord%`nY: %TargetYCoord%`nZ: %TargetZCoord%, 200, 50
	} else {
		ToolTip
	}
} else {
	ToolTip
}
return

;Hotkeys Window

HotkeysLabel:
Gui, Add, Hotkey, x5 vTpUpKeyNew, %TpUpKey%
Gui, Add, text, x+5, Teleport Up

Gui, Add, Hotkey, x5 vTpDwnKeyNew, %TpDwnKey%
Gui, Add, text, x+5, Teleport Down

Gui, Add, Hotkey, x5 vTpFwKeyNew, %TpFwKey%
Gui, Add, text, x+5, Teleport Forward

Gui, Add, Hotkey, x5 vTpBkKeyNew, %TpBkKey%
Gui, Add, text, x+5, Teleport Backwards

Gui, Add, Hotkey, x5 vTpRKeyNew, %TpRKey%
Gui, Add, text, x+5, Teleport Right

Gui, Add, Hotkey, x5 vTpLKeyNew, %TpLKey%
Gui, Add, text, x+5, Teleport Left

Gui, Add, Hotkey, x5 vNoGravKeyNew, %NoGravKey%
Gui, Add, text, x+5, No Gravity

Gui, Add, Hotkey, x5 vGlideLockKeyNew, %GlideLockKey%
Gui, Add, text, x+5, Glide Lock

gui, add, button, x5 Default, Save Hotkeys
Gui, Show,,Hotkeys
menu, tray, disable, Hotkeys
return

;Save hotkeys button
ButtonSaveHotkeys:
Gui, Submit

If (TpUpKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpUpKey%, TeleportUp, Off
		Hotkey, %TpUpKeyNew%, TeleportUp, On
	}
	TpUpKey := TpUpKeyNew
	IniWrite, %TpUpKey%, %ConfigFile%, Hotkeys, TpUpKey
}
TpUpKeyNew := ""	

If (TpDwnKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpDwnKey%, TeleportDown, Off
		Hotkey, %TpDwnKeyNew%, TeleportDown, On
	}
	TpDwnKey := TpDwnKeyNew
	IniWrite, %TpDwnKey%, %ConfigFile%, Hotkeys, TpDwnKey
}	
TpDwnKeyNew := ""

If (TpFwKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpFwKey%, TeleportForward, Off
		Hotkey, %TpFwKeyNew%, TeleportForward, On
	}
	TpFwKey := TpFwKeyNew
	IniWrite, %TpFwKey%, %ConfigFile%, Hotkeys, TpFwKey
}	
TpFwKeyNew := ""

If (TpBkKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpBkKey%, TeleportBackward, Off
		Hotkey, %TpBkKeyNew%, TeleportBackward, On
	}
	TpBkKey := TpBkKeyNew
	IniWrite, %TpBkKey%, %ConfigFile%, Hotkeys, TpBkKey
}	
TpBkKeyNew := ""

If (TpRKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpRKey%, TeleportRight, Off
		Hotkey, %TpRKeyNew%, TeleportRight, On
	}
	TpRKey := TpRKeyNew
	IniWrite, %TpRKey%, %ConfigFile%, Hotkeys, TpRKey
}	
TpRKeyNew := ""

If (TpLKeyNew) {
	if (TeleportEnabled) {
		Hotkey, %TpLKey%, TeleportLeft, Off
		Hotkey, %TpLKeyNew%, TeleportLeft, On
	}
	TpLKey := TpLKeyNew
	IniWrite, %TpLKey%, %ConfigFile%, Hotkeys, TpLKey
}
TpLKeyNew := ""
	
If (NoGravKeyNew) {
	if (NoGravityEnabled) {
		Hotkey, %NoGravKey%, NoGravityHotkey, Off
		Hotkey, %NoGravKeyNew%, NoGravityHotkey, On
	}
	NoGravKey := NoGravKeyNew
	IniWrite, %NoGravKey%, %ConfigFile%, Hotkeys, NoGravKey
}	
NoGravKeyNew := ""

If (GlideLockKeyNew) {
	if (GlideLockEnabled) {
		Hotkey, %GlideLockKey%, GlideLockHotkey, Off
		Hotkey, %GlideLockKeyNew%, GlideLockHotkey, On
	}
	GlideLockKey := GlideLockKeyNew
	IniWrite, %GlideLockKey%, %ConfigFile%, Hotkeys, GlideLockKey
}
GlideLockKeyNew := ""

Gui, Destroy
menu, tray, enable, Hotkeys
traytip, , Hotkeys saved!
return

;Config window
	
SettingsLabel:
gui, add, text, , NoAnimation Value: (default 1):
gui, add, edit, w50 r1 vNoaniValueNew, %NoaniValue%

gui, add, text, , Enhanced Animation Value: (default 250):
gui, add, edit, w50 r1 vEnhancedAnimationNew, %EnhancedAnimation%

gui, add, text, , AutoAttack Hack Value: (default 250):
gui, add, edit, w50 r1 vAutoAttackNew, %AutoAttack%

gui, add, text, , Enhanced Speed Value: (default 0.2):
gui, add, edit, w50 r1 vEnhancedSpeedNew, %EnhancedSpeed%

gui, add, text, , Extend Hack Value: (default 1.9):
gui, add, edit, w50 r1 vExtendNew, %Extend%

gui, add, text, , Teleport Value: (default 1):
gui, add, edit, w50 r1 vTeleportValueNew, %TeleportValue%

gui, add, text, , EyeHackDelay: (default 250):
gui, add, edit, w50 r1 vEyeHackDelayNew, %EyeHackDelay%

gui, add, text, , AntiGM players allowed: (default 1):
gui, add, edit, w50 r1 vAntiGMNew, %AntiGM%

gui, add, button, Default, Save Settings
gui, show,,Settings
menu, tray, disable, Settings
return

GuiClose:
gui, destroy
menu, tray, enable, Settings
menu, tray, enable, Hotkeys
return

;Save config button

ButtonSaveSettings:
Gui, Submit

;Write New Values to memory
if (NoaniValueNew <= 5000 AND NoaniValueNew >= 1) {
	if (NoaniValueNew <> NoaniValue) {
		AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
		if (NoAniEnabled AND AnimValue = NoaniValue)
			aion.write(baseCharAddress, NoaniValueNew, type := "UInt", OffsetAnimationList*)
	}
}
else {
	Msgbox, %NoaniValueNew% is not a valid value. Please type a value between 1 and 5000
	gui, destroy
	goto SettingsLabel
}

if (EnhancedAnimationNew <= 1000 AND EnhancedAnimationNew >= 1) {
	if (EnhancedAnimationNew <> EnhancedAnimation) {
		AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
		AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
		RestoreAnim := AnimValue + EnhancedAnimation
		NewAnim := AtkSpeed - EnhancedAnimationNew
		if (EnhancedEnabled AND AtkSpeed = RestoreAnim)
			aion.write(baseCharAddress, NewAnim, type := "UInt", OffsetAnimationList*)
	}
}
else {
	Msgbox, %EnhancedAnimationNew% is not a valid value. Please type a value between 1 and 1000
	gui, destroy
	goto SettingsLabel
}

if (AutoAttackNew <= 1000 AND AutoAttackNew >= 1) {
	if (AutoAttackNew <> AutoAttack) {
		AutoAttackValue := aion.read(AutoAttackAddress, type := "UShort")
		AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
		RestoreAutoAttack := AutoAttackValue + AutoAttack
		NewValue := AtkSpeed - AutoAttackNew
		if (AtkSpeedEnabled AND AtkSpeed = RestoreAutoAttack)
			aion.write(AutoAttackAddress, NewValue, type := "UShort")
	}
}
else {
	Msgbox, %AutoAttackNew% is not a valid value. Please type a value between 1 and 1000
	gui, destroy
	goto SettingsLabel
}

if (EnhancedSpeedNew <= 9) {
	if (EnhancedSpeedNew <> EnhancedSpeed) {
		SpeedValue := aion.read(baseCharAddress, type := "Float", OffsetSpeedList*)
		SpeedInfo := aion.read(SpeedInfoAddress, type := "Float")
		RestoreSpeed := SpeedValue - EnhancedSpeed
		NewSpeed := SpeedInfo + EnhancedSpeedNew
		if (SpeedHackEnabled AND SpeedInfo = RestoreSpeed)
			aion.write(baseCharAddress, NewSpeed, type := "Float", OffsetSpeedList*)
	}
}
else {
	Msgbox, %EnhancedSpeedNew% is not a valid value. Please type a value between 0 and 9
	gui, destroy
	goto SettingsLabel
}

if (ExtendNew <= 2) {
	if (ExtendHackEnabled AND ExtendNew <> Extend) {
		RangeValue := aion.read(RangeAddress, type := "Float")
		RangeValueExtend := RangeValue - Extend + ExtendNew
		aion.write(RangeAddress, RangeValueExtend, type := "Float")
		aion.write(RangeAddress2, RangeValueExtend, type := "Float")
	}
}
else {
	Msgbox, %ExtendNew% is not a valid value. Please type a value between 0 and 2
	gui, destroy
	goto SettingsLabel
}

if not (TeleportValueNew <= 10 AND TeleportValueNew >= 0.1) {
	msgbox, %TeleportValueNew% is not a valid value. Please type a value between 0.1 and 10
	gui, destroy
	goto SettingsLabel
}

if not (EyeHackDelayNew <= 250 AND EyeHackDelayNew >= 50) {
	msgbox, %EyeHackDelayNew% is not a valid value. Please type a value between 50 and 250
	gui, destroy
	goto SettingsLabel
}

if not (IsNum(AntiGMNew)) {
	msgbox, Input a number please!
	gui, destroy
	goto SettingsLabel
}

IsNum(str) {
	if str is number
		return true
	return false
}

EyeHackDelay := EyeHackDelayNew
NoaniValue := NoaniValueNew
EnhancedAnimation := EnhancedAnimationNew
EnhancedSpeed := EnhancedSpeedNew
Extend := ExtendNew
TeleportValue := TeleportValueNew
AntiGM := AntiGMNew
AutoAttack := AutoAttackNew

IniWrite, %NoaniValue%, %ConfigFile%, Config, NoaniValue
IniWrite, %EnhancedAnimation%, %ConfigFile%, Config, EnhancedAnimation
IniWrite, %EnhancedSpeed%, %ConfigFile%, Config, EnhancedSpeed
IniWrite, %ExtendNew%, %ConfigFile%, Config, Extend
IniWrite, %TeleportValueNew%, %ConfigFile%, Config, TeleportValue
IniWrite, %EyeHackDelayNew%, %ConfigFile%, Config, EyeHackDelay
IniWrite, %AntiGMNew%, %ConfigFIle%, Config, AntiGM
IniWrite, %AutoAttackNew%, %ConfigFIle%, Config, AutoAttack
Gui, Destroy
menu, tray, enable, Settings
traytip, , Settings saved!
WinActivate, ahk_pid %aionPID%
return

;Exit label
ExitLabel:
SetTimer, NoAnimationTimer, Delete
SetTimer, EnhancedAnimationTimer, Delete
SetTimer, SpeedHackTimer, Delete
SetTimer, ExtendHackTimer, Delete
SetTimer, EyeHackTimer, Delete
SetTimer, NoGravityTimer, Delete
SetTimer, GlideLockTimer, Delete
SetTimer, AutoAttackTimer, Delete

;Disable Noanim
AnimValue := aion.read(baseCharAddress, type := "UInt", OffsetAnimationList*)
AtkSpeed := aion.read(AtkSpeedInfoAddress, type := "UInt")
if (AnimValue = NoaniValue)
	aion.write(baseCharAddress, AtkSpeed, type := "UInt", OffsetAnimationList*)

;Disable Enhanced
RestoreAnim := AnimValue + EnhancedAnimation
if (AtkSpeed = RestoreAnim)
	aion.write(baseCharAddress, RestoreAnim, type := "UInt", OffsetAnimationList*)

;Disable AutoAttack
AutoAttackValue := aion.read(AutoAttackAddress, type := "UShort")
RestoreAutoAttack := AutoAttackValue + AutoAttack
if (AtkSpeed = RestoreAutoAttack)
	aion.write(AutoAttackAddress, RestoreAutoAttack, type := "UShort")

;Disable SpeedHack
SpeedValue := aion.read(baseCharAddress, type := "Float", OffsetSpeedList*)
SpeedInfo := aion.read(SpeedInfoAddress, type := "Float")
RestoreSpeed := SpeedValue - EnhancedSpeed
if (SpeedInfo = RestoreSpeed)
	aion.write(baseCharAddress, RestoreSpeed, type := "Float", OffsetSpeedList*)

;Disable Extend
if (ExtendHackEnabled) {
	RangeValue := aion.read(RangeAddress, type := "Float")
	OriginalRange := RangeValue - Extend
	aion.write(RangeAddress, OriginalRange, type := "Float")
	aion.write(RangeAddress2, OriginalRange, type := "Float")
}

;Disable NoGravity
aion.write(baseCharAddress, "0", type := "UInt", OffsetNoGravityList*)
aion.write(baseCharAddress, "1", type := "UInt", OffsetNoFallList*)

;Exit
ExitApp
