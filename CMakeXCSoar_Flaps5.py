#!/usr/bin/env python3

import os, sys

### xcsoar download: # the path to the XCSoar sources
### xcsoar download: xcsoar_path = os.path.abspath(os.path.join(os.path.dirname(sys.argv[0]) or '.', '..'))
### xcsoar download: sys.path[0] = os.path.join(xcsoar_path, 'build/python')
### xcsoar download: 
### xcsoar download: from build.download import download_and_verify
### xcsoar download: 
### xcsoar download: if len(sys.argv) != 5:
### xcsoar download:     print("Usage: download.py URL ALTERNATIVE_URL MD5 DIRECTORY", file=sys.stderr)
### xcsoar download:     sys.exit(1)
### xcsoar download: 
### xcsoar download: download_and_verify(*sys.argv[1:])
### xcsoar download: 

# REM Am 19.03.2020 aktuell!
print('CMakeXCSoar_Flaps5.py')
print(os.getcwd())
if len(sys.argv) > 1:
	print(sys.argv[1])
	os.chdir(sys.argv[1])              ## batch: cd /D %~dp0
	print(os.getcwd())
else:
	print('No Parameter!')

## batch: set SOURCE_DIR=%CD%
## batch: set BINARY_DIR=D:\Projects\Binaries
## batch: set TARGET_PLATFORM=64
## batch: set THIRD_PARTY=D:/Projects/3rd_Party
## batch: set COMPILER=VS2019
## batch: set PROGRAM_DIR=D:\Programs
## batch: set Boost_ROOT=%THIRD_PARTY%\boost\boost_1_72_0\vc142
## batch: set QT_ROOT=%THIRD_PARTY%/qt
## batch: call CMakeXCSoar.cmd
