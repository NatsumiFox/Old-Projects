@ECHO OFF

pushd "%~dp0\..\.."
"AS\Win32\asw.exe" -xx -q -c -D Sonic3_Complete=1 -A -L Sound/Test/Main.asm
IF EXIST Sound/Test/Main.p "AS\Win32\s3p2bin" Sound/Test/Main.p Sound/Test/Main.bin Sound/Test/Main.h
IF NOT EXIST Sound/Test/Main.p goto LABLPAUSE
IF EXIST Sound/Test/Main.bin goto LABLEXIT

:LABLPAUSE
pause
goto LABLEXIT

:LABLEXIT
popd
del SOUND.MD
ren Main.bin SOUND.MD
exit /b
