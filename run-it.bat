@echo off
set "file=domains.txt"

for /f "usebackq delims=" %%a in ("%file%") do (
    curl -s -o nul -IL %%a
)

pause
