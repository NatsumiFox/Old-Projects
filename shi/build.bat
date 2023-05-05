@echo off
echo Build started...
asm68k /p /m main.asm, hi.md, , s3k.lst>err.68k.txt
type err.68k.txt

IF NOT EXIST hi.md goto LABLERR
echo Build succeeded

goto LABLDONE

:LABLERR
echo Build failed
pause

:LABLDONE
