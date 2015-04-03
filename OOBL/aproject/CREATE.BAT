::CREATE.BAT User Function

::@echo on
PAUSE & REM :: Douglas edit

ECHO This is the heavily modified version of CREATE.BAT. & REM :: Douglas edit
SET & REM :: Douglas edit
set _class=%1
set _object=%2
PAUSE & REM :: Douglas edit

SET & REM :: Douglas edit
DIR classes\%_class%\statics & REM :: Douglas edit
PAUSE & REM :: Douglas edit

cd classes\%_class%\statics
PAUSE & REM :: Douglas edit

::for %%a in (*) do set %%a=(nil)
echo a in classes\%_class%\statics\* & REM :: Douglas edit
for %%a in (*) do (
	echo a: %%a
	set %%a=(nil)
) & REM :: Douglas edit
cd ..\..\..
SET & REM :: Douglas edit
ECHO About to call SAVE. & REM :: Douglas edit
PAUSE & REM :: Douglas edit

call save
ECHO SAVE complete, back in CREATE. & REM :: Douglas edit
PAUSE & REM :: Douglas edit

SET & REM :: Douglas edit
cd classes\%_class%\statics
for %%a in (*) do set %%a=
cd ..\..\.. 
set _object=
set _class=
SET & REM :: Douglas edit

:: Douglas Notes
:: Each empty file in the parent class's statics folder represents a variable name.
:: The script goes through the list of file names, and sets a variable with the same name,
:: with a value of "(nil)". This will (presumably) be overwritten when the SEND
:: command is called. I'm expecting this to fail, since the 'REM > file' approach
:: didn't create any files. Changing it to 'echo\ > file' should work, I think.

:: Everything after SAVE is just clearing out variable values. Let it just run
:: the first time through. Can set PAUSEs and check variable values step-by-step
:: in another run.

:: Running 'create man John' gave the following errors:
:: 'temp.bat' is not recognized as an internal or external command,
:: operable program or batch file.
:: Could Not Find V:\oop\oobl\aproject\temp.bat

:: 