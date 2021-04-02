REM This will execute the first ps1 file located in the same directory,
REM usefull for letting people execute ps1s without configuring anything.
REM So named because while it can be extremely useful, it can also be extremely dangerous.
REM I thought about making it execute every ps1, but that could get very dangerous very fast.

@ECHO OFF
PowerShell -ExecutionPolicy Bypass -NoProfile -Command "& {Start-Process -FilePath (Get-ChildItem -Filter *.ps1)[0].FullName}"
