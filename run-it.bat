@echo off
start "" powershell -WindowStyle Hidden -Command "Get-Content 'domains.txt' | ForEach-Object { Start-Process curl -ArgumentList '-s -o nul -IL ' + $_ -WindowStyle Hidden }"
exit
