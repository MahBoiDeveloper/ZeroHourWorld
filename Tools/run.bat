@echo off
chcp 65001 > nul
rm result.scb > nul 2> nul
rm result.json > nul 2> nul
rm source.json > nul 2> nul

scriptconverter.exe source.scb source.json
copy source.json result.json > nul
cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File patch.ps1 source.json replaces.txt"
scriptconverter.exe result.json result.scb
scriptconverter.exe --validate result.scb
