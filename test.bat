for /F "tokens=1,2* delims= " %%A in ('tasklist /v /fi "IMAGENAME eq putty.exe"') do (set "pid=%%B");
taskkill /F /PID %pid%