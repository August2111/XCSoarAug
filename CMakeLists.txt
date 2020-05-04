# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.10)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # important for folder structure f.e. in Visual Studio
# Setting Area ===================================================
include(ExternalProject)  # since 3.10

add_definitions(-DNDEBUG)  # wenn ohne Debug!!!!!!!!!!!!!!

# set(XCSOAR_LIB_TYPE SHARED)
set(XCSOAR_LIB_TYPE STATIC)
set(XCSOAR_LIB_TYPE WITHOUT)


# 3rd-party! 
set(XCSOAR_LUA_VERSION "lua-5.3.5")

set(ENABLE_OPENGL OFF)  # better outside????

# set(XCSOAR_CURL_VERSION "curl-7.64.1")  # curl-git")
set(XCSOAR_CURL_VERSION "curl-7.69.1")
add_definitions(-DCURL_STATICLIB)

# 3rd-party! 
set(XCSOAR_JASPER_VERSION "jasper-2.0.16")
# set(XCSOAR_JASPER_VERSION "JasPer-xcsoar)
# add_definitions(-DJAS_XCSOAR)

#  1>Terrain.lib(Loader.obj) : error LNK2019: Verweis auf nicht aufgelöstes externes Symbol "jas_stream_close" in Funktion ""bool __cdecl LoadTerrainOverview(struct zzip_dir *,char const *,char const *,class RasterTileCache &,bool,class OperationEnvironment &)" (?LoadTerrainOverview@@YA_NPEAUzzip_dir@@PEBD1AEAVRasterTileCache@@_NAEAVOperationEnvironment@@@Z)".
# 1>Terrain.lib(Loader.obj) : error LNK2019: Verweis auf nicht aufgelöstes externes Symbol "jas_stream_length" in Funktion ""bool __cdecl LoadTerrainOverview(struct zzip_dir *,char const *,char const *,class RasterTileCache &,bool,class OperationEnvironment &)" (?LoadTerrainOverview@@YA_NPEAUzzip_dir@@PEBD1AEAVRasterTileCache@@_NAEAVOperationEnvironment@@@Z)".

# set(XCSOAR_MAPSERVER_VERSION "mapserver-0.0.1")
set(XCSOAR_MAPSERVER_VERSION "mapserver-xcsoar")
# 3rd-party! 
# set(XCSOAR_ZLIB_VERSION "zlib-1.2.10")
set(XCSOAR_ZLIB_VERSION "zlib-1.2.11")
# set(XCSOAR_ZZIP_VERSION "zzip-0.0.1")
# set(XCSOAR_ZZIP_VERSION "zzip-0.36c")
set(XCSOAR_ZZIP_VERSION "zzip-xcsoar")
set(XCSOAR_LIBPNG_VERSION "libpng-1.6.37")

# cleanup 19.04.20: set(ASIO_GROUPING ON)

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

  project(${TARGET_NAME} C CXX) # Your project name

if (WIN32)
if (${TOOLCHAIN} STREQUAL "ninja")
  message(STATUS "Ninja!")
#  set(TOOLCHAIN "mgw73")
endif()
endif()

get_filename_component(PROJECTGROUP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} ABSOLUTE)
get_filename_component(PROJECTGROUP_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} ABSOLUTE)

message(STATUS "*** PROJECTGROUP_SOURCE_DIR = '${PROJECTGROUP_SOURCE_DIR}'")
message(STATUS "*** PROJECTGROUP_BINARY_DIR = '${PROJECTGROUP_BINARY_DIR}'")

set(SRC "${PROJECTGROUP_SOURCE_DIR}/src")
include(CMakeSource.cmake)
# message(FATAL_ERROR "Stop. !")

file(GLOB_RECURSE SCRIPT_FILES "*.txt;*.cmake;*.md")

if (WIN32 AND MSVC)
      message(STATUS "+++ System = WIN32 / MSVC!")
      if(NOT TOOLCHAIN)
        set(TOOLCHAIN msvc2019)
      endif()
      # add_compile_definitions(BOOST_ASIO_WORKAROUND=1)
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      add_compile_definitions(_AUG_MSC=1)
#      HAVE_HATCHED_BRUSH
      set(LIB_EXTENSION "lib")
      set(PRE_LIB "")

      # add_definitions("/ZW")
      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporary data!
      if (NOT THIRD_PARTY AND EXISTS "D:/Projects/3rd_Party")
        set(THIRD_PARTY "D:/Projects/3rd_Party")
      endif()
      if (NOT LINK_LIBS AND EXISTS "D:/link_libs")
        set(LINK_LIBS "D:/link_libs")
      endif()
      if (ON OR WIN64)  # momentan kein Flag verfügbar!
          add_compile_definitions(_AMD64_)
      else()
          message(FATAL_ERROR "Error: WIN32 not implemented?")
      endif()
      # LUA ist vermutlich besser im output ordner aufgehoben...

elseif(WIN32 AND MINGW)
      # Only MinGW / GCC:
      message(STATUS "+++ System = WIN32 / MinGW (${TOOLCHAIN})!")
      if(NOT TOOLCHAIN)
        set(TOOLCHAIN mgw73)
        # set(TOOLCHAIN mgw82)
        message(FATAL_ERROR "No Toolchain!")
      endif()
      set(LIB_EXTENSION "a")
      set(PRE_LIB "lib")

      set(Boost_COMPILER "${TOOLCHAIN}")  # necessary: changed mgw as boost compiler to mgw73!
      set(Boost_COMPILER "mgw7")  # necessary: changed mgw as boost compiler to mgw73!

      # if(${TOOLCHAIN}  STREQUAL mgw73)
      #   # include_directories("${THIRD_PARTY}/qt/Qt5.14.0/Tools/mingw730_64/x86_64-w64-mingw32/include")
      #   add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
      # endif()
      include_directories("D:/Programs/MinGW/${TOOLCHAIN}/include")
      # LUA ist vermutlich besser im output ordner aufgehoben...
      # include_directories("${THIRD_PARTY}/lua/lua-5.3.5/src")
      # include_directories("${THIRD_PARTY}/mapserver/mapserver-0")
      # include_directories("${THIRD_PARTY}/curl/${XCSOAR_CURL_VERSION}/include")
      # include_directories("${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/include")
      # include_directories("${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}/include")

      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporory data!

      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      add_compile_definitions(_UNICODE)
#      set(CMAKE_C_COMPILE_OBJECT "${CMAKE_C_COMPILER} -c <FLAGS> -o <OBJECT>")
#      set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

#    set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CSS_STANDARD_LIBRARIES}")
#    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive")

set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static -static-libstdc++ -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive -v")

elseif(WIN32 AND (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"))
      message(STATUS "+++ System = WIN32 / Clang!")
      if(NOT TOOLCHAIN)
        set(TOOLCHAIN clang)
      endif()
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      # add_compile_definitions(_AUG_MSC=1)
      set(LIB_EXTENSION "lib")
      set(PRE_LIB "")
      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporary data!
      if (ON OR WIN64)  # momentan kein Flag verfügbar!
          add_compile_definitions(_AMD64_)
      else()
          message(FATAL_ERROR "Error: WIN32 not implemented?")
      endif()
      set(Boost_DIR "${BOOST_ROOT}/lib/clang10/cmake/Boost-1.73.0")
    set(Boost_COMPILER "clang10")  # necessary: changed clang8 as boost compiler to clang!


elseif(WIN32 AND CLANG)
   message(FATAL_ERROR "+++ Unbekanntes System: CLANG!")
elseif(WIN32 AND NINJA)
   message(FATAL_ERROR "+++ Unbekanntes System: NINJA!")
elseif(UNIX)
      message(STATUS "+++ System = LINUX / GCC(?) (${TOOLCHAIN})!")
      
      set(LIB_EXTENSION "a")
      set(PRE_LIB "lib")

      # set(Boost_COMPILER "${TOOLCHAIN}")  # necessary: changed mgw as boost compiler to mgw73!
      # include_directories("D:/Programs/MinGW/${TOOLCHAIN}/include")
      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporory data!

      set(Boost_DIR "/home/august/Projects/link_libs/boost/boost_1_73_0/stage/lib/gcc/cmake/Boost-1.73.0")   
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)

      set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
      set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static -static-libstdc++ -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive -v")
      # message(FATAL_ERROR "+++ Jetzt bin ich im Linux: !")

elseif(ANDROID)
    message(STATUS "+++ System = ANDROID / ${ANDROID_ABI}!")
    set(Boost_COMPILER "clang")  # necessary: changed clang8 as boost compiler to clang!
else()
   message(FATAL_ERROR "+++ Unbekanntes System: ${CMAKE_SYSTEM}!")
endif()

    include_directories("    ${PROJECTGROUP_SOURCE_DIR}/src/IO")   # Util")  # nr wegen Logfile!

# 3rd Party !!!!
# if(MSVC)  # not in MinGW yet????
   add_subdirectory(3rd_party)
# endif()

# ALLE: ?
# interneal Project
#      include_directories("${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/include") # internal lib

# external Projects
      include_directories("${LINK_LIBS}/lua/${XCSOAR_LUA_VERSION}/include")
      include_directories("${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/include")
      include_directories("${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}/include")
      include_directories("${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/include") # for external
      include_directories("${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/include") # for external

# message(FATAL_ERROR "include_directories(${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/include)")

      include_directories("${LINK_LIBS}/libpng/libpng-1.6.37/include")  # neu am 27.03 wg. einbinden der PNG-Bilder aus der Resource
#      include_directories("${THIRD_PARTY}/glut/glut-3.7/include")  # neu am 27.03

#####################################################################################
#####################################################################################
# add_compile_definitions(USE_MEMORY_CANVAS)
add_compile_definitions(NOMINMAX)
add_compile_definitions(_AUG=1)
# nur einmal definieren!!! add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
add_compile_definitions("XCSOAR_VERSION=\"7.1\"")
# add_definitions(/std:c++11 /Zc:__cplusplus)
if(MSVC)
# add_compile_definitions(_X86_) #  _IA64_)
##  add_definitions(/std:c++14 /Zc:__cplusplus)
# TARGET_ARCHITECTURE: _AMD64_ _X86_ _IA64_ _ARM_ _ARM64_
endif()
# USE_MEMORY_CANVAS
# USE_GDI

if(ENABLE_OPENGL)
    # set(FreeGLUT_DIR ${LINK_LIBS}/glut/freeglut-3.2.1/lib/msvc2019/cmake/FreeGLUT)
    # find_package(FreeGLUT REQUIRED)
    find_package(OpenGL REQUIRED)
    
    if(NOT TARGET OpenGL::GLU)
        message(FATAL_ERROR "GLU could not be found")
    endif(NOT TARGET OpenGL::GLU)
    
    message(STATUS "glu: ${OPENGL_glu_LIBRARY}")
    
    get_target_property(GLU_IMPORTED_LIBNAME OpenGL::GLU IMPORTED_LIBNAME)
    message(STATUS "glu imported libname: ${GLU_IMPORTED_LIBNAME}")
    add_compile_definitions(ENABLE_OPENGL)
    add_compile_definitions(USE_WIN32_RESOURCES USE_WINUSER)

    include_directories(D:/Programs/Android/android-ndk-r21/sysroot/usr/include/GLES2)
    include_directories(${Boost_INCLUDE_DIR}/boost/compute/interop)

    # message(FATAL_ERROR "OpenGL-Stop!  OpenGL_INCLUDE_DIR = ${OpenGL_INCLUDE_DIR}")
else()
    # add_compile_definitions(USE_MEMORY_CANVAS)
    add_compile_definitions(USE_GDI)
    add_compile_definitions(USE_WIN32_RESOURCES USE_WINUSER)
endif()

#####################################################################################
#####################################################################################
  if (NOT BOOST_ROOT)
    set(BOOST_ROOT ${Boost_ROOT})  # only temporarely
    set(Boost_ROOT)

  endif()

if(NOT Boost_DIR)
  # set(Boost_DIR "${BOOST_ROOT}/lib/cmake/Boost-1.73.0")
  set(Boost_DIR "${BOOST_ROOT}/lib/${TOOLCHAIN}/cmake/Boost-1.73.0")

  message(STATUS "!!!!  Boost_DIR ${Boost_DIR}")
endif()

set(Boost_USE_STATIC_LIBS         ON)
set(Boost_USE_MULTITHREADED       ON)
set(Boost_USE_STATIC_RUNTIME      OFF)
# set(Boost_DEBUG                   ON)
set(Boost_DEBUG                   OFF)
if ($ENV{COMPUTERNAME} MATCHES "PCDERAD0781")
    add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
endif()
# set(BOOST_COMPONENTS system regex filesystem thread chrono date_time serialization)  #  network)
set(BOOST_COMPONENTS date_time)  #  network)
message(STATUS "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")
if (BOOST_COMPONENTS)
  find_package(Boost 1.60 REQUIRED COMPONENTS ${BOOST_COMPONENTS})
  # message(FATAL_ERROR "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")
else()
  find_package(Boost 1.60 REQUIRED)
endif()
# message(FATAL_ERROR "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")


if (NOT Boost_INCLUDE_DIR)
   message(FATAL_ERROR "!!! Boost_INCLUDE_DIR is EMPTY")
  if(EXISTS "${BOOST_ROOT}/include/boost-1_73/boost/version.hpp")
      set(Boost_INCLUDE_DIR "${BOOST_ROOT}/include/boost-1_73")
  elseif(EXISTS "${BOOST_ROOT}/include/boost/version.hpp")
      set(Boost_INCLUDE_DIR "${BOOST_ROOT}/include")
  else()
      message(FATAL_ERROR "!!! Boost: include directories not found! (BOOST_ROOT = ${BOOST_ROOT})")
  endif()
endif()
include_directories( ${Boost_INCLUDE_DIR})
link_directories(${BOOST_ROOT}/lib)

include_directories(
    ${PROJECTGROUP_SOURCE_DIR}/src
    ${PROJECTGROUP_SOURCE_DIR}/src/Engine
    # ${PROJECTGROUP_SOURCE_DIR}/
    ${PROJECTGROUP_BINARY_DIR}/output/include
    # better with find_package
#    ${PROJECTGROUP_BINARY_DIR}/output/src/${XCSOAR_CURL_VERSION}/include

    # D:/Projects/3rd_Party/boost/boost_1_72_0/msvc2019/include/boost-1_72/boost/predef/other
    ${Boost_INCLUDE_DIR}/boost/predef/other
    #  ${Boost_INCLUDE_DIR}/boost/beast/zlib  # wegen zlib.h, hier liegt aber zlib.hpp!
    # D:/link_libs/opencv/opencv_3_4_3/sources/3rdparty/zlib  # wegen zlib.h!

    ${THIRD_PARTY}/glfw/glfw-3.3.2.bin.WIN64/include
    ${LINK_LIBS}/glm/glm-0.9.9/include
)

list(APPEND XCSOAR_SOURCE_LISTS
    Computer
    CrossSection
    Gauge

    Airspace
    Atmosphere
    Audio
    Blackboard
    # Computer
    # CrossSection
    Dialogs
    Engine
    Event
    FLARM
    Form
    Formatter
    # Gauge
    Geo
    Hardware
    IGC
    InfoBoxes
    Input
    Job
    Language
    Logger
    Look
    xcsLua
    #  lua1
    Markers
    Math
    Menu
    Monitor
    Net
    NMEA
    Operation
    OS
    Plane
    Polar
    Profile
    Projection
    Renderer
    Replay
    Repository
    Screen
    Task
    TeamCode
    Terrain
    Thread
    Time
    Topography
    UIUtil
    Units
    Util
    Waypoint
    Weather
    Widget
    XML

        Device
        Dialogs
        IO
        MapWindow
        Tracking
    )


set(SOURCE_FILES )

# message(FATAL_ERROR "Test-Stop!")
if (${XCSOAR_LIB_TYPE} STREQUAL "WITHOUT")
  include("src/CMakeSource.txt")
  foreach(subfolder ${XCSOAR_SOURCE_LISTS})
    foreach(subfile ${${subfolder}_SOURCES})
      list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/src/${subfile}")

      get_filename_component(src_path ${subfile} DIRECTORY)
      string(REPLACE "/" "\\" src_path ${src_path})
      source_group("Source Files\\${src_path}" FILES  ${PROJECTGROUP_SOURCE_DIR}/src/${subfile})

    endforeach()
  endforeach()
  foreach(subfile ${BASIC_SOURCES})
    list(APPEND SOURCE_FILES "${subfile}")
  endforeach()

if(OFF)
   list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.cpp")
else()
    if(NOT MSVC)
      list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/output/data/de.mo.c")
    endif()
   list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.c")
   set_source_files_properties(${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.c PROPERTIES LANGUAGE C)
endif()


file(GLOB EXT_PROJ "3rd_Party/*.cmake")

  #  foreach(subfile ${SOURCE_FILES})
  #    message(STATUS "+++ ${subfile}")
  #  endforeach()

  # add_subdirectory(src)   # libXCSoar! (NOCH!) 

  # message(FATAL_ERROR "Stop!")
else()
  add_subdirectory(src/Airspace)
  add_subdirectory(src/Atmosphere)
  add_subdirectory(src/Audio)
  add_subdirectory(src/Blackboard)
  add_subdirectory(src/Computer)
  add_subdirectory(src/CrossSection)
  add_subdirectory(src/Engine)
  add_subdirectory(src/Event)
  add_subdirectory(src/FLARM)
  add_subdirectory(src/Form)
  add_subdirectory(src/Formatter)
  add_subdirectory(src/Gauge)
  add_subdirectory(src/Geo)
  add_subdirectory(src/Hardware)
  add_subdirectory(src/IGC)
  add_subdirectory(src/InfoBoxes)
  add_subdirectory(src/Input)
  add_subdirectory(src/Job)
  add_subdirectory(src/Language)
  add_subdirectory(src/Logger)
  add_subdirectory(src/Look)
  add_subdirectory(src/Lua)
  add_subdirectory(src/Markers)
  add_subdirectory(src/Math)
  add_subdirectory(src/Menu)
  add_subdirectory(src/Monitor)
  add_subdirectory(src/Net)
  add_subdirectory(src/NMEA)
  add_subdirectory(src/Operation)
  add_subdirectory(src/OS)
  add_subdirectory(src/Plane)
  add_subdirectory(src/Polar)
  add_subdirectory(src/Profile)
  add_subdirectory(src/Projection)
  add_subdirectory(src/Renderer)
  add_subdirectory(src/Replay)
  add_subdirectory(src/Repository)
  add_subdirectory(src/Screen)
  add_subdirectory(src/Task)
  add_subdirectory(src/TeamCode)
  add_subdirectory(src/Terrain)
  #  add_subdirectory(src/Terrain/jasper)
  add_subdirectory(src/Thread)
  add_subdirectory(src/Time)
  add_subdirectory(src/Topography)
  add_subdirectory(src/UIUtil)
  add_subdirectory(src/Units)
  add_subdirectory(src/Util)
  add_subdirectory(src/Waypoint)
  add_subdirectory(src/Weather)
  add_subdirectory(src/Widget)
  add_subdirectory(src/XML)

    add_subdirectory(src/Device)
    add_subdirectory(src/Dialogs)
    add_subdirectory(src/IO)
    add_subdirectory(src/MapWindow)
    add_subdirectory(src/Tracking)

  add_subdirectory(src)   # libXCSoar!
endif()

if (MINGW)

else()
  # TODO(aug) fuer MinGW erst einmal weglassen!
endif()


list(APPEND SOURCE_FILES "src/XCSoar.cpp")
list(APPEND SOURCE_FILES "src/Version.cpp")
if (MSVC)
  list(APPEND SOURCE_FILES "Data/XCSoar.def")
  list(APPEND SOURCE_FILES "Data/XCSoarVS.rc")
elseif(MINGW)
  list(APPEND SOURCE_FILES "Data/XCSoar.rc")
else()
  list(APPEND SOURCE_FILES "Data/XCSoar.rc")
endif()
  list(APPEND SOURCE_FILES "CMakeSource.cmake")

  #==========================================================
  #==========================================================
set(XCSOAR_LINK_LIBRARIES)  # -> empty

# preparing target_link_libraries!

list(APPEND XCSOAR_LINK_LIBRARIES
    ${Boost_LIBRARIES}
)
if (NOT ${XCSOAR_LIB_TYPE} STREQUAL "WITHOUT")
    list(APPEND XCSOAR_LINK_LIBRARIES
        ${XCSOAR_SOURCE_LISTS}
    )
endif()

# External Libs
if (MSVC)
list(APPEND XCSOAR_LINK_LIBRARIES
   "${LINK_LIBS}/lua/${XCSOAR_LUA_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}lua.${LIB_EXTENSION}"
   "${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}jasper.${LIB_EXTENSION}"
#   "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}curlstatic.${LIB_EXTENSION}"
   "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}libcurl.${LIB_EXTENSION}"
#     libcurl
# 7.69.1:    "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/lib/${TOOLCHAIN}/libcurl.${LIB_EXTENSION}"
    "${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstatic.${LIB_EXTENSION}"
   "${LINK_LIBS}/zzip/${XCSOAR_ZZIP_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zzip.${LIB_EXTENSION}"
    "${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}mapserver.${LIB_EXTENSION}"
    "${LINK_LIBS}/libpng/${XCSOAR_LIBPNG_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}libpng16_static.${LIB_EXTENSION}"   # libpng.${LIB_EXTENSION}"
)
elseif(MINGW)
list(APPEND XCSOAR_LINK_LIBRARIES
   "${LINK_LIBS}/lua/${XCSOAR_LUA_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}lua.${LIB_EXTENSION}"
#    "${LINK_LIBS}/jasper/JasPer-2.0.14/lib/${TOOLCHAIN}/jasperstatic.${LIB_EXTENSION}"
    "${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}jasper.${LIB_EXTENSION}"  # now with dll only...
    "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}curl.${LIB_EXTENSION}"
    "${LINK_LIBS}/libpng/${XCSOAR_LIBPNG_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}png.${LIB_EXTENSION}"   # libpng.${LIB_EXTENSION}"
    "${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstatic.${LIB_EXTENSION}"
#    "${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zlib.dll.${LIB_EXTENSION}"  # now with dll only...
   "${LINK_LIBS}/zzip/${XCSOAR_ZZIP_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zzip.${LIB_EXTENSION}"
    "${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}mapserver.${LIB_EXTENSION}"
    # "${LINK_LIBS}/libpng/${XCSOAR_LIBPNG_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}libpng16_static.${LIB_EXTENSION}"   # libpng.${LIB_EXTENSION}"
)
else()
endif()

if (WIN32)  # Windows only:
    if (MSVC)
      list(APPEND XCSOAR_LINK_LIBRARIES
        msimg32.lib  # Windows
        Winmm.lib  # Windows!
    )
    elseif (MINGW)
      list(APPEND XCSOAR_LINK_LIBRARIES
        # m
        # dl
        pthread
        stdc++
        user32
        gdi32
        msimg32
        ws2_32  # MinGW!
        mswsock
        winmm
        # android: intl
        m
        log
        # not android , but linux! rt
        kernel32
        # ?? msvcrt32
        shell32
        gcc_s
        # ldap32
      )
    endif()
else()
###  ..  other OS!
endif()
  #==========================================================
  #==========================================================

if (ANDROID)  # library!
   add_library(${TARGET_NAME} STATIC ${SOURCE_FILES})
else()        # executable!
   add_executable(${TARGET_NAME}     ${SOURCE_FILES} ${SCRIPT_FILES} ${EXT_PROJ})
endif()


# target_link_libraries(${TARGET_NAME}
list(APPEND XCSOAR_LINK_LIBRARIES
#    ${Boost_LIBRARIES}
#    libXCSoar
) # Reihenfolge is very important!!!!

target_link_libraries(${TARGET_NAME} PUBLIC ${XCSOAR_LINK_LIBRARIES})
if(MSVC)
  target_link_options(${TARGET_NAME} PUBLIC "/SUBSYSTEM:WINDOWS")
endif()
#    target_link_libraries(${TARGET_NAME}
#        PRIVATE   # PUBLIC
#        Boost::filesystem
#        ${BOOST_COMPONENTS}
#     )

  # add_compile_definitions}
if(ENABLE_OPENGL)
    target_link_libraries(${TARGET_NAME}
        PRIVATE   # PUBLIC
        OpenGL::GL
        OpenGL:GLU # single colon!
        # GLUT::GLUT
        # FreeGLUT::FreeGLUT
        ###${THIRD_PARTY}/glfw/glfw-3.3.2.bin.WIN64/lib-vc2019/glfw3.${LIB_EXTENSION}
        ### ${LINK_LIBS}/glm/glm-0.9.9/lib/msvc2019/glm_static.${LIB_EXTENSION}
        ###${LINK_LIBS}/glut/freeglut-3.2.1/lib/msvc2019/freeglut.${LIB_EXTENSION}   # libpng.${LIB_EXTENSION}"
    )
endif()

add_dependencies(${TARGET_NAME} curl lua jasper libpng zlib mapserver zzip)   #XCSoar Dialogs)

