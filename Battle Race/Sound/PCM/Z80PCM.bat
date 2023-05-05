@echo off
IF EXIST Z80PCM.bin DEL Z80PCM.bin
AS\asl.exe -q -cpu Z80 -gnuerrors -c -A -xx Z80PCM.asm
AS\p2bin Z80PCM.p Z80PCM.bin -r 0x-0x
IF NOT EXIST Z80PCM.p goto Error
CLS
DEL Z80PCM.p
DEL Z80PCM.h

if "%1"=="1" goto End

:Error
pause

:End