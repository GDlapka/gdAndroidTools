@echo off
if "%1" EQU "" goto error
set devnum=%1
set TARGET_DEVICE=0
if %devnum% EQU 51 set TARGET_DEVICE=J1AXGV780891R26
if %devnum% EQU 52 set TARGET_DEVICE=9LNVLVFY99999999
if %devnum% EQU 53 set TARGET_DEVICE=GAAXHM010196NZZ
if %TARGET_DEVICE% EQU 0 goto error
echo Restarting device #%devnum% %TARGET_DEVICE%
c:\tools\adb -s %TARGET_DEVICE% reboot
if %devnum% EQU 53 timeout /t 95
if %devnum% NEQ 53 timeout /t 75
tasklist /v /fi "IMAGENAME eq cmd.exe"|findstr "titanbotlauncher" >Nul || (
start "titanbotlauncher" C:\tools\launcher.bat %TARGET_DEVICE%
timeout /t 8
)
for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq cmd.exe"') do (echo:%%C|findstr "titanbotlauncher" >Nul && set "pid=%%B")
taskkill /PID %pid%
goto theend
:error
echo Wrong parametr
:theend
Exit /B