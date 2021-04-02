@ECHO OFF

REM This will execute all ps1 files located in the same directory,
REM usefull for letting people execute ps1s without configuring anything.
REM Warning, can be extremely dangerous.

PowerShell -ExecutionPolicy Bypass -NoProfile -Command "& {ForEach ($File In (Get-ChildItem -Filter *.ps1)){& PowerShell -File $File.FullName -NoProfile -ExecutionPolicy Bypass -ExecutionPolicy Bypass}}"
