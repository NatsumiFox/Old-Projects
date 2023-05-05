@Echo Off
Asm68k.exe /q /p "Layouts.asm", "Layouts.bin"

if "%1"=="1" goto End
pause

:End