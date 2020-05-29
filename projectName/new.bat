:: new customer jeff "Jeff Knupp" 123.45
:: new customer bob "Bob Ross" 456.12
@echo off

::=============================================================================
:: main script - no subroutines
::=============================================================================

set "args=%*"
:: Later versions can test for existence of class file, and recursively search %PATH% if not found.
set "class=%~1"

:: enable delayed expansion in order to use variable-based text substitution in SET command.
setlocal enableDelayedExpansion
set "class_args=!args:%class% =!" & rem :: Works
(endlocal
    rem :: disables delayed expansion
    set "class_args=%class_args%"
)

call "%class%" :__init__ %class_args%

rem :: Clear local variables we don't want passed back to caller.
set "args="
set "class="
set "class_args="

(exit /b %errorlevel%) & (@echo on)
