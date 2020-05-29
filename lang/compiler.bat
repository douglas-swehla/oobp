:: Compiler for unnamed object-oriented batch programming (OOBP) language
@echo off
setlocal enableDelayedExpansion

set "source_files=%~1"
set "target_file=%~2"
set "target_name=%~n2"

set "lang_home=C:\Users\Douglas\git\oobp\lang"
set "functions=%~dp0\%target_name%_functions"
if not exist "%functions%" mkdir "%functions%"

:: Create batch header
(
echo :: Compiled %DATE% %TIME% from source file(s) %source_files%. 
echo @echo off
echo @echo off
echo:
echo ::=============================================================================
echo :: Main Body
echo ::=============================================================================
) > "%target_file%"

:: Create batch body: Copy function calls from source file(s)
set "file-set=%source_files%"
for %%F in (%file-set%) do (
	set "file=%%F"
	for /f "tokens=1*" %%A in (!file!) do (
		set "function=%%A"
		set "function_args=%%B"
		echo call :!function! !function_args! >> "%target_file%"
	)
	if not exist "%functions%\!function!.bat" copy "%lang_home%\!function!.bat" "%functions%\"
	echo: >> "%target_file%"
)

:: Create batch footer.
(
echo exit /b
echo:
echo:
echo ::=============================================================================
echo :: Functions
echo ::=============================================================================
) >> "%target_file%"

:: Copy functions to batch
for /f "usebackq" %%F in (`dir /b /o "%functions%\*.bat"`) do (
	echo:
	echo :%%~nF
	type "%functions%\%%F"
	echo ::-----------------------------------------------------------------------------
) >> "%target_file%"

:: Clean up and quit
rmdir /s /q "%functions%"

endlocal
exit /b


