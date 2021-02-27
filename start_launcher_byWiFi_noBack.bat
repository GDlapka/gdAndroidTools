@echo off
if "%1" EQU "" goto error
set devnum=%1
set TARGET_DEVICE=0
rem if %devnum% EQU 51 set TARGET_DEVICE=J1AXGV780891R26
rem if %devnum% NEQ 51 set TARGET_DEVICE=192.168.254.%devnum%:5555
set TARGET_DEVICE=192.168.254.%devnum%:5555
if %TARGET_DEVICE% EQU 0 goto error

tasklist /v /fi "IMAGENAME eq cmd.exe"|findstr "titanbotlauncher" >Nul || (
start "titanbotlauncher" C:\tools\launcher_byWiFi_noBack.bat %TARGET_DEVICE%
timeout /t 25
)
for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq cmd.exe"') do (echo:%%C|findstr "titanbotlauncher" >Nul && set "pid=%%B")
taskkill /PID %pid%

goto theend
:error
echo Wrong parametr
goto theend
:error2
echo Error. Device isn't respond.
goto theend
:theend
Exit /B
