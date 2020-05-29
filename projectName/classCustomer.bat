class Customer(object):
    :: A customer of ABC Bank with a checking account. Customers have the following properties:

    :: Attributes:
    ::     name: A string representing the customer's name.
    ::     balance: A float tracking the current balance of the customer's account.

:__init__ self name balance
::Return a Customer object whose name is *name* and starting balance is *balance*.
  setlocal
    set "self=%1"
  (endlocal
    set "%self%.name=%2"
    set "%self%.balance=%3"
  )
goto eof

:withdraw self amount
setlocal
  set self=%1 & rem :: Need to make sure that this gets value of calling object.
  set amount=%2
    rem :: Return the balance remaining after withdrawing *amount* dollars.
    if %amount% > !%self%.balance! (
        echo RuntimeError('Amount greater than available balance.')
    )
    self.balance -= amount
(
endlocal
set "%self%.balance=%new_balance%"
)


:deposit self amount
setlocal
  set self=%1 & rem :: Need to make sure that this gets value of calling object.
  set amount=%2
    rem :: Return the balance remaining after depositing *amount* dollars.
    set /a new_balance = %self%.balance + %amount%
(
endlocal
set "%self%.balance=%new_balance%"
)


::=============================================================================

::script
%jeff%.withdraw 10

::interpreter
for "tokens=1,2 delims=. " %%A in (%*) do (
  set "object=%%A"
  set "method=%%B"
  set "method_args=%%C"
)
call classCustomer.bat %jeff% withdraw 10