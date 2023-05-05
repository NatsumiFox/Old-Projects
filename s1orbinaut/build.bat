@echo off
asm68k /m /p /o ae- sonic1.asm, orbi.md, , .lst > build.asm
type build.asm
if EXIST orbi.bin GOTO :DEL
pause
GOTO EOF

:DEL
REM del \Y build.asm