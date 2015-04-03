::SEND.BAT User Function

@echo off
if [%_object%]==[] goto no-saving
call push %_object%
call save
:: SAVE references %_class% and %_object%. Presumably, if _object is defined,
:: then _class is as well.
:no-saving
set _object=%1 & REM John
set _parms=%2 & REM set-name
:loop
shift
if not [%2]==[] set _parms=%_parms% %2 & REM set-name John Van Halen
if not [%3]==[] goto loop
call restore & REM Runs objects\John.bat, which sets _class=man, and _name=(nil)
call methods %_parms% & REM Sends "set-name John Van Halen" to METHODS.BAT
:: METHODS.BAT runs classes\man\methods\set-name.bat with params "John Van Halen"
:: set-name sets NAME=John Van Halen
call save
set _object=
set _parms=
cd classes\%_class%\statics
for %%a in (*) do set %%a=
cd ..\..\..
set _class=
call pop
if [%_object%]==[] goto no-restoring
call restore
:no-restoring

:: Douglas Notes
:: send John set-name John Van Halen
:: In demo, at first use of SEND, the object John.bat has just been created,
:: and contains two lines:
:: set _class=man
:: set _name=(nil)
:: The variable %_object% is not defined. Need to pay attention to when it is.