@echo off
@mode con cols=70 lines=50
if not exist "%~dp0BatchChat\" goto error
cd /d "%~dp0BatchChat\"

:chat-loop
cls
title Chat
echo [=======Users:=======]
type "%~dp0BatchChat\Users.txt"
echo [========Chat:=======]
type "%~dp0BatchChat\ChatLog.txt"
ping localhost -n 4 >nul
goto chat-loop




:error
color c 
echo ERROR: Source not found
pause
exit