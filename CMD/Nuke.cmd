@Echo Off

Rem This will execute all ps1 files located in the same directory,
Rem usefull for letting people execute ps1s without configuring anything.
Rem Warning, can be extremely dangerous.

For /F "TOKENS=*" %%A In ('Dir /b *.ps1') Do Start "" "PowerShell" -ExecutionPolicy Bypass -NoProfile -File "%%~A"
