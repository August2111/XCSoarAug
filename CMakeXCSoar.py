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
  global prev_batch
  if sys.platform.startswith('win'):
      if toolchain == 'ninja':
        prev_batch = 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/VC/Auxiliary/Build/vcvars64.bat'
        # env_path = 'D:\\Programs\\MinGW\\mgw73\\bin;' + env_path
        # env_path = 'D:\\Programs\\Android\\SDK\\ndk\\21.0.6113669\\toolchains\\llvm\\prebuilt\\windows-x86_64\\bin;' + env_path
        # env_path = 'D:\\Programs\\Android\\SDK\\ndk\\21.0.6113669\\toolchains\\llvm\\prebuilt\\windows-x86_64\\bin;' + env_path
        env_path = 'D:\\Programs\\llvm\\bin;' + env_path
        cmake_generator ='Ninja'
      else:
        env_path = 'D:\\Programs\\MinGW\\' + toolchain +'\\bin;' + env_path
        cmake_generator ='MinGW Makefiles'
  else:
      # cmake_generator ='Unix Makefiles'
      prev_batch = 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/VC/Auxiliary/Build/vcvars64.bat'
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
    if os.path.isfile(build_dir+ '/CMakeCache.txt'):
      os.remove(build_dir+ '/CMakeCache.txt')
    arguments = []
    # if prev_batch:
       # arguments.append(prev_batch)
       # arguments.append(' & ')
    arguments.append(cmake_exe)  # 'cmake')                         ## Clang!
    if toolchain == 'ninja':                                          ## Clang!
      arguments.append('-E env LDFLAGS="-fuse-ld=lld-link"')          ## Clang!
      arguments.append('PATH="D:\\Programs\\CMake\\bin"')          ## Clang!
      my_env['PATH'] = 'D:/Programs/llvm/bin;' + my_env['PATH']          ## Clang!
      my_env['PATH'] = 'D:/Programs/CMake/bin'  #  + my_env['PATH']          ## Clang!
      arguments.append(cmake_exe)  # 'cmake')
      arguments.append('-H.')  ## Clang!
    arguments.append('-S')
    arguments.append(src_dir)  # curr_dir.replace('\\', '/'))
    arguments.append('-B')
    arguments.append(build_dir)
    # ? arguments.append('-G')
    ### arguments.append('"' + toolchain['cmake_generator'] + '"') 
    # ? arguments.append('"MinGW Makefiles"') 
    # arguments.append('-G "Ninja"') 
    arguments.append('-G "' + cmake_generator + '"') 

    if toolchain == 'ninja':
      arguments.append('-DCMAKE_C_COMPILER=D:/Programs/llvm/bin/clang.exe')
      arguments.append('-DCMAKE_CXX_COMPILER=D:/Programs/llvm/bin/clang++.exe')

    arguments.append('-DTOOLCHAIN=' + toolchain)
    arguments.append('-DBoost_ROOT=' + link_libs + '/boost/boost_1_72_0')
    arguments.append('-DTHIRD_PARTY=' + third_party)
    arguments.append('-DLINK_LIBS=' + link_libs)
    # arguments.append('-DCMAKE_C_COMPILER_ID="Clang"')  ## Clang!
    # arguments.append('-DCMAKE_CXX_COMPILER_ID="Clang"')  ## Clang!
    # arguments.append('-DCMAKE_SYSTEM_NAME="Generic"')  ## Clang!
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
  if creation & 0x08:   # ==>Run
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

