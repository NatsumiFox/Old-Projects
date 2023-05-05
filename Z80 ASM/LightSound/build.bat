@echo off

asm68k /p Main.asm, b.bin, , b.lst > err.txt

if EXIST b.bin exit

type err.txt
pause
