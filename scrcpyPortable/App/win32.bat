@echo off`r`n.\win64\scrcpy-win64-v2.1.1\\scrcpy.exe %* && .\win64\scrcpy-win64-v2.1.1\\adb kill-server
:: if the exit code is >= 1, then pause`r`nif errorlevel 1 pause`r`n
