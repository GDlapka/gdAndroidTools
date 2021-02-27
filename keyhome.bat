@echo off
if "%1" EQU "" goto error
set TARGET_DEVICE=%1

c:\tools\adb.exe kill-server
timeout /t 1

tasklist /v /fi "IMAGENAME eq cmd.exe"|findstr "adbconnector" >Nul || (
start "adbconnector" C:\tools\reconnectIP.bat %TARGET_DEVICE%
timeout /t 15
)
for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq cmd.exe"') do (echo:%%C|findstr "adbconnector" >Nul && set "pid=%%B")
taskkill /PID %pid%

(
	echo input keyevent 3
) | c:\tools\adb.exe -s %TARGET_DEVICE% shell
goto theend
:error
echo Wrong parametr
:theend
Exit /B