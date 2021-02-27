
@echo off
(
	echo cd sdcard/scripts
	echo sh unlock.sh
	echo exit
) | c:\tools\adb shell
Exit /B