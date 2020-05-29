:: Interpreter for unnamed object-oriented batch programming (OOBP) language
@echo off

:setup
set "library=%~dp0\lib"
set "old_prompt=%prompt%"
set "prompt=oobp %prompt%"

:branch
if [%1] equ [] goto :interact
for /f "usebackq tokens=1*" %%F in (`%*`) do call "%lib%\%%F.bat" %%G
exit /b

:interact
set "command="
set /p "command=%prompt%"
if /i "%command%" equ "quit" goto :quit
echo %command%
goto :interact

:quit
set "command="
set "prompt=%old_prompt%"
exit /b


::=============================================================================
:: Keyword Functions
::=============================================================================

:compile
call "%lang_home%\compiler.bat" %*
goto :eof





::-----------------------------------------------------------------------------


::=============================================================================
:: Helper Functions
::=============================================================================

