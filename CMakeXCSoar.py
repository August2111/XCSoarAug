#!/usr/bin/env python3

import os, sys, subprocess

# Am 19.03.2020 aktuell!
# Am 16.04.2020 cmd2py angefangen!

# if len(sys.argv) > 1:
#   print(sys.argv[1])
#   os.chdir(sys.argv[1])              ## batch: cd /D %~dp0
#   print(os.getcwd())
# else:
#   print('No Parameter!')

# my_env = []  # global!
# my_env = os.environ.copy()

prev_batch = None
cmake_generator = None

def mingw(toolchain, env_path):
  global cmake_generator
  if sys.platform.startswith('win'):
      if toolchain == 'ninja':
        env_path = 'D:\\Programs\\MinGW\\mgw73\\bin;' + env_path
      else:
        env_path = 'D:\\Programs\\MinGW\\' + toolchain +'\\bin;' + env_path
      cmake_generator ='MinGW Makefiles'
  else:
      # cmake_generator ='Unix Makefiles'
      cmake_generator ='Ninja'
  # print(env_path)
  return env_path

def visual_studio(toolchain, env_path):

  global prev_batch, cmake_generator
  prev_batch = 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/VC/Auxiliary/Build/vcvars64.bat'
  cmake_generator ='Visual Studio 16'
  return env_path
  # map the inputs to the function blocks
compiler_setup = {
           'mgw73' : mingw,
           'mgw82' : mingw,
           'ninja' : mingw,
           'msvc2019' : visual_studio,
}

def create_xcsoar(args):
  #Current directory:
  filename = sys.argv[0]
  start_dir = os.path.dirname(filename)
  if len(start_dir) == 0:
     # start_dir = ''
     start_dir = os.getcwd()
  # print('Filename: ', filename)  # 'CMakeXCSoar_Flaps5.py')
  print('Start CMake Creation of ', args[0])
  print('====================================\n')
  print(os.getcwd())
  
  my_env = os.environ.copy()
  verbose = 0
  if True: # False: # 
    i = 0
    for arg in args:   # sys.argv:
      print(i, ': ', arg)
      i = i + 1
    if verbose:
      print('Debug-Stop')
      os.system("pause")

  toolchain = args[1]
  if sys.platform.startswith('win'):
    # not necessary ?! install_bindir = 'bin'
    src_dir = start_dir
    #build_dir = 'D:/Projects/Binaries/XCSoarAug_x64_MinGW73'
    # build_dir = 'D:/Projects/Binaries/XCSoarAug/MinGW73'
    # build_dir = 'D:/Projects/Binaries/XCSoarAug/ninja'
    build_dir = 'D:/Projects/Binaries/XCSoarAug/' + toolchain
    # build_dir = 'D:/Projects/Binaries/XCSoarAug/MinGW73_32'

    link_libs = 'D:/link_libs'  # Windows!
    third_party = 'D:/Projects/3rd_Party'  # Windows!
    install_dir = 'D:/Programs/Install/XCSoar'
  else:
    src_dir = start_dir
    build_dir = '/home/august/Projects/Binaries/XCSoarAug/' + toolchain
    link_libs = '/home/august/Projects/link_libs'  
    third_party = '/home/august/Projects/3rd_Party'
    install_dir = '/home/august/Projects/Install/XCSoar'

  with_call = 1
  creation = 15
  toolset = None

  myprocess = subprocess.Popen(['python', '--version'], env = my_env)
  myprocess.wait()

  myprocess = subprocess.Popen(['python3', '--version'], env = my_env)
  myprocess.wait()

  cmake_exe = 'cmake'

  try:
    myprocess = subprocess.Popen([cmake_exe, '--version'], env = my_env)
  except:
    pass

  if not os.path.exists(build_dir):
    os.makedirs(build_dir)
    creation = creation | 1

  my_env['PATH'] = compiler_setup[toolchain](toolchain, my_env['PATH'])
  print(my_env['PATH'])
  #  test = my_env['PATH']
  #  compiler_setup[args[1]](args[1], test)
  #  print(test)

  if prev_batch:
    print(prev_batch)
  #========================================================================
  if creation & 1:
    arguments = []
    if prev_batch:
       arguments.append(prev_batch)
       arguments.append(' & ')
    arguments.append(cmake_exe)  # 'cmake')
    arguments.append('-S')
    arguments.append(src_dir)  # curr_dir.replace('\\', '/'))
    arguments.append('-B')
    arguments.append(build_dir)
    # ? arguments.append('-G')
    ### arguments.append('"' + toolchain['cmake_generator'] + '"') 
    # ? arguments.append('"MinGW Makefiles"') 
    # arguments.append('-G "Ninja"') 
    arguments.append('-G "' + cmake_generator + '"') 

    arguments.append('-DTOOLCHAIN=' + toolchain)
    arguments.append('-DBoost_ROOT=' + link_libs + '/boost/boost_1_72_0')
    arguments.append('-DTHIRD_PARTY=' + third_party)
    arguments.append('-DLINK_LIBS=' + link_libs)
  
    if 0:
      arguments.append('-DGTest_ROOT=')
      arguments.append('-DMySQL_DIR=')
      arguments.append('-DOpenCV_DIR=')

    arguments.append('-Wno-dev')

    arguments.append('-DCMAKE_INSTALL_PREFIX=' + install_dir)
    if not toolset is None:
      arguments.append('-T' + toolset)
    ### arguments.append('-DCMAKE_INSTALL_BINDIR=' + install_bindir)
  
  
    ###  try:
    ###    for cmake_def in project["cmake_definitions"]:
    ###      arguments.append(cmake_def)
    ###  except:
    ###      pass
  
    if with_call:
      my_cmd = ''
      for arg in arguments:
        my_cmd = my_cmd + arg + ' '
      print(my_cmd)
      print('========================================================================')
      myprocess = subprocess.call(my_cmd, env = my_env, shell = False)
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()

  #========================================================================
  if creation & 2:
  # Build with make
    arguments = []
    arguments.append(cmake_exe)  # 'cmake')
    arguments.append('--build')
    arguments.append(build_dir)
    arguments.append('--config')
    arguments.append('Release') 
    if with_call:
      my_cmd = ''
      for arg in arguments:
        my_cmd = my_cmd + arg + ' '
      print(my_cmd)
      myprocess = subprocess.call(my_cmd, env = my_env, shell = False)
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()
  
  #========================================================================
  if creation & 0x04:
    #Install
    arguments = []
    arguments.append(cmake_exe)  # 'cmake')
    arguments.append('--install')
    arguments.append(build_dir)
    if with_call:
      my_cmd = ''
      for arg in arguments:
        my_cmd = my_cmd + arg + ' '
      print(my_cmd)
      myprocess = subprocess.call(my_cmd, env = my_env, shell = False)
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()

  #========================================================================
  if creation & 0x08:
    # Run
    # arguments = []
    # my_cwd = build_dir
    arguments = [build_dir + '/XCSoarAug.exe', '-1200x800']
    # arguments = ['XCSoarAug.exe', '-120x800']
    if with_call:
      my_cmd = ''
      for arg in arguments:
        my_cmd = my_cmd + arg + ' '
      print(my_cmd, ' in ', build_dir)

      myprocess = subprocess.call(my_cmd, env = my_env, cwd = build_dir, shell = False)
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()

#   create_xcsoar(["Das ist ein Test","Arg1", "Arg2"])

# cmd2py @echo OFF
# cmd2py 
# cmd2py REM Am 05.10.2019 aktuell!
# cmd2py 
# cmd2py cd /D %~dp0
# cmd2py if not defined PROJECT_NAME for %%A in ("%CD%") do (Set PROJECT_NAME=%%~nxA)
# cmd2py REM if not defined PROJECT_NAME  set PROJECT_NAME=XCSoarAug
# cmd2py echo start CMake %PROJECT_NAME% - a XCSoar-Fork for Windows!
# cmd2py 
# cmd2py if not defined SOURCE_DIR  set SOURCE_DIR=%CD%
# cmd2py if not defined BINARY_DIR set BINARY_DIR=D:\Projects\Binaries
# cmd2py if not defined TARGET_PLATFORM  set TARGET_PLATFORM=64
# cmd2py if not defined THIRD_PARTY set THIRD_PARTY=D:\Projects\3rdParty
# cmd2py if not defined LINK_LIBS set LINK_LIBS=D:\link_libs
# cmd2py if not defined COMPILER  set COMPILER=VS2019
# cmd2py if not defined PROGRAM_DIR  set PROGRAM_DIR=D:\Programs
# cmd2py if not defined QT_ROOT set QT_ROOT=%THIRD_PARTY%\qt
# cmd2py if not defined Boost_ROOT set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0
# cmd2py 
# cmd2py REM  echo %PATH:CMake=XXXX%
# cmd2py rem if "%PATH%" == "%PATH:CMake=XXXX%" PATH=%PROGRAM_DIR%\CMake\bin;%PATH% & echo Added CMake to PATH!!
# cmd2py REM echo %PATH%
# cmd2py cmake --version
# cmd2py REM echo CMake version & pause
# cmd2py 
# cmd2py REM if errorlevel 1 PATH = %PROGRAM_DIR%\CMake\bin;%PATH%
# cmd2py REM cmake --version
# cmd2py if errorlevel 1 echo ERRORLEVEL = %ERRORLEVEL% & goto CMakeFoundError
# cmd2py REM pause
# cmd2py 
# cmd2py if exist CMakeCache.txt del CMakeCache.txt
# cmd2py if exist cmake_install.cmake del cmake_install.cmake
# cmd2py if exist Makefile del Makefile
# cmd2py if exist CMakeFiles rmdir  CMakeFiles  /S /Q
# cmd2py 
# cmd2py goto %COMPILER%
# cmd2py :MinGW73
# cmd2py   echo Im Compiler 'MinGW-Pfad (version7.30)'
# cmd2py   set TOOLCHAIN=mgw73
# cmd2py   set MINGW_DIR=D:\Projects\3rd_Party\qt\Qt5.14.0\Tools\mingw730_64
# cmd2py   REM set MINGW_DIR=%PROGRAM_DIR%\MinGW\mgw73
# cmd2py   set COMPILER_HOME=%MINGW_DIR%\bin
# cmd2py   set MAKETOOL=mingw32-make
# cmd2py   REM if "%PATH%" == "%PATH:mingw=XXXX%" PATH=%PROGRAM_DIR%\CMake\bin;%PATH% & echo CMake!!
# cmd2py   PATH=%COMPILER_HOME%;%PATH%
# cmd2py   REM PATH & pause
# cmd2py   set GENERATOR=MinGW Makefiles
# cmd2py   rem set GENERATOR=Eclipse CDT4 - MinGW Makefiles
# cmd2py   REM set Boost_ROOT=%BOOST_ROOT%\mgw73
# cmd2py goto CompilerEnd
# cmd2py 
# cmd2py :MinGW
# cmd2py :MinGW82
# cmd2py   echo Im Compiler 'MinGW-Pfad'
# cmd2py   set TOOLCHAIN=mgw82
# cmd2py   set MINGW_DIR=%PROGRAM_DIR%\MinGW\mgw82
# cmd2py   set COMPILER_HOME=%MINGW_DIR%\bin
# cmd2py   set MAKETOOL=mingw32-make
# cmd2py   PATH=%COMPILER_HOME%;%PATH%
# cmd2py   PATH
# cmd2py   REM pause
# cmd2py   set GENERATOR=MinGW Makefiles
# cmd2py   rem set GENERATOR=Eclipse CDT4 - MinGW Makefiles
# cmd2py   REM if not defined Boost_ROOT set Boost_ROOT=%LINK_LIBS%\boost\boost_1_72_0\mgw73
# cmd2py   REM set Boost_ROOT=%BOOST_ROOT%\mgw82
# cmd2py   set TOOLCHAIN=mgw82
# cmd2py goto CompilerEnd
# cmd2py 
# cmd2py : VS2013
# cmd2py if not "%COMPILER%"=="VS2013"  goto VS2015
# cmd2py echo Im Compiler 'VS2013-Pfad'
# cmd2py   set TOOLCHAIN=mscv2013
# cmd2py   set VSCOMMONTOOLS=%VS120COMNTOOLS%
# cmd2py   set COMPILER_VERSION=12
# cmd2py   set MAKETOOL=jom
# cmd2py   set PATH=%PATH%;c:/Programs/Jom_1_0_14
# cmd2py   goto VisualStudio
# cmd2py : VS2015   
# cmd2py if not "%COMPILER%"=="VS2015"  goto NoCompiler
# cmd2py echo Im Compiler 'VS2015-Pfad'
# cmd2py   set TOOLCHAIN=mscv2015
# cmd2py   set VSCOMMONTOOLS=%VS140COMNTOOLS%
# cmd2py   set COMPILER_VERSION=14
# cmd2py   rem set MAKETOOL=jom
# cmd2py   set MAKETOOL=nmake
# cmd2py   set PATH=%PATH%;c:/Programs/Jom_1_0_14
# cmd2py   set Boost_ROOT=%BOOST_ROOT%\msvc2015
# cmd2py   goto VisualStudio
# cmd2py   
# cmd2py : VS2017
# cmd2py   REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
# cmd2py   set TOOLCHAIN=mscv2017
# cmd2py   set COMPILER_VERSION=15
# cmd2py   set MAKETOOL=jom
# cmd2py   REM set MAKETOOL=nmake
# cmd2py   set QT_COMPILER=msvc2017_64
# cmd2py   set PATH=%PATH%;%JOM_DIR%
# cmd2py     
# cmd2py   SET TOOLSET=v141
# cmd2py   set GENERATOR=Visual Studio %COMPILER_VERSION% Win64
# cmd2py   SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars64.bat
# cmd2py   set QT_COMPILER=msvc2017_64
# cmd2py   REM set Boost_ROOT=%BOOST_ROOT%\msvc2017
# cmd2py   goto CallVSBatch
# cmd2py 
# cmd2py : VS2019
# cmd2py   REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
# cmd2py   set TOOLCHAIN=mscv2019
# cmd2py   set COMPILER_VERSION=16
# cmd2py   set MAKETOOL=jom
# cmd2py   REM set MAKETOOL=nmake
# cmd2py   set QT_COMPILER=msvc2017_64
# cmd2py   set PATH=%PATH%;%JOM_DIR%
# cmd2py     
# cmd2py   SET TOOLSET=v142
# cmd2py   set GENERATOR=Visual Studio %COMPILER_VERSION%
# cmd2py   SET VS_BATCH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat
# cmd2py   set QT_COMPILER=msvc2017_64
# cmd2py   REM set Boost_ROOT=%BOOST_ROOT%\msvc2019
# cmd2py   goto CallVSBatch
# cmd2py 
# cmd2py : VisualStudio  
# cmd2py   if not "%TARGET_PLATFORM:64=!!%"=="%TARGET_PLATFORM%" goto VS20xx_x64
# cmd2py : VS20xx_x32
# cmd2py   set GENERATOR=Visual Studio %COMPILER_VERSION%
# cmd2py   SET VS_BATCH=%VSCOMMONTOOLS:Common7\Tools\=VC\bin\vcvars32.bat%
# cmd2py   goto CallVSBatch
# cmd2py : VS20xx_x64
# cmd2py   set GENERATOR=Visual Studio %COMPILER_VERSION% Win64
# cmd2py   SET VS_BATCH=%VSCOMMONTOOLS:Common7\Tools\=VC\bin\x86_amd64\vcvarsx86_amd64.bat%
# cmd2py   goto CallVSBatch
# cmd2py : CallVSBatch  
# cmd2py   echo call VS_BATCH = "%VS_BATCH%"
# cmd2py   call "%VS_BATCH%"
# cmd2py   REM pause
# cmd2py goto CompilerEnd
# cmd2py 
# cmd2py   : Borland
# cmd2py   REM set VSCOMMONTOOLS=%VS140COMNTOOLS%
# cmd2py   set MAKETOOL=make
# cmd2py   REM set PATH=%PATH%;B:/Programs/Jom_1_0_14
# cmd2py   
# cmd2py   set GENERATOR=Borland Makefiles
# cmd2py   REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_C_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
# cmd2py   REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_CXX_COMPILER=C:/Programs/Embarcadero/BCC101/bin/bcc32c.exe 
# cmd2py   goto CompilerEnd
# cmd2py 
# cmd2py : NoCompiler
# cmd2py 
# cmd2py   echo No Compiler defined
# cmd2py   pause 
# cmd2py   exit 1
# cmd2py 
# cmd2py : CompilerEnd
# cmd2py REM echo CompilerEnd & pause
# cmd2py echo CompilerEnd
# cmd2py 
# cmd2py :: MySQL ist derzeit nicht aktiv!
# cmd2py :: set PATH=%PATH%;Q:\MySQL32\lib\opt
# cmd2py 
# cmd2py   REM 
# cmd2py set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Release 
# cmd2py rem set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_BUILD_TYPE=Debug
# cmd2py REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DTARGET_PLATFORM=%TARGET_PLATFORM%
# cmd2py REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DPROJECT_NAME=%PROJECT_NAME%
# cmd2py set CMAKE_DEFINES=%CMAKE_DEFINES% -DPROJECT_NAME=%PROJECT_NAME%_%COMPILER%_Qt%QT_VERSION%
# cmd2py REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DSOLUTION_NAME=%PROJECT_NAME%_%COMPILER%
# cmd2py REM set CMAKE_DEFINES=%CMAKE_DEFINES% -DSOLUTION_NAME=%PROJECT_NAME%_%COMPILER%_Qt%QT_VERSION%
# cmd2py rem set CMAKE_DEFINES=%CMAKE_DEFINES% -DCMAKE_PREFIX_PATH=%QT_DIR:\=/%/%QT_COMPILER%
# cmd2py 
# cmd2py 
# cmd2py set CMAKE_PREFIX_PATH=%Boost_ROOT:\=/%
# cmd2py REM  if defined CMAKE_PREFIX_PATH set CMAKE_PREFIX_PATH=D:\link_libs\boost\boost-1_70_0-win-x86_64-msc_19.1-all
# cmd2py 
# cmd2py REM if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBoost_DIR=%Boost_ROOT%/lib/cmake/Boost-1.70.0
# cmd2py REM if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBOOST_ROOT=%Boost_ROOT%
# cmd2py REM if defined GoogleTest_DIR set CMAKE_DEFINES=%CMAKE_DEFINES% -DGoogleTest_DIR=%GoogleTest_DIR%
# cmd2py if defined GTest_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DGTest_ROOT=%GTest_ROOT:\=/%
# cmd2py if defined MySQL_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DMySQL_DIR=%MySQL_ROOT:\=/%
# cmd2py if defined OpenCV_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DOpenCV_DIR=%OpenCV_DIR:\=/%
# cmd2py :: das geht so nicht! if defined Qt5_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DQt5_ROOT=%Qt5_ROOT:\=/%/android
# cmd2py if defined Boost_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DBoost_ROOT=%Boost_ROOT:\=/%
# cmd2py if defined THIRD_PARTY set CMAKE_DEFINES=%CMAKE_DEFINES% -DTHIRD_PARTY=%THIRD_PARTY:\=/%
# cmd2py if defined LINK_LIBS set CMAKE_DEFINES=%CMAKE_DEFINES% -DLINK_LIBS=%LINK_LIBS:\=/%
# cmd2py if defined TOOLCHAIN set CMAKE_DEFINES=%CMAKE_DEFINES% -DTOOLCHAIN=%TOOLCHAIN%
# cmd2py 
# cmd2py :::::::::::::::  Qt-Part ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# cmd2py REM set Qtx_DIR=%QT_ROOT%/%QT_VERSION%/%QT_COMPILER%/lib
# cmd2py set Qt5_DIR=%QT_ROOT%/%QT_VERSION%/%QT_COMPILER%/lib/cmake/Qt5
# cmd2py if defined OpenCV_ROOT set CMAKE_DEFINES=%CMAKE_DEFINES% -DOpenCV_DIR=%OpenCV_ROOT%
# cmd2py :::::::::::::::  Qt-Part ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# cmd2py IF DEFINED TOOLSET SET CMAKE_DEFINES=%CMAKE_DEFINES% -T%TOOLSET%
# cmd2py set CMAKE_DEFINES=%CMAKE_DEFINES% -Wno-dev
# cmd2py :: ===============================================================
# cmd2py echo SOURCE_DIR = %SOURCE_DIR%
# cmd2py echo CURR_DIR   = %CD%
# cmd2py 
# cmd2py REM set BUILD_DIR=%BINARY_DIR%\%SOLUTION_NAME%_x%TARGET_PLATFORM%
# cmd2py set BUILD_DIR=%BINARY_DIR%\%PROJECT_NAME%_x%TARGET_PLATFORM%_%COMPILER%
# cmd2py echo BUILD_DIR	= %BUILD_DIR%
# cmd2py 
# cmd2py if exist %BUILD_DIR%/CMakeCache.txt del %BUILD_DIR%/CMakeCache.txt /Q
# cmd2py REM if exist %BUILD_DIR% rmdir %BUILD_DIR% /S /Q
# cmd2py 
# cmd2py if not exist %BUILD_DIR% mkdir %BUILD_DIR%
# cmd2py pushd %BUILD_DIR%
# cmd2py 
# cmd2py   if NOT "%SOURCE_DIR%"=="%CD%" goto Create
# cmd2py 
# cmd2py   echo MkDir %BUILD_DIR% fehlgeschlagen??
# cmd2py 
# cmd2py   goto CreateEnd
# cmd2py 
# cmd2py : Create
# cmd2py echo Target-Dir: %CD%
# cmd2py 
# cmd2py REM pause
# cmd2py 
# cmd2py set SOURCE_DIR=%SOURCE_DIR:\=/%
# cmd2py 
# cmd2py if exist CMakeCache.txt del CMakeCache.txt
# cmd2py set CMAKE_COMMAND=cmake "%SOURCE_DIR%" -G "%GENERATOR%"%CMAKE_DEFINES%
# cmd2py echo %CMAKE_COMMAND%
# cmd2py REM pause
# cmd2py %CMAKE_COMMAND% 
# cmd2py  REM > CMakeCreateFlaps.txt
# cmd2py rem cmake -G "MinGW Makefiles" --build "C:\Projects\Baumer\GenICam\trunk"  
# cmd2py : CreateEnd
# cmd2py 
# cmd2py popd
# cmd2py 
# cmd2py @if errorlevel 1 goto CreationError
# cmd2py 
# cmd2py :CreationOk
# cmd2py 
# cmd2py REM REM REM REM 
# cmd2py if not "%COMPILER:~0,2%" == "VS" goto NOT_VS
# cmd2py 
# cmd2py pause
# cmd2py start cmake --open %BUILD_DIR%
# cmd2py exit /B 0
# cmd2py 
# cmd2py : NOT_VS
# cmd2py echo Build Project 'XCSoar'
# cmd2py call  cmake --build %BUILD_DIR%
# cmd2py pause
# cmd2py exit /B 0
# cmd2py 
# cmd2py :CreationError
# cmd2py echo %BUILD_DIR%\%SOLUTION_NAME%.sln not exist!?!
# cmd2py echo Error during CMake creation "Flaps" (errorlevel = %ERRORLEVEL%)
# cmd2py pause
# cmd2py exit /B 0
# cmd2py 
# cmd2py :CMakeFoundError
# cmd2py echo Error: CMake not found?
# cmd2py PATH=%PROGRAM_DIR%\CMake\bin;%PATH%
# cmd2py echo %PATH%
# cmd2py cmake --version
# cmd2py REM if errorlevel 1 PATH = %PROGRAM_DIR%\CMake\bin;%PATH%
# cmd2py REM cmake --version
# cmd2py pause
# cmd2py exit /B 0
# cmd2py 
# cmd2py 
# cmd2py 
