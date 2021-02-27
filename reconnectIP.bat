@echo off
if "%1" EQU "" goto error
set devnum=%1
@echo on
c:\tools\adb.exe connect %1%
c:\tools\adb.exe devices
goto theend
:error
echo Wrong parametr
:theend
Exit /B