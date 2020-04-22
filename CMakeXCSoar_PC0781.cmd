@echo OFF

REM Am 12.03.2020 aktuell!

cd /D %~dp0

set SOURCE_DIR=%CD%
set BINARY_DIR=D:\Projects\Binaries
set TARGET_PLATFORM=64
set THIRD_PARTY=D:\Projects\3rdParty
set LINK_LIBS=D:\link_libs
set COMPILER=MinGW
set COMPILER=VS2019
set PROGRAM_DIR=D:\Programme
REM set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0\mgw73
set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0
set Boost_DIR=%Boost_ROOT%\msvc2019\lib\cmake\Boost-1.72.0
set QT_ROOT=%THIRD_PARTY%\qt

call CMakeXCSoar.cmd