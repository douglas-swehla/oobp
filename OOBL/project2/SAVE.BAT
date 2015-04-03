::SAVE.BAT Internal Procedure

:: echo set _class=%_class%>objects\%_object%.bat
cd classes\%_class%\statics
for %%a in (*.*) do echo call save-sub %%a %%%%a%% >> ..\..\..\temp.bat
cd ..\..\..
:: TREE /F & REM :: Douglas edit
:: PAUSE & REM :: Douglas edit
for %%a in (call del) do %%a temp.bat

:: Douglas Notes
:: When 'create man John' is entered, file objects\John.bat is created,
:: and the first command in the batch is 'set _class=man'. The point here
:: is that, like classes, objects are stored as batch files, and not just
:: in memory. Another interesting thing is that objects are stored in a
:: separate folder from classes, rather than in subfolders as I had thought.

:: In the CREATE batch, each static variable is set to (nil), so the first
:: FOR loop here will write the command 'call save-sub name %name%' to
:: temp.bat. When temp.bat is run, that will expand to 'call save-sub name (nil)'.

:: The 'do echo call save-sub ... temp.bat' sequence seems a bit overkill.
:: Why not just call save-sub from the FOR loop, instead of copying the 
:: commands to a separate script first?

:: Last line does 'call temp.bat' then 'del temp.bat'. How confusing.
:: It's much clearer, and less code, to just issue two commands.

:: In the first iteration, the call to temp.bat failed because it wasn't
:: created during the first FOR loop. It wasn't created because there
:: were no files in classes\man\statics. There were no files because using
:: the REM no content to file technique doesn't work (on this computer, at
:: least). Will try again with ECHO technique.

:: When running 'create man John', the temp.bat file contains
:: call save-sub name %name% 
:: at a time when %name% contained '(nil'. The missing close-parenth is
:: because of the modified CREATE batch.

:: The second demo call to this batch is from SEND.BAT, where we have just set
:: NAME=John Van Halen. Earlier, we set _class=man and _object=John. This time,
:: the first FOR loop here will write the command 'call save-sub name %NAME%'
:: to temp.bat. When temp.bat is run, that will expand to 
:: 'call save-sub name John Van Halen'.


:: Each time SAVE is called, it overwrites the existing object batch file
:: (John.bat), starting with the _class setting, followed by each of the static
:: variables