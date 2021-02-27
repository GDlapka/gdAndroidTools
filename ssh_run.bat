@echo off
if "%1" EQU "" goto error
set /A devnum=%1% +100
set TARGET_DEVICE=0
rem if %devnum% EQU 51 set TARGET_DEVICE=J1AXGV780891R26
rem if %devnum% NEQ 51 set TARGET_DEVICE=192.168.254.%devnum%:5555
set TARGET_DEVICE=192.168.254.%devnum%:22
if %TARGET_DEVICE% EQU 0 goto error

tasklist /v /fi "IMAGENAME eq putty.exe"|findstr "putty_ssh_sbreload" >Nul || (
start "putty_ssh_sbreload" "D:\PR\Putty\putty.exe" -ssh %TARGET_DEVICE% -l root -pw alpine -m c:\tools\sbreload.sh
timeout /t 20
)
for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq putty.exe"') do (set "pid=%%B");
taskkill /F /PID %pid%

goto theend
:error
echo Wrong parametr
goto theend
:error2
echo Error. Device isn't respond.
goto theend
:theend
Exit /B