@echo off
.\win64\scrcpy.exe %* && .\win64\adb kill-server
:: if the exit code is >= 1, then pause
if errorlevel 1 pause
