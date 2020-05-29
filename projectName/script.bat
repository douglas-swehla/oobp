::script.bat

:: Create object 'jeff' based on class 'Customer'.
  :: Using pure batch language
  call classCustomer.bat __init__ jeff "Jeff Knopp" 100
  
  :: Using potential interpreted language
  create Customer jeff "Jeff Knopp" 100
  :: or 
  jeff = Customer "Jeff Knopp" 100

