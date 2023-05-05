@echo off

IF EXIST s1built.bin move /Y s1built.md s1built.prev.md >NUL
asm68k /k /p /o ae- /e error=0 sonic.asm, s1built.md, .sym, sonic.lst>errors.txt
IF EXIST s1built.md GOTO END
type errors.txt
pause
exit

:END
fixheadr.exe s1built.bin
