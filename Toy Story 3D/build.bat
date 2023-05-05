@echo off

asm68k /p Main.asm, b.bin, , b.lst
if not exist b.bin pause