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

def mingw(toolchain, env):
  global cmake_generator
  global prev_batch
  
  # env_path = env['PATH']
  # if sys.platform.startswith('win'):
  #     if toolchain == 'ninja':
  #       prev_batch = 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/VC/Auxiliary/Build/vcvars64.bat'
  #       # env_path = 'D:\\Programs\\MinGW\\mgw73\\bin;' + env_path
  #       # env_path = 'D:\\Programs\\Android\\SDK\\ndk\\21.0.6113669\\toolchains\\llvm\\prebuilt\\windows-x86_64\\bin;' + env_path
  #       # env_path = 'D:\\Programs\\Android\\SDK\\ndk\\21.0.6113669\\toolchains\\llvm\\prebuilt\\windows-x86_64\\bin;' + env_path
  #       env_path = 'D:\\Programs\\llvm\\bin;' + env_path
  #       cmake_generator ='Ninja'
  #     else:
  #       if env['COMPUTERNAME'] == 'FLAPS5':
  #         env_path = 'D:\\Programs\\MinGW\\' + toolchain +'\\bin;' + env_path
  #       elif env['COMPUTERNAME'] == 'PCDERAD0781':
  #         env_path = 'D:\\link_libs\\Qt\\Qt5.14.0\\Tools\\mingw730_64\\bin;'  + env_path
  #       cmake_generator ='MinGW Makefiles'
  #    env_path = 'D:\\Programs\\MinGW\\' + toolchain +'\\bin;' + env_path
  #    cmake_generator ='MinGW Makefiles'
  # else:
  #     # cmake_generator ='Unix Makefiles'
  #     cmake_generator ='Ninja'
  cmake_generator ='MinGW Makefiles'
  return 'D:\\Programs\\MinGW\\' + toolchain + '\\bin;' + env['PATH']

def clang(toolchain, env):
  global cmake_generator
  if sys.platform.startswith('win'):
      env_path = 'D:\\Programs\\llvm\\bin;D:\\Programs\\CMake\\bin;'
  # else:
      # cmake_generator ='Unix Makefiles'
  cmake_generator ='Ninja'
  #  return 'D:\\Programs\\llvm\\bin;' + env['PATH']
  return env_path

def visual_studio(toolchain, env):
  global prev_batch, cmake_generator
  prev_batch = 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/VC/Auxiliary/Build/vcvars64.bat'
  cmake_generator ='Visual Studio 16'
  return env['PATH']

  # map the inputs to the function blocks
compiler_setup = {
           'mgw73' : mingw,
           'mgw82' : mingw,
           'ninja' : mingw,
           'clang10' : clang,
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
    if my_env['COMPUTERNAME'] == 'PCDERAD0781':
       build_dir = 'D:/build_ws/XCSoarAug/' + toolchain
    else:
       build_dir = 'D:/Projects/Binaries/XCSoarAug/' + toolchain

    link_libs = 'D:/link_libs'  # Windows!
    third_party = 'D:/Projects/3rd_Party'  # Windows!
    install_dir = 'D:/Programs/Install/XCSoar'
    program_dir = 'D:/Programs'
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
  try:
    myprocess = subprocess.Popen(['python3', '--version'], env = my_env)
    myprocess.wait()
  except:
    print('"python3" not callable')

  cmake_exe = (program_dir  + '/CMake/bin/') + 'cmake.exe'
  if sys.platform.startswith('win'):
    my_env['PATH'] =  (program_dir  + '/CMake/bin;').replace('/', '\\') + my_env['PATH']

  try:
    myprocess = subprocess.Popen([cmake_exe, '--version'], env = my_env)
  except:
    print('"cmake" not callable!')
    creation = 0

  if not os.path.exists(build_dir):
    os.makedirs(build_dir)
    creation = creation | 1

  my_env['PATH'] = compiler_setup[toolchain](toolchain, my_env)
  print(my_env['PATH'])
  #  test = my_env['PATH']
  #  compiler_setup[args[1]](args[1], test)
  #  print(test)

  if prev_batch:
    print(prev_batch)
  #========================================================================
  if creation & 1:
    if os.path.isfile(build_dir+ '/CMakeCache.txt'):
      os.remove(build_dir+ '/CMakeCache.txt')
    arguments = []
    # if prev_batch:
       # arguments.append(prev_batch)
       # arguments.append(' & ')
    arguments.append(cmake_exe)
    # if toolchain in ['clang10']:                                          ## Clang!
    #   my_env['PATH'] = 'D:/Programs/llvm/bin;'          ## Clang!
    #   my_env['PATH'] = my_env['PATH'] + 'D:/Programs/CMake/bin;'      ## Clang!
    #   arguments.append(cmake_exe)  # 'cmake')
    #   arguments.append('-H.')  ## Clang!
    arguments.append('-S')
    arguments.append(src_dir)  # curr_dir.replace('\\', '/'))
    arguments.append('-B')
    arguments.append(build_dir)
    # ? arguments.append('-G')
    ### arguments.append('"' + toolchain['cmake_generator'] + '"') 
    # ? arguments.append('"MinGW Makefiles"') 
    # arguments.append('-G "Ninja"') 
    arguments.append('-G "' + cmake_generator + '"') 
    arguments.append('--debug-trycompile')

    if toolchain in ['ninja', 'clang10']:
      arguments.append('-DCMAKE_C_COMPILER=D:/Programs/llvm/bin/clang.exe')
      arguments.append('-DCMAKE_CXX_COMPILER=D:/Programs/llvm/bin/clang++.exe')
      arguments.append('-DCMAKE_C_COMPILER_ID=clang')
      arguments.append('-DCMAKE_CXX_COMPILER_ID=clang')

    arguments.append('-DTOOLCHAIN=' + toolchain)
    arguments.append('-DBOOST_ROOT=' + link_libs + '/boost/boost_1_73_0')
    # arguments.append('-DBOOST_ROOT=' + link_libs + '/boost/boost_1_72_0/' + toolchain)  # PCDERAD0781
    arguments.append('-DTHIRD_PARTY=' + third_party)
    arguments.append('-DLINK_LIBS=' + link_libs)

    # MinGW fehler: arguments.append('-DCMAKE_TOOLCHAIN_FILE:PATH=D:/toolchain.cmake')
    ### if 0:
    ###   arguments.append('-DGTest_ROOT=')
    ###   arguments.append('-DMySQL_DIR=')
    ###   arguments.append('-DOpenCV_DIR=')

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
      try:
        myprocess = subprocess.call(my_cmd, env = my_env, shell = False)
      except:
        print('error on "subprocess.call"')
      if myprocess != 0:
        creation = 0
        print('cmd with failure!')
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
      print('========================================')
      print('========================================')
      print(my_env['PATH'])
      print('========================================')
      print('========================================')
      myprocess = subprocess.call(my_cmd, env = my_env, shell = False)
      if myprocess != 0:
        creation = 0
        print('cmd with failure!')
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
      if myprocess != 0:
        creation = 0
        print('cmd with failure!')
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()

  #========================================================================
  if creation & 0x08:   # ==>Run
    arguments = [build_dir + '/XCSoarAug.exe', '-1200x800']
    # arguments = ['XCSoarAug.exe', '-120x800']
    if with_call:
      my_cmd = ''
      for arg in arguments:
        my_cmd = my_cmd + arg + ' '
      print(my_cmd, ' in ', build_dir)

      myprocess = subprocess.call(my_cmd, env = my_env, cwd = build_dir, shell = False)
      if myprocess != 0:
        creation = 0
        print('cmd with failure!')
    else:
      myprocess = subprocess.Popen(arguments, env = my_env, shell = False)
      myprocess.wait()

