@echo off
cd /D %~dp0

PATH=%PATH%D:\Programs\MinGW\msys\1.0\bin;
path
echo CurrDir: %CD%
pause

mingw32-make TARGET=PC

pause