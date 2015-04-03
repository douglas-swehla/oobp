:: http://dirk.rave.org/batcoll.all
:: http://dirk.rave.org/chap9.txt

@echo off
:MAIN
set "command="
set /p "command=%~n0>"
call :%command%
goto :MAIN
exit /b

:: Object method default code is
:: call %_class%\methods\%~nx0 %*
:: where %_class% contains the path to the parent class,
:: and %* contains all the parameters that were passed.
::=============================================================================

:shell
:: The "%*" variable represents all the parameters passed to the batch or sub.
:: Since the parameters passed to the :shell sub should consist of a regular
:: Windows command and that command's parameters, we can just issue the sub's
:: parameter set as a command.
%*
goto :eof

:exit
:quit
:: Reproducing the EXIT command internally removes the need for an "exit/quit"
:: test in the main loop. Appending the %* variable passes in the optional [/b]
:: and [exit_code] values supported by EXIT. Adding the :quit label lets "quit"
:: behave the same as "exit".
exit %*

:INIT
mkdir classes
mkdir objects
goto :eof

:CLASS
mkdir classes\%1
mkdir classes\%1\methods
mkdir classes\%1\statics
if [%2]==[] goto :eof
:: Create an empty file (no characters, no CRLF, no newline) by redirecting
:: output first to nul, and then to file.
:: https://groups.google.com/forum/#!msg/microsoft.public.win2000.cmdprompt.admin/CHS0gwjZQDA/L85IIcFcLgkJ
<nul (set/p blank=) >classes\%1\%2
:: Ordinary COPY doesn't copy empty files !
xcopy classes\%2\statics\*.* classes\%1\statics > nul
goto :eof

:STATIC
<nul (set/p blank=) >classes\%1\%2
goto :eof

:METHOD
call :edit classes\%1\methods\%2.bat
goto :eof

:EDIT
echo Enter a line of text to add to the file, or "quit" without quotes to exit.
echo\
:EDIT_prompt
set "text="
set /p "text="
if /i "%text%" equ "quit" goto :EDIT_clear
echo %text% >> %1
goto :EDIT_prompt
:EDIT_clear
set "text="

:CREATE
set _class=%1
set _object=%2
cd classes\%_class%\statics
for %%a in (*) do set %%a=(nil)
cd ..\..\..
call save
cd classes\%_class%\statics
for %%a in (*) do set %%a=
cd ..\..\.. 
set _object=
set _class=
goto :eof

:KILL
del objects\%1.bat
goto :eof

:SEND
if [%_object%]==[] goto :SEND_no-saving
call push %_object%
call save
:SEND_no-saving
set _object=%1
set _parms=%2
:SEND_loop
shift
if not [%2]==[] set _parms=%_parms% %2
if not [%3]==[] goto :SEND_loop
call restore
call methods %_parms%
call save
set _object=
set _parms=
cd classes\%_class%\statics
for %%a in (*) do set %%a=
cd ..\..\..
set _class=
call pop
if [%_object%]==[] goto :eof
call restore
goto :eof

::Internal Procedures

:SAVE
echo set _class=%_class%>objects\%_object%.bat
cd classes\%_class%\statics
for %%a in (*.*) do call :SAVE-SUB %%a %%%%a%%
::for %%a in (*.*) do echo call save-sub %%a %%%%a%% >> ..\..\..\temp.bat
cd ..\..\..
goto :eof

:SAVE-SUB
set _varname=%1
set _to-save=%2
:SAVE-SUB_loop
shift
if not [%2]==[] set _to-save=%_to-save% %2
if not [%2]==[] goto :SAVE-SUB_loop
echo set %_varname%=%_to-save%>>objects\%_object%.bat
set _to-save=
set _varname=
goto :eof

:METHODS
set _searchclass=%_class%
set _method=%1
set _mparms=%2
:METHODS_parmloop
shift
if not [%2]==[] set _mparms=%_mparms% %2
if not [%2]==[] goto :METHODS_parmloop
:METHODS_loop
if not exist classes\%_searchclass%\methods\%_method%.bat goto :METHODS_next
call classes\%_searchclass%\methods\%_method% %_mparms%
goto :METHODS_end
:METHODS_next
cd classes\%_searchclass%
for %%a in (*) do set _searchclass=%%a
cd ..\..
goto :METHODS_loop
:METHODS_end 
set _searchclass=
set _method=
set _mparms=
goto :eof

:RESTORE
objects\%_object%.bat
goto :eof

:PUSH
set to-push=%1
:PUSH_loop
shift
if not [%1]==[] set to-push=%to-push% %1
if not [%1]==[] goto :PUSH_loop
echo set _object=%to-push%>_tmp
if exist _stack type _stack>>_tmp
if exist _stack del _stack
ren _tmp _stack
set to-push=
goto :eof

:POP
@echo off
set _object=
if not exist _stack goto :eof
:: Copy all but first line of _stack to _stack.bak
for /f "skip=1 tokens=1 delims=" %%F in (_stack) do echo %%F >> _stack.bak
:: Execute just first line of _stack and break out of loop.
for /f "tokens=1 delims=" %%F in (_stack) do (
	%%F
	goto :POP_next
)
:POP_next
del _stack
ren _stack.bak _stack
goto :eof

