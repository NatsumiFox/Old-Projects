@echo off
asm68k /p Main.asm, b.md, , b.lst
if NOT EXIST b.md pause
