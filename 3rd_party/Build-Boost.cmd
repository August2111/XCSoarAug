@echo off

set TOOLSET=clang
set TOOLSETNAME=clang10
set LINK_LIBS=D:/link_libs
set LIB_TARGET_NAME=boost
set TARGET_CNAME=BOOST
set BOOST_VERSION=1.73.0
set XCSOAR_BOOST_VERSION=boost-%BOOST_VERSION%
set BOOST_INSTALL_DIR=%LINK_LIBS%/boost/%XCSOAR_BOOST_VERSION%

set XCSOAR_%TARGET_CNAME%_VERSION=%LIB_TARGET_NAME%-%BOOST_VERSION%

PATH=D:\Programs\llvm\bin;%PATH%

cd /D D:\Projects\3rd_Party\cmake\boost\boost-1.73.0\src\boost

set BOOST_CMD=b2 -j4 toolset=%TOOLSET% link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=%LINK_LIBS%/boost/%XCSOAR_BOOST_VERSION% --build-dir=D:/Projects/3rd_Party/%LIB_TARGET_NAME%/build/%TOOLSETNAME% --with-chrono --with-system --with-filesystem --with-headers --with-regex --with-date_time  --includedir=%LINK_LIBS%/%LIB_TARGET_NAME%/%XCSOAR_BOOST_VERSION%/include --libdir=%LINK_LIBS%/%LIB_TARGET_NAME%/%XCSOAR_BOOST_VERSION%/lib/%TOOLSETNAME% install
echo %BOOST_CMD%
pause

%BOOST_CMD%
pause