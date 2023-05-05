@echo off
_exec\asm68k /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- main.asm, player.bin, , main.lst
_exec\asm68k /e NoDAC=1 /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- main.asm, player_nodac.bin, , main.lst
pause
