@echo off
.\win64\scrcpy-win64-v1.25\scrcpy.exe %* && .\win64\scrcpy-win64-v1.25\adb kill-server
:: if the exit code is >= 1, then pause
if errorlevel 1 pause
