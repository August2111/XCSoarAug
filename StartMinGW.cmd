@echo off
cd /D %~dp0

REM set MINGW=MinGW_FromQt

if "%COMPUTERNAME%" == "PCDERAD0781" goto MinGW0781
if "%COMPUTERNAME%" == "FLAPS5" goto MinGW_Flaps5

goto MinGW_FromQt


:MinGW0781
set MSYS=D:\Programme\msys\msys
set MINGW=D:\link_libs\Qt\Qt5.14.0\Tools\mingw730_64

goto START_MINGW

: MinGW_Flaps5
goto MinGW_FromQt


: MinGW_FromQt
set MSYS=D:\Programs\msys\msys1.0.11
set MINGW=D:\Projects\3rd_Party\qt\Qt5.14.0\Tools\mingw730_64
mingw32-make.exe TARGET=PC

goto START_MinGW

PATH=D:\Programme\MinGW\bin;%PATH%


: START_MINGW

PATH=%MSYS%\bin;%MINGW%\bin;%PATH%
mingw32-make.exe TARGET=PC
goto END_MinGW



:END_MinGW
pause