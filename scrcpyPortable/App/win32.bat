@echo off
.\win32\scrcpy-win32-v2.0\scrcpy.exe %* && .\win32\scrcpy-win32-v2.0\adb kill-server
:: if the exit code is >= 1, then pause
if errorlevel 1 pause
