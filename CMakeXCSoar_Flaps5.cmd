@echo OFF

REM Am 12.03.2020 aktuell!

cd /D %~dp0

set SOURCE_DIR=%CD%
set BINARY_DIR=D:\Projects\Binaries
set TARGET_PLATFORM=64
set THIRD_PARTY=D:\Projects\3rd_Party
set LINK_LIBS=D:\link_libs
set COMPILER=VS2019
REM set COMPILER=MinGW82 - geht nicht, es fehlt ein Ordner 'x86_64-w64-mingw32', u.a. mit winapifamily.h!
set COMPILER=MinGW73
set PROGRAM_DIR=D:\Programs
REM set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0\msvc2019
set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0
set QT_ROOT=%THIRD_PARTY%\qt

REM  call CMakeXCSoar.cmd
D:\python.exe --version

set BUILD_CMD=python CMakeXCSoar_Flaps5.py
echo %BUILD_CMD%
%BUILD_CMD%
pause
exit /B 0
