@echo off
_exec\asm68k /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- sonic1.asm, s1built.bin, , sonic1.lst
_exec\rompad s1built.bin 255 0
_exec\fixheadr s1built.bin
copy s1built.bin "D:\sonic GS\SourceCode\s1built.bin"
pause
