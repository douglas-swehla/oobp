::SAVE-SUB.BAT Internal Procedure

set _varname=%1
set _to-save=%2
SET & REM :: Douglas edit
PAUSE & REM :: Douglas edit
:loop
shift
if not [%2]==[] set _to-save=%_to-save% %2
if not [%2]==[] goto loop
echo set %_varname%=%_to-save%>>objects\%_object%.bat
NOTEPAD objects\%_object%.bat & REM :: Douglas edit
SET & REM :: Douglas edit
PAUSE & REM :: Douglas edit
TREE /F & REM :: Douglas edit
PAUSE & REM :: Douglas edit
set _to-save=
set _varname=

:: Douglas Notes
:: The _varname value, when sent from SAVE, is taken from the list of statics.
:: The _to-save value, when sent from SAVE, seems to be the current value of
:: the variable, as set in the previous lines. 

:: The shift/loop sequence seems to take care of variable values that contain
:: spaces. There is probably a better way to do that, using 'for /f "delims="'
:: or 'type' to get the full line from the variable file (if it has content),
:: or setting _to-save to %*, and then removing %1 from the beginning.

:: Once _to-save is in its final form, a SET command is appended to the object's
:: batch file. Not sure what's going on with the temp.bat file in the project's
:: root folder, as described in SAVE. Does it duplicate the SET commands?

:: The temp.bat file contains a list of commands to write to the object batch.
:: In the case of the demo, the first object is John.bat, in which we want to
:: have the command 'set name=John Van Halen', where 'name' is one of the
:: static variables listed in classes\man\statics.

:: The SAVE batch cycles through all the static variables, and calls SAVE-SUB
:: for each one. SAVE-SUB puts all the commands in temp.bat, and SAVE runs it,
:: which puts all the static variable definitions into the object batch.
