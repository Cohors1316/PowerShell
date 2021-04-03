@ECHO OFF

REM This will execute the first ps1 file located in the same directory as this file,
REM usefull for letting people execute ps1s without configuring anything.
REM So named because while it can be extremely useful, it can also be extremely dangerous.
REM I thought about making it execute every ps1, but that could get very dangerous very fast.

For /f %%i in ('Dir /b *.ps1') Do Set VAR=%%i

PowerShell -ExecutionPolicy Bypass -NoProfile -File %VAR%
