:: new classCustomer2 jeff "Jeff Knupp" 123.45
:: new classCustomer2 bob "Bob Ross" 456.12
@echo off
setlocal enableDelayedExpansion

set "args=%*"
:: Later versions can test for existence of class file, and recursively search %PATH% if not found.
set "class=%~1"
::set "class_args=%args:!class!=%" & rem :: Fails
set "class_args=!args:%class% =!" & rem :: Works

echo\ & echo In %0, before calling class batch.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected

call "%class%" :__init__ %class_args%

echo\ & echo In %0, after calling class batch, before endlocal statement.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected: args & class defined; self, name, balance undefined; bob & namespace defined.

cls
echo\ & echo In %0, still after calling class batch, and before endlocal statement.
set
pause
:: as expected: args & class defined; self, name, balance undefined; bob & namespace defined.

::@echo on
(endlocal
  echo\ & set & pause
  rem :: No user-defined variables in SET list.

  set args & set class
  set self & set name & set balance
  set bob & set namespace
  pause
  rem :: No user-defined variables defined.

  for /f "delims=" %%F in ('set') do (set "%%F")
  pause
  echo\ & set & pause
)
::@echo off

echo\ & echo In %0, after endlocal statement, before exit.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
::unexpected: nothing defined

exit /b %errorlevel%
