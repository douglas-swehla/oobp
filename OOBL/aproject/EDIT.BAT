::EDIT.BAT Custom Procedure

@echo off
echo Enter a line of text to add to the file, or "quit" without quotes to exit.
echo\
:prompt
set "command="
set /p "command="
if /i "%command%" equ "quit" goto :clear
echo %command% >> %1
goto :prompt
:clear
set "command="
