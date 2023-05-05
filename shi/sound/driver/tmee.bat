@echo off
echo "Assembling Z80WAVD"
vasmZ80 -Fbin -maxerrors=25 -nocase -L Z80WAVD.lst -o Z80WAVD.bin Z80WAVD.ASM>../../err.Z80WAVD.txt
pause