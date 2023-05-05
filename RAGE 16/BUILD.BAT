@echo off
asm68k /p MAIN.ASM, A.MD, , .LST>ERR.TXT
type ERR.TXT
IF EXIST A.MD goto :EOF
pause