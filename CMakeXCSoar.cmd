@echo OFF

REM Am 05.10.2019 aktuell!

cd /D %~dp0
if not defined PROJECT_NAME for %%A in ("%CD%") do (Set PROJECT_NAME=%%~nxA)
REM if not defined PROJECT_NAME  set PROJECT_NAME=XCSoarAug
echo start CMake %PROJECT_NAME% - a XCSoar-Fork for Windows!

if not defined SOURCE_DIR  set SOURCE_DIR=%CD%
if not defined BINARY_DIR set BINARY_DIR=D:\Projects\Binaries
if not defined TARGET_PLATFORM  set TARGET_PLATFORM=64
if not defined THIRD_PARTY set THIRD_PARTY=D:\Projects\3rdParty
if not defined LINK_LIBS set LINK_LIBS=D:\link_libs
if not defined COMPILER  set COMPILER=VS2019
if not defined PROGRAM_DIR  set PROGRAM_DIR=D:\Programs
if not defined QT_ROOT set QT_ROOT=%THIRD_PARTY%\qt
if not defined Boost_ROOT set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0

REM  echo %PATH:CMake=XXXX%
rem if "%PATH%" == "%PATH:CMake=XXXX%" PATH=%PROGRAM_DIR%\CMake\bin;%PATH% & echo Added CMake to PATH!!
REM echo %PATH%
cmake --version
REM echo CMake version & pause

REM if errorlevel 1 PATH = %PROGRAM_DIR%\CMake\bin;%PATH%
REM cmake --version
if errorlevel 1 echo ERRORLEVEL = %ERRORLEVEL% & goto CMakeFoundError
REM pause

if exist CMakeCache.txt del CMakeCache.txt
if exist cmake_install.cmake del cmake_install.cmake
if exist Makefile del Makefile
if exist CMakeFiles rmdir  CMakeFiles  /S /Q

goto %COMPILER%
:MinGW73
  echo Im Compiler 'MinGW-Pfad (version7.30)'
  set TOOLCHAIN=mgw73
  REM set MINGW_DIR=D:\Projects\3rd_Party\qt\Qt5.14.0\Tools\mingw730_64
  set MINGW_DIR=%PROGRAM_DIR%\MinGW\mgw73
  set COMPILER_HOME=%MINGW_DIR%\bin
  set MAKETOOL=mingw32-make
  REM if "%PATH%" == "%PATH:mingw=XXXX%" PATH=%PROGRAM_DIR%\CMake\bin;%PATH% & echo CMake!!
  PATH=%COMPILER_HOME%;%PATH%
  REM PATH & pause
  set GENERATOR=MinGW Makefiles
  rem set GENERATOR=Eclipse CDT4 - MinGW Makefiles
  REM set Boost_ROOT=%BOOST_ROOT%\mgw73
goto CompilerEnd

:MinGW
:MinGW82
  echo Im Compiler 'MinGW-Pfad'
  set TOOLCHAIN=mgw82
  set MINGW_DIR=%PROGRAM_DIR%\MinGW\mgw82
  set COMPILER_HOME=%MINGW_DIR%\bin
  set MAKETOOL=mingw32-make
  PATH=%COMPILER_HOME%;%PATH%
  PATH
  REM pause
  set GENERATOR=MinGW Makefiles
  rem set GENERATOR=Eclipse CDT4 - MinGW Makefiles
  REM if not defined Boost_ROOT set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0\mgw73
  REM set Boost_ROOT=%BOOST_ROOT%\mgw82
  set TOOLCHAIN=mgw82
goto CompilerEnd

: VS2013
if not "%COMPILER%"=="VS2013"  goto VS2015
echo Im Compiler 'VS2013-Pfad'
  set TOOLCHAIN=mscv2013
  set VSCOMMONTOOLS=%VS120COMNTOOLS%
  set COMPILER_VERSION=12
  set MAKETOOL=jom
  set PATH=%PATH%;c:/Programs/Jom_1_0_14
  goto VisualStudio
: VS2015   
if not "%COMPILER%"=="VS2015"  goto NoCompiler
echo Im Compiler 'VS2015-Pfad'
  set TOOLCHAIN=mscv2015
  set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set COMPILER_VERSION=14
  rem set MAKETOOL=jom
  set MAKETOOL=nmake
  set PATH=%PATH%;c:/Programs/Jom_1_0_14
  set Boost_ROOT=%BOOST_ROOT%\msvc2015
  goto VisualStudio
  
: VS2017
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set TOOLCHAIN=mscv2017
  set COMPILER_VERSION=15
  set MAKETOOL=jom
  REM set MAKETOOL=nmake
  set QT_COMPILER=msvc2017_64
  set PATH=%PATH%;%JOM_DIR%
    
  SET TOOLSET=v141
  set GENERATOR=Visual Studio %COMPILER_VERSION% Win64
  SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars64.bat
  set QT_COMPILER=msvc2017_64
  REM set Boost_ROOT=%BOOST_ROOT%\msvc2017
  goto CallVSBatch

: VS2019
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set TOOLCHAIN=mscv2019
  set COMPILER_VERSION=16
  set MAKETOOL=jom
  REM set MAKETOOL=nmake
  set QT_COMPILER=msvc2017_64
  set PATH=%PATH%;%JOM_DIR%
    
  SET TOOLSET=v142
  set GENERATOR=Visual Studio %COMPILER_VERSION%
  SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat
  set QT_COMPILER=msvc2017_64
  REM set Boost_ROOT=%BOOST_ROOT%\msvc2019
  goto CallVSBatch

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

  : Borland
  REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
  set MAKETOOL=make
  REM set PATH=%PATH%;B:/Programs/Jom_1_0_14
  
  set GENERATOR=Borland Makefiles
  REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_C_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
  REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_CXX_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
  goto CompilerEnd

: NoCompiler

  echo No Compiler defined
  pause 
  exit 1

: CompilerEnd
REM echo CompilerEnd & pause
echo CompilerEnd

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
if defined THIRD_PARTY set CMAKE_DEFINES=%CMAKE_DEFINES% -DTHIRD_PARTY=%THIRD_PARTY:\=/%
if defined LINK_LIBS set CMAKE_DEFINES=%CMAKE_DEFINES% -DLINK_LIBS=%LINK_LIBS:\=/%
if defined TOOLCHAIN set CMAKE_DEFINES=%CMAKE_DEFINES% -DTOOLCHAIN=%TOOLCHAIN%

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

if exist %BUILD_DIR%/CMakeCache.txt del %BUILD_DIR%/CMakeCache.txt /Q
REM if exist %BUILD_DIR% rmdir %BUILD_DIR% /S /Q

if not exist %BUILD_DIR% mkdir %BUILD_DIR%
pushd %BUILD_DIR%

  if NOT "%SOURCE_DIR%"=="%CD%" goto Create

  echo MkDir %BUILD_DIR% fehlgeschlagen??

  goto CreateEnd

: Create
echo Target-Dir: %CD%

REM pause

set SOURCE_DIR=%SOURCE_DIR:\=/%

if exist CMakeCache.txt del CMakeCache.txt
set CMAKE_COMMAND=cmake "%SOURCE_DIR%" -G "%GENERATOR%" %CMAKE_DEFINES%
echo %CMAKE_COMMAND%
REM pause
%CMAKE_COMMAND% 
 REM > CMakeCreateFlaps.txt
rem cmake -G "MinGW Makefiles" --build "C:\Projects\Baumer\GenICam\trunk"  
: CreateEnd

popd

@if errorlevel 1 goto CreationError

:CreationOk

REM REM REM REM 
if not "%COMPILER:~0,2%" == "VS" goto NOT_VS

pause
start cmake --open %BUILD_DIR%
exit /B 0

: NOT_VS
echo Build Project 'XCSoar'
call  cmake --build %BUILD_DIR%
pause
exit /B 0

:CreationError
echo %BUILD_DIR%\%SOLUTION_NAME%.sln not exist!?!
echo Error during CMake creation "Flaps" (errorlevel = %ERRORLEVEL%)
pause
exit /B 0

:CMakeFoundError
echo Error: CMake not found?
PATH=%PROGRAM_DIR%\CMake\bin;%PATH%
echo %PATH%
cmake --version
REM if errorlevel 1 PATH = %PROGRAM_DIR%\CMake\bin;%PATH%
REM cmake --version
pause
exit /B 0


