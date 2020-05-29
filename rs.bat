:: Study in Record Separator control character for object instantiation

rem Type ctrl+^ (ctrl+shift+6) to get . Works in text editor and CMD.exe.
rem Type Alt+[ctrl char number] on numeric keypad. Alt+0176=°

::@echo off
setlocal EnableDelayedExpansion

rem Declare a point variable without assigning a value
::java: Point p0
set p0=point

rem Define a point with coordinates x=5 and y=10.
set id1=point510

@echo ==========================================================================
rem Assign the reference to a variable
set p1_ref=id1

rem Assign the value directly to a variable
set p1_val=%id1%

rem Assign expandable reference to variable
set p1_exp=%%id1%%

rem Assign delayed expansion value to variable
set p1_del=!id1!

@echo ==========================================================================
echo p1_ref: [%p1_ref%] [!p1_ref!] 	& rem [id1] [!p1_ref!] --> p1_ref: [id1] [id1]
echo p1_val: [%p1_val%] [!p1_val!] 	& rem [point510] [!p1_val!] --> [point510] [point510]
echo p1_exp: [%p1_exp%] [!p1_exp!] 	& rem [%id1%] [!p1_exp!] --> [%id1%] [%id1%]
echo p1_del: [%p1_del%] [!p1_del!] 	& rem [point510] [!p1_del!] --> [point510] [point510]

@echo ==========================================================================
pause & call :point %p1_ref% 	& rem %1: [id1] [!id1!] id: [id1] [%id%] [!id1!] --> %1: [id1] [point510] id: [id1] [%id%] [point510]
pause & call :point %p1_val% 	& rem 
pause & call :point %p1_exp% 	& rem 
pause & call :point %p1_del% 	& rem 

endlocal
exit /b

:point
	setlocal EnableDelayedExpansion 
	set "id=%1"
	echo %%1: [%1] [!%1!] id: [%id%] [%%id%%] [!%id%!]
	endlocal
goto eof



pepe's ny pizza
phone: 818-358-2233
lg pizza: pepperoni,feta,garlic, black olive,onions on half
lg greek chopped salad
cream soda, dr. pepper $42.64
	