::STATIC.BAT User Function

@echo off
rem > classes\%1\statics\%2
echo\ > classes\%1\statics\%2 & REM :: Douglas edit

:: Douglas Notes
:: When following the demonstration from chap9.txt, this did not create an empty
:: "classes\man\statics\name" file. Is the author used to Unix world? Does some
:: setting need to be enabled?

:: Changing to ECHO\ works. The resulting file has two blank lines.
:: Couldn't find a way to get just one line, but shouldn't matter, 
:: since content doesn't seem to be used. I had thought that the variables
:: files would contain the variable value, and maybe even a data type.
:: That may still be a good idea. Will see how the rest of this works
:: before deciding, though.

:: This sequence will create a completely empty file; one line, no characters,
:: no newline.
:: enter COPY CON <filename>
:: enter ^Z (by typing CTRL-Z)
:: Need to figure out how to send control characters to prompt from batch file,
:: if possible.

:: <nul (set/p text=) > classes\%1\statics\%2
:: Should probably do the trick.
