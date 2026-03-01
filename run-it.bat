@echo off
set "file=domains.txt"

for /f "usebackq delims=" %%a in ("%file%") do (
    curl -IL %%a
)

pause
