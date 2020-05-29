:: https://www.jeffknupp.com/blog/2014/06/18/improve-your-python-python-classes-and-object-oriented-programming/

:: python uses 'def' keyword to define a function, and 'class' to define a class.
:: batch uses colon to mark label, which is used for subroutine.
:: batch subroutines don't return a value in place, so shouldn't be called functions.
:: functions could be implemented using interpreter.

:: C:\Users\Douglas\git\oobp\projectName\Objects

class Customer(object):
    """A customer of ABC Bank with a checking account. Customers have the
    following properties:

    Attributes:
        name: A string representing the customer's name.
        balance: A float tracking the current balance of the customer's account.
    """

    def __init__(self, name, balance=0.0):
        """Return a Customer object whose name is *name* and starting
        balance is *balance*."""
        self.name = name
        self.balance = balance

    def withdraw(self, amount):
        """Return the balance remaining after withdrawing *amount*
        dollars."""
        if amount > self.balance:
            raise RuntimeError('Amount greater than available balance.')
        self.balance -= amount
        return self.balance

    def deposit(self, amount):
        """Return the balance remaining after depositing *amount*
        dollars."""
        self.balance += amount
        return self.balance
        

jeff = Customer('Jeff Knupp', 1000.0)
jeff.withdraw(100.0) is just shorthand for Customer.withdraw(jeff, 100.0)