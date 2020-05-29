::test

call new customer bob "Bob Ross" 456.12
call :show_vars
echo\
call kill bob
call :show_vars

exit /b

:show_vars
    set bob
    set my
    set bal
    set name
    set self
goto:eof