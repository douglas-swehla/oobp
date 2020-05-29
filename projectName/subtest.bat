@echo off & call %* & exit /b %errorlevel%
:: This script tests whether it's possible to call a subroutine directly from
:: outside a script, without using the "call %* & exit" hack.

echo This is the main body of the script. It will exit after the pause.
pause
exit /b

:sub1
echo This is subroutine 1. It comes after the exit in the main body.
echo It will go to :eof after the pause.
goto:eof

:sub2
echo This is subroutine 2. It comes after :sub1.
echo It will exit after the pause.
exit /b
