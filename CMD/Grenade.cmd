@Echo Off
Rem This will execute only one ps1 file located in the same directory,
Rem usefull for letting people execute ps1s without configuring anything.
Rem So named because while it can be extremely useful, it can also be extremely dangerous.
Rem I thought about making it execute every ps1, but that could get very dangerous very fast.

For /f %%i In ('Dir *.ps1 /b') Do Set Var=%%i
PowerShell -ExecutionPolicy Bypass -NoProfile -File ""%Var%""
