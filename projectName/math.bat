:: math.bat
:: Example of batch module. Can be part of a library (folder containing modules).
@echo off

:main 
call :%*
exit /b %errorlevel%

::=============================================================================
:: Subroutines
::=============================================================================

:mset var expression
:: doskey math=call path\lib\math.bat
:: doskey mset=math mset
:: doskey mset=call path\lib\math.bat mset
for /f "tokens=1*" %%A in ("%*") do (
  set "var=%%~A"
  set "expression=%%B"
)
set /a %var% = %expression%

:: Goal: methodOutput = object.method(args)

::Define local keywords
doskey eset=call :eset $*
doskey quit=exit /b %errorlevel%

:main
::Use keywords in main routine.
eset methodOutput object.method(args)
quit

:eset varName methodCall
for /f "tokens=1*" %%A in ("%*") do (
  set "varName=%%~A"
  set "methodCall=%%~B"
)
for /f "tokens=1,2* delims=.()" %%A in ("%methodCall%") do (
  set "object=%%A"
  set "method=%%B"
  set "args=%%C"
)
call "%object%.bat" "%method%" "%args%"