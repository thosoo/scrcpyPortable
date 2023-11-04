@echo off`r`n.\win64\scrcpy-win64-v2.2\\scrcpy.exe %* && .\win64\scrcpy-win64-v2.2\\adb kill-server
:: if the exit code is >= 1, then pause`r`nif errorlevel 1 pause`r`n
