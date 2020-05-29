:: Generic Class Definition

:set_class_variables
set "classVar1=value"
set "classVar2=value"
set "namespace=myNamespace"

set "superclass=\path\to\superclass.bat"
set "inherits=class1.bat class2.bat interface1.bat interface5.bat"

:sanity_check
rem :: Run sanity checks on inputs before passing to caller.
if "%dumb_input%" equ "true" (
    echo You can't do that.
    call :set_error bad_input
    exit /b %my_errorlevel%
)

:main_call
:: Could use GOTO instead of CALL, if certain we always want to exit immediately.
call %*

:clean_up
rem :: After-call cleanup can go here. Clear variables, elevate local variables to parent context, update object state snapshot, etc.

exit /b %errorlevel%

:set_error
    if "%~1" equ "bad_input" set /a "my_errorlevel=1" & goto :eof
    if "%~1" equ "other_code" set /a "my_errorlevel=2" & goto :eof

::=============================================================================
:: Object Methods (require reference to object name as "self")
::=============================================================================

:: constructor
:__init__ self objVar1 objVar2
    if defined %~1 (
        echo Object "%~1" already exists. The constructor cannot be called on an existing object.
        rem :: Set an appropriate error level. Can refine error levels later.
        exit /b 1
    )
    set "self=%~1"
    set "objVar1=%~2"
    set "objVar2=%~3"
goto :eof

:: object methods
:get_objVar1 self
:: Does it even make sense to have a GET routine when objects can reasonably guess the variable name and access it that way? If objects want a copy of the value at the time of request (it might change a moment later), they may can pass in a variable name to have the value assigned to. 
    setlocal enableDelayedExpansion
    set "var_name=%~1.objVar1"
    echo !%var_name%!
    endlocal 
goto :eof

:set_objVar1 self new_value
    setlocal enableDelayedExpansion
    rem :: Sanity checks
    set "self=%~1"
    set "new_value=%~2"
    set "%self%.objVar1=%new_value%"
    (endlocal & set "objVar1=%new_value%")
goto :eof
    