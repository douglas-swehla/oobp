::@echo off
setlocal
pushd C:\ & cls

@echo --Set and display initial variable values--
set "hw=hello world"
set "ref=value of reference"
@echo hw:  %hw%
@echo ref: %ref%
pause

@echo\
@echo --Pass by value (explicit string)--
@echo Passed value displayed on screen:
call :print_val "hello world"
call :print_val "value of reference"
pause

@echo\
@echo --Pass by value (expanded variable)--
@echo Passed value displayed on screen:
call :print_val "%hw%"
call :print_val "%ref%"
pause

@echo\
@echo --Pass by reference (variable name)--
@echo Variable names expanded to values:
call :print_ref_val "hw"
call :print_ref_val "ref"
pause

@echo\
@echo --Pass by reference (variable name)--
call :change_ref_val "hw"
call :change_ref_val "ref"
@echo Variable values changed by subroutine:
@echo hw:  %hw%
@echo ref: %ref%

@echo --Reset and display variable values--
set "hw=hello world"
set "ref=value of reference"
@echo hw:  %hw%
@echo ref: %ref%
pause

@echo\
@echo --Repeat sequence using named parameters--
call :change_ref_val "hw"
call :change_ref_val "ref"

popd
endlocal
exit /b

::=============================================================================
:: Subroutines
::=============================================================================

::-----------------------------------------------------------------------------
:: Use arg values directly
::-----------------------------------------------------------------------------
:print_val %val%
    @echo arg1: %~1
goto :eof

:print_ref_val ref
    setlocal enableDelayedExpansion
    @echo argument: %~1
    @echo expanded: !%~1!
    endlocal
goto :eof

:change_ref_val ref
    set "%~1=new value of %~1"
goto :eof

::-----------------------------------------------------------------------------
:: Assign argument values to parameter names
::-----------------------------------------------------------------------------
:print_val %myParam%
    setlocal
    set "myParam=%~1"
    @echo myParam: %myParam%
    endlocal
goto :eof

:print_ref_val myParam
    setlocal enableDelayedExpansion
    @echo myParam:  %~1
    @echo expanded: !%myParam%!
    endlocal
goto :eof

:change_ref_val myParam
    setlocal
    set "myParam=%~1"
    set "newVal=new value of %myParam%"
    endlocal & set "%myParam%=%newVal%"
goto :eof