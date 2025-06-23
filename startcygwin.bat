@echo off
setlocal

:: Set the path to your Cygwin installation
set "CYGWIN_PATH=C:\cygwin64"

:: Get directory of the batch file itself
set "BAT_DIR=%~dp0"

:: Remove trailing backslash if present
if "%BAT_DIR:~-1%"=="\" set "BAT_DIR=%BAT_DIR:~0,-1%"

:: Convert to Cygwin path (use temporary file to avoid locale/console parsing issues)
"%CYGWIN_PATH%\bin\cygpath.exe" "%BAT_DIR%" > "%TEMP%\cygpath_output.txt"
set /p CYGWIN_DIR=<"%TEMP%\cygpath_output.txt"
del "%TEMP%\cygpath_output.txt"

:: Start mintty in that directory
start "" "%CYGWIN_PATH%\bin\mintty.exe" -i /Cygwin-Terminal.ico /bin/bash -l -c "cd '%CYGWIN_DIR%'; exec bash"

endlocal
