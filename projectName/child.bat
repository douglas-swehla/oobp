@echo off
setlocal

set "test_child=%~f0"

echo\ & echo In %0, after setting test_child, before endlocal statement.
set test & pause
rem :: child and parent set

(endlocal
    echo test_child: %test_child%
    echo test_parent: %test_parent%
    set test & pause
    rem :: test_child can be retrieved when referred to as %test_child%
    rem :: test_child does not appear in SET list. huh.
    rem :: may be able to use delayed expansion inside for loop to refer to set all new variables by name.

    set "test_child=%test_child%"
    set test & pause
    rem :: test_child now appears in SET list.
)
::

echo\ & echo In %0, after endlocal statement, before exit.
echo\ & set & pause
rem :: child and parent set

echo\ & echo In %0, after endlocal statement, before exit.
set test & pause
rem :: child and parent set

exit /b %errorlevel%

::=============================================================================

(endlocal
    echo\ & echo In %0, in endlocal statement, before set all.
    echo\ & set & pause
    rem :: child unset, parent set

    echo\ & echo In %0, in endlocal statement, before set all.
    set test & pause
    rem :: child unset, parent set

    echo test_child: %test_child%
    echo test_parent: %test_parent%
    pause

    for /f "delims=" %%F in ('set') do (set "%%F")
    pause

    echo\ & echo In %0, in endlocal statement, after set all.
    echo\ & set & pause
)
::

echo\ & echo In %0, after endlocal statement, before exit.
echo\ & set & pause
rem :: 

echo\ & echo In %0, after endlocal statement, before exit.
set test & pause
rem :: 
