@echo off

REM cd "Sound\Z80"
REM call _Assemble.bat 1
REM cd "..\.."

"_Assembly Tools\Asm68k.exe" /q /p "Source.asm", "Rom.bin"
"_Assembly Tools\CheckFix.exe" "Rom.bin"
"_Assembly Tools\CheckFixLong.exe" "Rom.bin" E8 74

pause







