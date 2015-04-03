::METHOD.BAT User Function

:: Author Notes
:: METHOD.BAT assumes that there is an editor named EDIT, which takes a file 
:: name as its command line argument, in a directory of the system path.
:: Class, object, method and (static) variable names are restricted to eight 
:: characters. Use tree /f to get a good idea of how the objects and classes 
:: are represented on disk.

@echo off
edit classes\%1\methods\%2.bat

:: Douglas Notes
:: METHOD.BAT only appears to be necessary if you want to edit the method batch
:: via the command line. It should be just as easy, if not easier, to edit the
:: method batch manually, in a proper editor. I don't know if NPP will take a
:: file name as a parameter for editing. I could probably create an EDIT.BAT
:: file that takes a file name as a parameter, and prompts for a single line of
:: input using SET /P.
