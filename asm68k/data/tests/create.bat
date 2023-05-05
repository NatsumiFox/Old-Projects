@echo on

rem magic to get rest of the args after %3
for /f "tokens=1-3*" %%a in ("%*") do (
    set test="%%a"
    set tool="%%b"
    set args=%%d
)

cd data\tests\%test%
..\..\..\%tool% %args% --trace test.log --lst test.lst main.asm test.dat
move test.log main.log
move test.dat main.dat
pause
