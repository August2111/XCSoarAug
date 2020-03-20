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
REM set PROGRAM_DIR=D:\Programs
REM set TARGET_PLATFORM=64
REM set MINGW_DIR=%PROGRAM_DIR%\MinGW\x%TARGET_PLATFORM%
REM goto START_MinGW

: MinGW_FromQt
set MSYS=D:\Programs\msys\msys1.0.11
set MINGW=D:\Projects\3rd_Party\qt\Qt5.14.0\Tools\mingw730_64
REM mingw32-make.exe TARGET=PC
REM mingw32-make.exe
cd /D D:\Projects\Binaries\XCSoarAug_x64_MinGW
echo CurrDir: %CD%

goto START_MinGW

PATH=D:\Programme\MinGW\bin;%PATH%


: START_MINGW

PATH=%MSYS%\bin;%MINGW%\bin;%PATH%
REM mingw32-make.exe TARGET=PC
mingw32-make.exe
goto END_MinGW



:END_MinGW
pause