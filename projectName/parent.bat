@echo off
setlocal

set "test_parent=%~f0"

echo\ & echo In %0, after setting test_parent, before calling child.
set test & pause
rem :: parent only set

call child

echo\ & echo In %0, after calling child, before endlocal statement.
set test & pause
rem :: child and parent set
rem :: This is key -- child has survived the return from called batch.

(endlocal
    echo test_child: %test_child%
    echo test_parent: %test_parent%
    set test & pause
    rem :: both test_child and test_parent can be retrieved when referred to by name.
    rem :: neither appears in SET list, same as child.
    rem :: may be able to use delayed expansion inside for loop to refer to set all new variables by name.

    set "test_child=%test_child%"
    set "test_parent=%test_parent%"
    set test & pause
    rem :: both now appear in SET list
)
::

echo\ & echo In %0, after endlocal statement, before exit.
echo\ & set & pause
rem :: both still set
rem :: Setting by name (set "var=%var%") inside endlocal seems to work best.

echo\ & echo In %0, after endlocal statement, before exit.
set test & pause
rem :: parent only set

exit /b %errorlevel%

::=============================================================================

(endlocal
    echo\ & echo In %0, in endlocal statement, before set all.
    echo\ & set & pause
    rem :: 

    echo\ & echo In %0, in endlocal statement, before set all.
    set test & pause
    rem :: 

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
