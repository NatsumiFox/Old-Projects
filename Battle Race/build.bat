@echo off

cd "Sound\PCM"
call Z80PCM.bat 1
cd "..\.."

cd "Special Stage\Layouts"
call Assemble.bat 1
cd "..\.."

call "Build Scripts/buildS3Complete.bat" -e
