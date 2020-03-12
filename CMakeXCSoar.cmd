@echo OFF

REM Am 05.10.2019 aktuell!

if not defined PROJECT_NAME  set PROJECT_NAME=XCSoarAug
echo start CMake %PROJECT_NAME% - a XCSoar-Fork for Windows!
cd /D %~dp0

if not defined SOURCE_DIR  set SOURCE_DIR=%CD%
if not defined BINARY_DIR set BINARY_DIR=D:\Projects\Binaries
if not defined TARGET_PLATFORM  set TARGET_PLATFORM=64
if not defined THIRD_PARTY set THIRD_PARTY=D:/Projects/3rd_party
if not exist "%THIRD_PARTY%" set THIRD_PARTY=D:/link_libs
REM if not defined QT_VERSION  set QT_VERSION=5.13.1
if not defined COMPILER  set COMPILER=VS2019
if not defined PROGRAM_DIR  set PROGRAM_DIR=D:\Programs
REM if not defined BOOST_ROOT set BOOST_ROOT=%THIRD_PARTY%/boost/boost_1_65_1
if "%COMPUTERNAME%"  == "PCDERAD0781" if not defined Boost_ROOT set Boost_ROOT=D:\Programme\boost\boost_1_72_0\vc142
if "%COMPUTERNAME%"  == "FLAPS5"      if not defined Boost_ROOT set Boost_ROOT=%THIRD_PARTY%\boost\boost_1_72_0\vc142
if not defined QT_ROOT set QT_ROOT=%THIRD_PARTY%/qt

cmake --version > NUL
if errorlevel 1 PATH = d:\Programme\CMake\bin;%PATH%
cmake --version
echo ERRORLEVEL = %ERRORLEVEL%
REM pause

if exist CMakeCache.txt del CMakeCache.txt
if exist cmake_install.cmake del cmake_install.cmake
if exist Makefile del Makefile
if exist CMakeFiles rmdir  CMakeFiles  /S /Q

goto %COMPILER%
:MinGW
if not "%COMPILER%"=="MinGW"  goto VS2013
echo Im Compiler 'MinGW-Pfad'
set MINGW_DIR=%PROGRAM_DIR%\MinGW\x%TARGET_PLATFORM%
set COMPILER_HOME=%MINGW_DIR%\bin
set MAKETOOL=mingw32-make
  set PATH=%PATH%;%COMPILER_HOME%
  set GENERATOR=MinGW Makefiles
  rem set GENERATOR=Eclipse CDT4 - MinGW Makefiles
goto CompilerEnd

: VS2013
if not "%COMPILER%"=="VS2013"  goto VS2015
echo Im Compiler 'VS2013-Pfad'
  set VSCOMMONTOOLS=%VS120COMNTOOLS%
  set COMPILER_VERSION=12
  set MAKETOOL=jom
  set PATH=%PATH%;c:/Programs/Jom_1_0_14
  goto VisualStudio
: VS2015   
if not "%COMPILER%"=="VS2015"  goto NoCompiler
echo Im Compiler 'VS2015-Pfad'
  set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set COMPILER_VERSION=14
  rem set MAKETOOL=jom
  set MAKETOOL=nmake
  set PATH=%PATH%;c:/Programs/Jom_1_0_14
  goto VisualStudio
  
: VS2017
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set COMPILER_VERSION=15
  set MAKETOOL=jom
  REM set MAKETOOL=nmake
  set QT_COMPILER=msvc2017_64
  set PATH=%PATH%;%JOM_DIR%
    
  SET TOOLSET=v141
  set GENERATOR=Visual Studio %COMPILER_VERSION% Win64
  SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars64.bat
  set QT_COMPILER=msvc2017_64
  goto CallVSBatch

: VS2019
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set COMPILER_VERSION=16
  set MAKETOOL=jom
  REM set MAKETOOL=nmake
  set QT_COMPILER=msvc2017_64
  set PATH=%PATH%;%JOM_DIR%
    
  SET TOOLSET=v142
  set GENERATOR=Visual Studio %COMPILER_VERSION%
  SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat
  set QT_COMPILER=msvc2017_64
  goto CallVSBatch

  : Borland
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set MAKETOOL=make
  REM set PATH=%PATH%;B:/Programs/Jom_1_0_14
  
  set GENERATOR=Borland Makefiles
  set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_CXX_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
  set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_CXX_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
  goto CompilerEnd
   
: VisualStudio  
  if not "%TARGET_PLATFORM:64=!!%"=="%TARGET_PLATFORM%" goto VS20xx_x64
: VS20xx_x32
  set GENERATOR=Visual Studio %COMPILER_VERSION%
  SET VS_BATCH=%VSCOMMONTOOLS:Common7\Tools\=VC\bin\vcvars32.bat%
  goto CallVSBatch
: VS20xx_x64
  set GENERATOR=Visual Studio %COMPILER_VERSION% Win64
  SET VS_BATCH=%VSCOMMONTOOLS:Common7\Tools\=VC\bin\x86_amd64\vcvarsx86_amd64.bat%
  goto CallVSBatch
: CallVSBatch  
  echo call VS_BATCH = "%VS_BATCH%"
  call "%VS_BATCH%"
  REM pause
goto CompilerEnd
: NoCompiler

  echo No Compiler defined
  pause 
  exit 1

: CompilerEnd


:: MySQL ist derzeit nicht aktiv!
:: set PATH=%PATH%;Q:\MySQL32\lib\opt

  REM 
set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Release 
rem set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Debug
REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DTARGET_PLATFORM=%TARGET_PLATFORM%
REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DPROJECT_NAME=%PROJECT_NAME%
set CMAKE_DEFINES=%CMAKE_DEFINES% -DPROJECT_NAME=%PROJECT_NAME%_%COMPILER%_Qt%QT_VERSION%
REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DSOLUTION_NAME=%PROJECT_NAME%_%COMPILER%
REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DSOLUTION_NAME=%PROJECT_NAME%_%COMPILER%_Qt%QT_VERSION%
rem set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_PREFIX_PATH=%QT_DIR:\=/%/%QT_COMPILER%


set CMAKE_PREFIX_PATH=%Boost_ROOT:\=/%
REM  if defined CMAKE_PREFIX_PATH set CMAKE_PREFIX_PATH=D:\link_libs\boost\boost-1_70_0-win-x86_64-msc_19.1-all

REM if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBoost_DIR=%Boost_ROOT%/lib/cmake/Boost-1.70.0
REM if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBOOST_ROOT=%Boost_ROOT%
REM if defined GoogleTest_DIR set CMAKE_DEFINES=%CMAKE_DEFINES% -DGoogleTest_DIR=%GoogleTest_DIR%
if defined GTest_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DGTest_ROOT=%GTest_ROOT:\=/%
if defined MySQL_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DMySQL_DIR=%MySQL_ROOT:\=/%
if defined OpenCV_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DOpenCV_DIR=%OpenCV_DIR:\=/%
:: das geht so nicht! if defined Qt5_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DQt5_ROOT=%Qt5_ROOT:\=/%/android
if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBoost_ROOT=%Boost_ROOT:\=/%

:::::::::::::::  Qt-Part ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM set Qtx_DIR=%QT_ROOT%/%QT_VERSION%/%QT_COMPILER%/lib
set Qt5_DIR=%QT_ROOT%/%QT_VERSION%/%QT_COMPILER%/lib/cmake/Qt5
if defined OpenCV_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DOpenCV_DIR=%OpenCV_ROOT%
:::::::::::::::  Qt-Part ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
IF DEFINED TOOLSET SET CMAKE_DEFINES=%CMAKE_DEFINES% -T%TOOLSET%
set CMAKE_DEFINES=%CMAKE_DEFINES% -Wno-dev
:: ===============================================================
echo SOURCE_DIR = %SOURCE_DIR%
echo CURR_DIR   = %CD%

REM set BUILD_DIR=%BINARY_DIR%\%SOLUTION_NAME%_x%TARGET_PLATFORM%
set BUILD_DIR=%BINARY_DIR%\%PROJECT_NAME%_x%TARGET_PLATFORM%_%COMPILER%
echo BUILD_DIR	= %BUILD_DIR%
if exist %BUILD_DIR% rmdir %BUILD_DIR% /S /Q

mkdir %BUILD_DIR%
pushd %BUILD_DIR%

  if NOT "%SOURCE_DIR%"=="%CD%" goto Create

  echo MkDir %BUILD_DIR% fehlgeschlagen??

  goto CreateEnd

: Create
echo Target-Dir: %CD%

REM pause

set SOURCE_DIR=%SOURCE_DIR:\=/%

if exist CMakeCache.txt del CMakeCache.txt
set CMAKE_COMMAND=cmake "%SOURCE_DIR%" -G "%GENERATOR%"%CMAKE_DEFINES%
echo %CMAKE_COMMAND%
REM pause
%CMAKE_COMMAND% 
 REM > CMakeCreateFlaps.txt
rem cmake -G "MinGW Makefiles" --build "C:\Projects\Baumer\GenICam\trunk"  
: CreateEnd

popd

@if errorlevel 1 goto CreationError

:CreationOk

pause
REM REM REM REM 
start cmake --open %BUILD_DIR%
exit /B 0

:CreationError
echo %BUILD_DIR%\%SOLUTION_NAME%.sln not exist!?!
echo Error during CMake creation "Flaps" (errorlevel = %ERRORLEVEL%)
pause