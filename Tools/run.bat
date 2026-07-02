@echo off
chcp 65001 > nul
rmdir /s /q _Patched > nul 2> nul
mkdir _Patched > nul 2> nul

scriptconverter.exe source.scb _Patched\source.json
copy _Patched\source.json _Patched\result.json > nul
cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File patch.ps1 _Patched\result.json replaces.txt"
scriptconverter.exe _Patched\result.json _Patched\result.scb
scriptconverter.exe --validate _Patched\result.scb

pause