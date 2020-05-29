@echo off
setlocal

echo\ & echo In %0, before calling :__init__ subroutine.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected

call %*

echo\ & echo In %0, after calling :__init__, before endlocal statement.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected: args & class defined; self, name, balance undefined; bob & namespace defined.

(endlocal
  echo\ & echo In %0, in endlocal statement. & set & pause
  rem :: All user-defined variables are in SET list.

  set args & set class
  set self & set name & set balance
  set bob & set namespace
  pause
  rem :: Above statement wrong: aas expected, args & class defined; self, name, balance undefined; bob & namespace defined.

  for /f "delims=" %%F in ('set') do (set "%%F") & rem :: overkill
)

echo\ & echo In %0, after endlocal statement, before exit and return to new.bat.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected: args & class defined; self, name, balance undefined; bob & namespace defined.

exit /b %errorlevel%

:: class Customer(object)
::    A customer of ABC Bank with a checking account. Customers have the following properties:
::
::    Attributes:
::        name: A string representing the customer's name.
::        balance: A float tracking the current balance of the customer's account.

:__init__ self name balance=0.0
setlocal
    rem Return a Customer object whose name is *name* and starting balance is *balance*.
    echo :__init__ arg0 = %0, %~0
    echo :__init__ arg1 = %1, %~1
    echo :__init__ arg2 = %2, %~2
    echo :__init__ arg3 = %3, %~3
    pause
    
    echo\ & echo In %0, after showing args list, before setting base properties.
    set args & set class
    set self & set name & set balance
    set bob & set namespace
    pause
    :: as expected

    rem :: In later versions, %self% can be prepended with namespace prefix.
    set "self=%~1"
    set "name=%~2"
    if "%~3" equ "" (
      set "balance=0"
    ) else (
      set "balance=%~3"
    )
    
    echo\ & echo In %0, after setting base properties, before setting namespace properties in endlocal statement.
    set args & set class
    set self & set name & set balance
    set bob & set namespace
    pause
    :: as expected

(endlocal
  set "%~1=namespace.%self%"
  set "namespace.%self%.self=%self%"
  set "namespace.%self%.name=%name%"
  set "namespace.%self%.balance=%balance%"
)

echo\ & echo In %0, after endlocal statement, before goto:eof.
set args & set class
set self & set name & set balance
set bob & set namespace
pause
:: as expected: args & class defined; self, name, balance undefined; bob & namespace defined.

goto :eof

:withdraw self amount
    rem Return the balance remaining after withdrawing *amount* dollars.
    if amount > set "%~f0.balance:
        raise RuntimeError('Amount greater than available balance.')
    set "%~f0.balance -= amount"
    return set "%~f0.balance"
goto :eof

::    if "%2" equ "" (
::      set /a %self%.balance_dollars=0
::      set /a %self%.balance_cents=0
::    ) else (
::      for /f "tokens=1,2 delims=." %%A in ("%~2") do (
::        set /a %~f0.balance_dollars=%%A
::        set /a %~f0.balance_cents=%%B
::      )
::    )


:deposit self amount
    rem Return the balance remaining after depositing *amount* dollars.
    set "%~f0.balance += amount
    return set "%~f0.balance
goto :eof
