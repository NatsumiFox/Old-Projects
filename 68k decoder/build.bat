@echo off
asm68k /m /p Main.asm, b.md, , b.lst > err.txt
type err.txt
IF NOT EXIST b.md pause & exit
error\convsym b.lst b.md -input asm68k_lst -inopt "/localSign=. /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
timeout 2
