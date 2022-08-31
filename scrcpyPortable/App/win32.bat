@echo off
.\win32\scrcpy.exe %* && .\win32\adb kill-server
:: if the exit code is >= 1, then pause
if errorlevel 1 pause
