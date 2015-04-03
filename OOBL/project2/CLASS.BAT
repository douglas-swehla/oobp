::CLASS.BAT User Function

@echo off
mkdir classes\%1
mkdir classes\%1\methods
mkdir classes\%1\statics
if [%2]==[] goto end
rem > classes\%1\%2
xcopy classes\%2\statics\*.* classes\%1\statics > nul
:: ordinary copy doesn't copy empty files !
:end

:: Douglas Notes
:: If parent class is updated after creation of subclass, the changes are not
:: reflected using this method. Can we make the child statics folder a shortcut
:: or junction to the parent static folder? Alternately, when parent is updated,
:: search for subclasses and update them as well.

:: In the file system, subclasses are sibling folders, rather than children.
:: There doesn't seem to be any way to determine from looking at a class what
:: its superclass is, or even whether it has one.
