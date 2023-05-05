@echo off
"bin\AS\asw.exe" -q -cpu Z80 -gnuerrors -c -A -L -xx "main.asm"
"bin\ASS\p2bin.exe" "main.p" "a.sms" -r 0x-0x

IF NOT EXIST "main.p" pause | exit
DEL "main.p"
DEL "main.h"

"bin\CheckFix.exe" "a.sms"