::kill object
@echo off

::=============================================================================
:: main script - no subroutines
::=============================================================================

rem :: May want to get rid of short name, if it makes this too complicated.
rem :: Depends on how easy it is to find namespace if short name gets cleared.
set "objectShortName=%~1"

rem :: Using SETLOCAL too early makes the deletions only apply locally.
setlocal enableDelayedExpansion
    set "objectLongName=!%objectShortName%!"
(endlocal & set "objectLongName=%objectLongName%")

if "%objectLongName%" equ "" (
    echo The Namespace variable objectLongName for object %objectShortName% not defined.
    echo Environment variables containing ".%objectShortName%." are:
    
    goto :clear_local_vars
)

:clear_object_vars
for /f "delims=" %%F in ('set %objectLongName%') do (
    for /f "delims==" %%A in ("%%F") do (
        set "%%A="
    )
)
set "%objectShortName%="

:clear_local_vars
set "objectShortName="
set "objectLongName="

exit /b %errorlevel%

:: Substitution experiment: >kill bob
setlocal enableDelayedExpansion
    echo 1. objectName      & rem ::  objectName
    echo 2. %objectName%    & rem ::  bob
    echo 3. %%objectName%%  & rem ::  %objectName%
    echo 4. !objectName!    & rem ::  bob
    echo 5. %!objectName!%  & rem ::  [blank]
    echo 6. !%objectName%!  & rem ::  myNamespace.bob
endlocal
