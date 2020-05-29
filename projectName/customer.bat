@echo off
:: Batch does not need SETLOCAL statement, and actually works better without it.

:: class Customer(object)
::    A customer of ABC Bank with a checking account. Customers have the following properties:
::
::    Attributes:
::        name: A string representing the customer's name.
::        balance: A float tracking the current balance of the customer's account.

::=============================================================================
:: main script
::=============================================================================

rem :: Need to think through where and how this is determined.
rem :: Generally want to avoid depending on global variables.
rem :: Maybe "namespace=%namespace%.%addition%"
set "namespace=myNamespace"

call %*

set "namespace="
exit /b %errorlevel%

::=============================================================================
:: subroutines
::=============================================================================

:__init__ self name balance=0.0
setlocal
    rem Return a Customer object whose name is *name* and starting balance is *balance*.
    rem :: In later versions, %self% can be prepended with namespace prefix.
    set "self=%~1"
    set "name=%~2"
    if "%~3" equ "" (
      set "balance=0"
    ) else (
      set "balance=%~3"
    )
    
(endlocal
    rem :: Setting a shorthand name might be a bad idea. Makes killing harder.
    set "%~1=%namespace%.%self%"
    set "%namespace%.%self%.self=%self%"
    set "%namespace%.%self%.name=%name%"
    set "%namespace%.%self%.balance=%balance%"
)

goto :eof

:withdraw self amount
setlocal enableDelayedExpansion
@echo on
set "self=%~1"
set "amount=%~2"
set "old_balance=!%namespace%.%self%.balance!"
for /f "delims=." %%A in ("%amount%") do (
    if "%%A" equ "%%A" (set "amount_dollars=0") else (set "amount_dollars=%%A")
    if "%%B" equ "%%B" (set "amount_cents=0") else (set "amount_cents=%%B")
)
for /f "delims=." %%A in ("%old_balance%") do (
    if "%%A" equ "" (set "old_balance_dollars=0") else (set "old_balance_dollars=%%A")
    if "%%B" equ "" (set "old_balance_cents=0") else (set "old_balance_cents=%%B")
)
set amount
set old_balance
pause

:: Sanity check
if %amount_dollars% gtr %old_balance_dollars% (
    echo You can't take out more than you've got.
    goto :eof
)
if %amount_dollars% equ %old_balance_dollars% (
    if %amount_cents% gtr %old_balance_cents% (
        echo You can't take out more than you've got.
        goto :eof
    )
)

::Calculate new component values
set /a "new_balance_cents=%old_balance_cents%-%amount_cents%"
set /a new_balance_dollars = %old_balance_dollars% - %amount_dollars%
if %new_balance_cents% lss 0 (
    set /a new_balance_cents = new_balance_cents + 100
    set /a new_balance_dollars = new_balance_dollars - 1
)
set "new_balance=%new_balance_dollars%.%new_balance_cents%"
@echo off & pause

(endlocal
    set "%namespace%.%self%.balance=%new_balance%"
)
goto :eof

if "%2" equ "" (
    set /a %self%.balance_dollars=0
    set /a %self%.balance_cents=0
) else (
    for /f "tokens=1,2 delims=." %%A in ("%~2") do (
        set /a %~f0.balance_dollars=%%A
        set /a %~f0.balance_cents=%%B
    )
)


:deposit self amount
    rem Return the balance remaining after depositing *amount* dollars.
    set "%~f0.balance += amount
    return set "%~f0.balance
goto :eof
