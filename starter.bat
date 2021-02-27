@echo off
set START_NAME=launcher
if "%1" EQU "" goto error
if "%2" NEQ "" set START_NAME=%2
set devnum=%1
set TARGET_DEVICE=0
rem if %devnum% EQU 51 set TARGET_DEVICE=J1AXGV780891R26
rem if %devnum% NEQ 51 set TARGET_DEVICE=192.168.254.%devnum%:5555
set TARGET_DEVICE=192.168.254.%devnum%:5555
if %TARGET_DEVICE% EQU 0 goto error

tasklist /v /fi "IMAGENAME eq cmd.exe"|findstr "titanbotlauncher" >Nul || (
start "titanbotlauncher" C:\tools\%START_NAME%.bat %TARGET_DEVICE%
timeout /t 30
)
for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq cmd.exe"') do (echo:%%C|findstr "titanbotlauncher" >Nul && set "pid=%%B")
taskkill /PID %pid%

goto theend
:error
echo Wrong parametr
echo Usage: starter.bat 50 launch
echo Usage: starter.bat 50 killer
echo Usage: starter.bat 50 relaunch
echo Usage: starter.bat 50 closer
echo Usage: starter.bat 50 keyhome
goto theend
:error2
echo Error. Device isn't respond.
goto theend
:theend
Exit /B
