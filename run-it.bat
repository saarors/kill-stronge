@echo off
set "file=domains.txt"

for /f "usebackq delims=" %%a in ("%file%") do (
    echo Checking %%a ...
    curl -IL %%a
    echo.
)

pause
