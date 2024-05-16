@echo off
setlocal

REM Define the target backup registry key
set "sourceKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Setup"

REM Define the destination folder for backup
set "destinationFolder=<\\path\to\cmbackup"

REM Create the destination folder if it doesn't exist
if not exist "%destinationFolder%" mkdir "%destinationFolder%"

REM Export setupreg key to a .reg file in the destination folder
reg export "%sourceKey%" "%destinationFolder%\Setup_Backup.reg" /y