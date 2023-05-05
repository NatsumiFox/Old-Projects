@echo off
_exec\asm68k /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- sonic1.asm, s1built.bin, , sonic1.lst
_exec\fixheadr s1built.bin
pause
