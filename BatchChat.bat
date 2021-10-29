@echo off
title   
cd /d %~dp0



if exist %~dp0BatchChat\ goto SS-1
mkdir BatchChat
:SS-1
cd /d %~dp0BatchChat\
if exist %~dp0BatchChat\ChatLog.txt goto SS-2
>"ChatLog.txt" (
echo %date%
)

:SS-2
if exist %~dp0BatchChat\Users.txt goto SS-3
>"Users.txt" (
echo.
)

:SS-3
cd /d "%homedrive%%homepath%"
if exist "%homedrive%%homepath%\BatchChat\" goto SS-4
mkdir BatchChat
:SS-4
if exist "%homedrive%%homepath%\BatchChat\Profiles.txt" goto SS-5
cd /d "%homedrive%%homepath%\BatchChat\"
>"Profiles.txt" (
echo -
echo -
echo -
)

:SS-5
cd /d "%homedrive%%homepath%\BatchChat\"
set /a n=1
for /f "usebackq delims=" %%a in ("%homedrive%%homepath%\BatchChat\Profiles.txt") do (
    call set profile[%%n%%]=%%a
    call set /a n+=1
)
set /a n-=1

:main
cls
title Login / Register

color b

echo Please Select or Create a Profile
echo 1: Select
echo 2: Create
echo 3: Exit
echo.
set /p c="Selection: "

if "%c%"=="1" goto 1
if "%c%"=="2" goto 2
if "%c%"=="3" exit

color c
title Error
echo The Option "%c%" does not exist.
ping localhost -n 4 >nul
goto main

:1
color b
cls
set /a n=1
for /f "usebackq delims=" %%a in ("%homedrive%%homepath%\BatchChat\Profiles.txt") do (
    call set profile[%%n%%]=%%a
    call set /a n+=1
)
set /a n-=1


title Profile: Select
echo Select a Profile.
echo Your Profiles:
echo 1: %profile[1]%
echo 2: %profile[2]%
echo 3: %profile[3]%
echo.
echo 4: Back
echo.
set /p ps="Select: "



if "%ps%"=="4" goto main
if "%ps%"=="1" goto S-1
if "%ps%"=="2" goto S-2
if "%ps%"=="3" goto S-3



:2
cls
title Profile: Create
echo Please Choose a Name for your Profile.
set /p nc="Name: "


if "%profile[1]%"=="-" goto P-S-1
if "%profile[2]%"=="-" goto P-S-2
if "%profile[3]%"=="-" goto P-S-3
if not "%profile[3]%"=="-" goto P-E

:P-S-1

set /a n=1
for /f "usebackq delims=" %%a in ("%homedrive%%homepath%\BatchChat\Profiles.txt") do (
    call set profile[%%n%%]=%%a
    call set /a n+=1
)
set /a n-=1

>"Profiles.txt" (
echo %nc%
echo %profile[2]%
echo %profile[3]%
)
echo Profile %nc% created!
ping localhost -n 4 >nul
goto main


:P-S-2
set /a n=1
for /f "usebackq delims=" %%a in ("%homedrive%%homepath%\BatchChat\Profiles.txt") do (
    call set profile[%%n%%]=%%a
    call set /a n+=1
)
set /a n-=1


>"Profiles.txt" (
echo %profile[1]%
echo %nc% 
echo %profile[3]%
)
echo Profile %nc% created!
ping localhost -n 4 >nul
goto main

:P-S-3
set /a n=1
for /f "usebackq delims=" %%a in ("%homedrive%%homepath%\BatchChat\Profiles.txt") do (
    call set profile[%%n%%]=%%a
    call set /a n+=1
)
set /a n-=1


>"Profiles.txt" (
echo %profile[1]%
echo %profile[2]%
echo %nc%
)
echo Profile %nc% created!
ping localhost -n 4 >nul
goto main



:S-1
if "%profile[1]%"=="-" goto S-E-E
set name=%profile[1]%
goto 3


:S-2
if "%profile[2]%"=="-" goto S-E-E 
set name=%profile[2]%
goto 3

:S-3
if "%profile[3]%"=="-" goto S-E-E
set name=%profile[3]%
goto 3

:S-E-E
title Error
color c
echo This Slot is Empty.
ping localhost -n 4 >nul
goto 1


:3
cls


title Chat Controller

echo.
echo Profile Selected: %name%
echo Connected: No

echo 1: Settings 2: Connect 3: Main Menu

set /p op="Option: "
if %op%==1 goto settings
if %op%==2 goto connect
if %op%==3 goto main


:connect
start "" "%~dp0Chat.bat"
cd /d "%~dp0BatchChat\"
echo [%time:~0,4%] %name% Joined the Chat >>"ChatLog.txt"
echo %name% >>"Users.txt"
:connect-loop
cls
set msg=

title Chat Controller
echo.
echo Profile Selected: %name%
echo Connected: Yes
echo.
echo 1: Leave
echo.
set /p mo="Option / Message: " 
if %mo%==1 goto leave
if not "%mo%"=="1" goto sender




:sender

set msg=%mo%

echo [%time:~0,4%] %name%: %msg% >>"ChatLog.txt"
goto connect-loop

:leave
echo [%time:~0,4%] %name% Left the Chat >>"ChatLog.txt"
findstr /V "%name%" Users.txt > Users.txt
goto 3


:settings
cls
title Settings
echo.
echo 1: Chat Color
echo 2: WIP

set /p se="Option: "
if %se%==1 goto color
color c
echo The Option %se% is invalid.
ping localhost -n 4 >nul
goto settings
:color

