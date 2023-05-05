@echo off
echo "Assembling S&K driver"
vasmZ80 -Fbin -maxerrors=25 -nocase -L .lst -o drv.bin drv.Z80
pause