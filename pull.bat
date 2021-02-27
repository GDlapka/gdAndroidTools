@echo off
if "%1" EQU "" goto error
set devnum=%1
set TARGET_DEVICE=0
set TARGET_DEVICE=192.168.254.%devnum%:5555
if %TARGET_DEVICE% EQU 0 goto error
@echo on

c:\tools\adb -s %TARGET_DEVICE% pull /sdcard/scripts C:\tools

goto theend
:error
echo Wrong parametr
echo USAGE: push.bat 50
:theend
Exit /B