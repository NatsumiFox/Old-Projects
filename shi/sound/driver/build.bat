@echo off
echo "Assembling driver"
vasmZ80 -Fbin -maxerrors=25 -nocase -L SK.lst -o SK.bin drv.Z80>../../err.SK.txt