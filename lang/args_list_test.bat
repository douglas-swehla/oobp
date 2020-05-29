:: Args list testing
echo test > file1.txt
echo test > "file 2.txt"
echo test > file3.txt

cls

call :show_list 'string'
call :show_list "file1.txt file 2.txt file3.txt"
call :show_list "file1.txt "file 2.txt" file3.txt"
call :show_list ""file1.txt" "file 2.txt" "file3.txt""

exit /b

:show_list
@echo  *: %*
@echo  1: %1
@echo ~1: %~1
pause
cls
@goto :eof

call :show_list file1 file 2 file3
call :show_list file1 "file 2" file3
call :show_list "file1" "file 2" "file3"

:: @echo ~*: %~*
