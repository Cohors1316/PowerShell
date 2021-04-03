@ECHO OFF

REM This will execute all ps1 files located in the same directory,
REM usefull for letting people execute ps1s without configuring anything.
REM Warning, can be extremely dangerous.

For /F "TOKENS=*" %%A In ('Dir /b *.ps1') Do Start "" "PowerShell" -File "%%~A"
