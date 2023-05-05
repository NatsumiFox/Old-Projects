@echo off

ECHO %time:~0,2%:%time:~3,2% %date:~3,2%.%date:~6,2%.%date:~-4%
ECHO %time:~0,2%:%time:~3,2% %date:~3,2%.%date:~6,2%.%date:~-4%>CurrentBuild.asm

asm68k /q /o l+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- sonic1.asm, SonicGreenSnake.smd
rompad.exe SonicGreenSnake.smd 255 0
fixheadr.exe SonicGreenSnake.smd
pause