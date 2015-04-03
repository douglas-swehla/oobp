::METHODS.BAT Internal Procedure

set _searchclass=%_class% & REM man
set _method=%1 & REM set-name
set _mparms=%2 & REM John
:parmloop
shift
if not [%2]==[] set _mparms=%_mparms% %2 & REM John Van Halen
if not [%2]==[] goto parmloop
:loop
:: Look for the method in the parent class.
if not exist classes\%_searchclass%\methods\%_method%.bat goto next
:: If it's found, run it with the given parameters.
call classes\%_searchclass%\methods\%_method% %_mparms%
goto end
:next
:: If it's not found, go to the class folder,
cd classes\%_searchclass%
:: and for each subclass, set _searchclass to that. Only seems to allow for one subclass.
for %%a in (*) do set _searchclass=%%a
cd ..\..
:: Go back up and look for the method in the new _searchclass folder.
goto loop
:end 
set _searchclass=
set _method=
set _mparms=

:: Douglas Notes
:: Demo calls this script for first time from SEND.BAT, with parameters
:: "set-name John Van Halen".
:: Demo will find the set-name method in the parent man class, so will
:: run it with _mparms=John Van Halen