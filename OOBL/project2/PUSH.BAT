::PUSH.BAT Internal Procedure

@echo off
set to-push=%1
:loop
shift
if not [%1]==[] set to-push=%to-push% %1
if not [%1]==[] goto loop
echo set _object=%to-push%>_tmp
if exist _stack type _stack>>_tmp
if exist _stack del _stack
ren _tmp _stack
set to-push=

:: Douglas Notes
:: This script takes all input parameters, stores them in one string, and then
:: writes that string to the top of the project\_stack file; it "pushes" the
:: contents to the top.
:: This could be simplified by replacing the shift/loop sequence with
:: SET to-push=%*
:: The author doesn't seem to know about the %* variable.
:: Another simplification would be to combine the two IF EXIST tests into one.
