# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.10)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # important for folder structure f.e. in Visual Studio
# Setting Area ===================================================
include(ExternalProject)  # since 3.10

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # only by Makefile or Ninja generators: export compile commands

# set(XCSOAR_LIB_TYPE SHARED)
set(XCSOAR_LIB_TYPE STATIC)

if (CMAKE_TOOLCHAIN_FILE)
  message(STATUS "CMAKE_TOOLCHAIN_FILE = '${CMAKE_TOOLCHAIN_FILE}'")
  # Die Variablen aus dem Toolchain-File Sind zwar hier nicht abrufbar, aber wirken auf Compiler uww.??? 
  # message(STATUS "CMAKE_SYSTEM_NAME = '${CMAKE_SYSTEM_NAME}'")
  # message(STATUS "CMAKE_CXX_COMPILER = '${CMAKE_CXX_COMPILER}'")
  # message(STATUS "CMAKE_C_COMPILER = '${CMAKE_C_COMPILER}'")
endif()

set(ENABLE_OPENGL ON)  # better outside????
set(ENABLE_OPENGL OFF)  # better outside????

# Target links to target GLUT::GLUT but the target was not

# cleanup 19.04.20: set(ASIO_GROUPING ON)

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  # set(TARGET_NAME XCSoarAugMinGW)

# # # if (WIN32)
# # # if (${TOOLCHAIN} STREQUAL "ninja")
# # #   message(STATUS "Ninja!")
# # # #  set(TOOLCHAIN "mgw73")
# # # endif()
# # # endif()

message(STATUS "CMAKE_HOST_SYSTEM_NAME = ${CMAKE_HOST_SYSTEM_NAME} vs. CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME} ")


get_filename_component(PROJECTGROUP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} ABSOLUTE)
get_filename_component(PROJECTGROUP_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} ABSOLUTE)

message(STATUS "*** PROJECTGROUP_SOURCE_DIR = '${PROJECTGROUP_SOURCE_DIR}'")
message(STATUS "*** PROJECTGROUP_BINARY_DIR = '${PROJECTGROUP_BINARY_DIR}'")

include(${PROJECTGROUP_SOURCE_DIR}/3rd_party/3rd_party.cmake)

set(SRC "${PROJECTGROUP_SOURCE_DIR}/src")
include(CMakeSource.cmake)

file(GLOB_RECURSE SCRIPT_FILES "*.txt;*.cmake;*.md")
# file(GLOB_RECURSE SCRIPT_FILES "*.txt;*.md")

if (NOT Boost_INCLUDE_DIR)
#   message(FATAL_ERROR "!!! Boost_INCLUDE_DIR is EMPTY")
#  if(EXISTS "${BOOST_ROOT}/include/boost-1_73/boost/version.hpp")
       set(Boost_INCLUDE_DIR  "${BOOST_ROOT}/include/boost-1_73")
#       set(Boost_INCLUDE_DIR "/home/august/Projects/link_libs/boost/boost-1.73.0/include/boost-1_73")
#  elseif(EXISTS "${BOOST_ROOT}/include/boost/version.hpp")
#      set(Boost_INCLUDE_DIR "${BOOST_ROOT}/include")
#  else()
  if(NOT EXISTS "${Boost_INCLUDE_DIR}/boost/version.hpp")
      message(FATAL_ERROR "!!! Boost: include directories not found! (BOOST_ROOT = ${BOOST_ROOT})")
  endif()
endif()

if (NOT EXISTS ${Boost_INCLUDE_DIR}/boost/config.hpp)
    message(STATUS "!!! Boost_INCLUDE_DIR = ${Boost_INCLUDE_DIR} not correctly!")
    set(Boost_INCLUDE_DIR   ${Boost_INCLUDE_DIR}/boost-1_73)
    if (NOT EXISTS ${Boost_INCLUDE_DIR}/boost/config.hpp)
      message(FATAL_ERROR "!!! Boost_INCLUDE_DIR = ${Boost_INCLUDE_DIR}")
    endif()
endif()

if (WIN32 AND MSVC)
      message(STATUS "+++ System = WIN32 / MSVC!")

      add_definitions(-DNDEBUG)  # ansonsten erhalte ich im VS im Debug-Mode eine Menge Assertions bezüglich der 
      # fehlenden PNG-Bitmaps - und ich kann das Programm gar nicht debuggen ;-()


      if(NOT TOOLCHAIN)
        set(TOOLCHAIN msvc2019)
      endif()
      # add_compile_definitions(BOOST_ASIO_WORKAROUND=1)
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      add_compile_definitions(_UNICODE)
      add_compile_definitions(_AUG_MSC=1)

       # warning C4996: 'xxx': The POSIX name for this item is deprecated. Instead, use the ISO C and C++ conformant name: _wcsdup. See online help for details.
       # xxx: wcscpy, wcsdup, strtok, strcpy, strdup, ....
      add_compile_definitions(_CRT_SECURE_NO_WARNINGS)

      # add_definitions(/Zc:wchar_t)
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
      set(BOOST_ROOT D:/link_libs/boost/boost-1.73.0)

      set(FREEGLUT_LIB_DIR "D:/link_libs/freeglut-MSVC-3.0.0-2/freeglut")
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

      # no lib structure, this is failing on GCC  (serial order)???
# ??? #      set(XCSOAR_LIB_TYPE WITHOUT)

      set(Boost_COMPILER "${TOOLCHAIN}")  # necessary: changed mgw as boost compiler to mgw73!
      set(Boost_COMPILER "mgw7")  # necessary: changed mgw as boost compiler to mgw73!
    
      # if(${TOOLCHAIN}  STREQUAL mgw73)
      #   # include_directories("${THIRD_PARTY}/qt/Qt5.14.0/Tools/mingw730_64/x86_64-w64-mingw32/include")
      #   add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
      # endif()
      if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL Windows)
         include_directories("D:/Programs/MinGW/${TOOLCHAIN}/include")
      endif()

      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporory data!

      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      # disable WARNING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
      add_compile_definitions(BOOST_MATH_DISABLE_DEPRECATED_03_WARNING=ON)     

      # sequence from 'targets.mk' 
      if (ON)
        add_compile_definitions(HAVE_MSVCRT)
        add_compile_definitions(_UNICODE)
        add_compile_definitions(UNICODE)
        add_compile_definitions(STRICT)
      endif()
#      set(CMAKE_C_COMPILE_OBJECT "${CMAKE_C_COMPILER} -c <FLAGS> -o <OBJECT>")
#      set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++ -static")

#    set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CSS_STANDARD_LIBRARIES}")
#    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive")

set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static -static-libstdc++ -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive -v")
    set(FREEGLUT_LIB_DIR "D:/link_libs/freeglut-MinGW-3.0.0-1/freeglut")

elseif(WIN32 AND (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"))
      message(STATUS "+++ System = WIN32 / Clang!")
      if(NOT TOOLCHAIN)
        set(TOOLCHAIN clang)
      endif()
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      add_compile_definitions(_AUG_MSC=1)  ### really???  ###
      add_compile_definitions(_UNICODE)
# add_compile_definitions(std:c++11) ### Only a test on 11.05.2020
add_definitions(-std=c++17) ### Only a test on 11.05.2020
      set(LIB_EXTENSION "lib")
      set(PRE_LIB "")
      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporary data!
      if (ON OR WIN64)  # momentan kein Flag verfügbar!
          add_compile_definitions(_AMD64_)
      else()
          message(FATAL_ERROR "Error: WIN32 not implemented?")
      endif()
    set(Boost_COMPILER "clang10")  # necessary: changed clang8 as boost compiler to clang!
    set(Boost_DIR "${BOOST_ROOT}/lib/${Boost_COMPILER}/cmake/Boost-1.73.0")


elseif(WIN32 AND CLANG)
   message(FATAL_ERROR "+++ Unbekanntes System: CLANG!")
elseif(WIN32 AND NINJA)
   message(FATAL_ERROR "+++ Unbekanntes System: NINJA!")
elseif(UNIX)
      message(STATUS "+++ System = LINUX / GCC(?) (${TOOLCHAIN})!")
      
      set(LIB_EXTENSION "a")
      set(PRE_LIB "lib")

      # no lib structure, this is failing on GCC  (serial order)???
      # set(XCSOAR_LIB_TYPE WITHOUT)
      if(MINGW)
         set(ENABLE_OPENGL OFF)  # das ist hier MinGWCrossCompiling für Windows! 
         message(FATAL_ERROR "Stop MinGW")
      else()
         set(ENABLE_OPENGL OFF)
      endif()   

      if (ON) # 2020-05-20: inserted on pcderad0633 regarding missing 'tchar.h'
        add_compile_definitions(HAVE_MSVCRT)
        add_compile_definitions(_UNICODE)
        add_compile_definitions(UNICODE)
        add_compile_definitions(STRICT)
      endif()
      if($ENV{USER} STREQUAL "pcderad0633") 
         set(Boost_COMPILER "gcc9")  # PC0633!
      	 add_compile_definitions(__LITTLE_ENDIAN=1)  # have to be defined!
      	 add_compile_definitions(__BIG_ENDIAN=2)
      else()
         set(Boost_COMPILER "gcc7")  # necessary: ??
      endif()

      add_compile_definitions(BOOST_MATH_DISABLE_DEPRECATED_03_WARNING=ON) 
      # set(Boost_COMPILER "${TOOLCHAIN}")  # necessary: changed mgw as boost compiler to mgw73!
      
     
      # include_directories("D:/Programs/MinGW/${TOOLCHAIN}/include")
      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporary data!
      include_directories("${PROJECTGROUP_SOURCE_DIR}/src/unix")   # temporary data!

      set(Boost_DIR "$ENV{HOME}/Projects/link_libs/boost/boost-1.73.0/lib/unix/cmake/Boost-1.73.0") 
  
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

#    set(THIRDPARTY_INCLUDES)
    add_subdirectory(3rd_party)
    message(STATUS "### THIRDPARTY_INCLUDES = '${THIRDPARTY_INCLUDES}'")

# ALLE: ?
# internal Project
#      include_directories("${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/include") # internal lib

# TODO(aug): Cleaning up this code!!!
# external Projects
      include_directories(
        #    "${LINK_LIBS}/lua/${XCSOAR_LUA_VERSION}/include"
        #    "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/include"
        #    "${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}/include"
        #    "${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION}/include"
        #    "${LINK_LIBS}/mapserver/${XCSOAR_MAPSERVER_VERSION}/include"
        #    "${LINK_LIBS}/zzip/${XCSOAR_ZZIP_VERSION}/include"
         ${LUA_INCLUDE_DIR}
         ${CURL_INCLUDE_DIR}
         ${JASPER_INCLUDE_DIR}
         ${MAPSERVER_INCLUDE_DIR}
         ${ZLIB_INCLUDE_DIR}
         ${ZZIP_INCLUDE_DIR}
         ${LIBPNG_INCLUDE_DIR}
      )

#      include_directories("${LINK_LIBS}/libpng/libpng-1.6.37/include")  # neu am 27.03 wg. einbinden der PNG-Bilder aus der Resource
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
    # find_package(OpenCL REQUIRED)
    # set(GLEW_ROOT D:/link_libs/glew/glew-2.1.0/lib/Release/x64)
    # find_package(GLEW REQUIRED)
    
    if(NOT TARGET OpenGL::GLU)
        message(FATAL_ERROR "GLU could not be found")
    endif(NOT TARGET OpenGL::GLU)
    
    message(STATUS "glu: ${OPENGL_glu_LIBRARY}")
    
    get_target_property(GLU_IMPORTED_LIBNAME OpenGL::GLU IMPORTED_LIBNAME)
    message(STATUS "glu imported libname: ${GLU_IMPORTED_LIBNAME}")
    add_compile_definitions(ENABLE_OPENGL)
    add_compile_definitions(USE_WIN32_RESOURCES USE_WINUSER)

    if (ANDROID)
       include_directories(D:/Programs/Android/android-ndk-r21/sysroot/usr/include/GLES2)
    endif()
    include_directories(${Boost_INCLUDE_DIR}/boost/compute/interop)

    include_directories(${FREEGLUT_LIB_DIR}/include)
    include_directories($ENV{OCL_ROOT}/include)
    include_directories(D:/Programs/OCL_SDK_Light/include) # alternative???
###    ${OCL_ROOT}\include
###    ${OCL_ROOT}\lib\x86
###    ${OCL_ROOT}\lib\x86_64


    # message(FATAL_ERROR "OpenGL-Stop!  OpenGL_INCLUDE_DIR = ${OpenGL_INCLUDE_DIR}")
else()
    # add_compile_definitions(USE_MEMORY_CANVAS)
    add_compile_definitions(USE_GDI)
    add_compile_definitions(USE_WIN32_RESOURCES USE_WINUSER)
endif()

#####################################################################################
#####################################################################################

# TODO(aug): Move this to 3rd_party/boost.cmake!!!

if(NOT Boost_DIR)
# if ($ENV{COMPUTERNAME} MATCHES "PCDERAD0781")
#     set(Boost_DIR "${BOOST_ROOT}/lib/cmake/Boost-1.72.0")
# else()
    set(Boost_DIR "${BOOST_ROOT}/lib/${TOOLCHAIN}/cmake/Boost-1.73.0")
    # set(Boost_DIR "${BOOST_ROOT}/lib/${TOOLCHAIN}/cmake/Boost_1_73_0")
# endif()

  message(STATUS "!!!!  Boost_DIR ${Boost_DIR}")
#  message(FATAL_ERROR "!!!!  BOOST_ROOT ${BOOST_ROOT}")
endif()

set(Boost_USE_STATIC_LIBS         ON)
set(Boost_USE_MULTITHREADED       ON)
set(Boost_USE_STATIC_RUNTIME      OFF)
# set(Boost_DEBUG                   ON)
set(Boost_DEBUG                   OFF)
if ($ENV{COMPUTERNAME} MATCHES "PCDERAD0781")
###    add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
endif()
# set(BOOST_COMPONENTS system regex filesystem thread chrono date_time serialization)  #  network)
set(BOOST_COMPONENTS date_time  filesystem regex)  #  network)
message(STATUS "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")
if (BOOST_COMPONENTS)
  # find_package(Boost 1.60 REQUIRED COMPONENTS ${BOOST_COMPONENTS})
  find_package(Boost 1.60 COMPONENTS ${BOOST_COMPONENTS})
  # message(FATAL_ERROR "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")
else()
  find_package(Boost 1.60 REQUIRED)
endif()
# message(FATAL_ERROR "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")


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

set(SOURCE_FILES )

# message(FATAL_ERROR "Test-Stop!")

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

### Translation Group
 if (NOT UNIX)
     set_source_files_properties(${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.c PROPERTIES LANGUAGE C)
     list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.c")
     set (TRANSLATIONS de)
     foreach(translation ${TRANSLATIONS})
         if(NOT MSVC)
              list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/output/data/${translation}.mo.c")
         endif()
     endforeach()
 endif()

if(MSVC)
  if (ON)  # FLAPS5)
        list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/output/po/de.mo.c")
        set_source_files_properties(${PROJECTGROUP_SOURCE_DIR}/output/po/de.mo.c PROPERTIES LANGUAGE C)
  endif()
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

# preparing target_link_libraries!

list(APPEND XCSOAR_LINK_LIBRARIES  libXCSoar     ${XCSOAR_SOURCE_LISTS})

# TODO(aug): Cleaning up this code!!!

# External Libs
list(APPEND XCSOAR_LINK_LIBRARIES
   ${LUA_LIB}
   ${JASPER_LIB}
   ${CURL_LIB}
   ${MAPSERVER_LIB}
   ${LIBPNG_LIB}
   ${ZZIP_LIB}
   ${ZLIB_LIB}

   ${Boost_LIBRARIES}
)

if (WIN32)  # Windows only:
    if (MSVC)
      list(APPEND XCSOAR_LINK_LIBRARIES
        msimg32.lib
        winmm.lib
    )
    elseif (MINGW)
      list(APPEND XCSOAR_LINK_LIBRARIES
        msimg32
        winmm
        # dl
        pthread
        stdc++
        user32
        gdi32
        ws2_32  # MinGW!
        mswsock
        # android: intl
        m
        # nicht in Linux: log
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
elseif(MINGW)
   add_executable(${TARGET_NAME}     ${SOURCE_FILES} ${SCRIPT_FILES} ${EXT_PROJ}) #  ${XCSOAR_LINK_LIBRARIES})
else()        # executable!
   message(STATUS  "### add_executable(${TARGET_NAME}     ${SOURCE_FILES} ${SCRIPT_FILES} ${EXT_PROJ}")
   add_executable(${TARGET_NAME}     ${SOURCE_FILES} ${SCRIPT_FILES} ${EXT_PROJ})
endif()


# target_link_libraries(${TARGET_NAME}
list(APPEND XCSOAR_LINK_LIBRARIES
#    ${Boost_LIBRARIES}
#    libXCSoar
) # Reihenfolge is very important!!!!

foreach(lib ${XCSOAR_LINK_LIBRARIES})
   message(STATUS "--- XCSOAR_LINK_LIB: ${lib}")
endforeach()

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
        # ${FREEGLUT_LIB_DIR}/lib/x64/${PRE_LIB}freeglut_static.${LIB_EXTENSION} # MinGW
        ${FREEGLUT_LIB_DIR}/lib/x64/${PRE_LIB}freeglut.${LIB_EXTENSION}  # MSVC, but with DLL!
        # ${OCL_ROOT}\lib\x86_64
        # FreeGLUT::FreeGLUT
        ###${THIRD_PARTY}/glfw/glfw-3.3.2.bin.WIN64/lib-vc2019/glfw3.${LIB_EXTENSION}
        ### ${LINK_LIBS}/glm/glm-0.9.9/lib/msvc2019/glm_static.
        ###${LINK_LIBS}/glut/freeglut-3.2.1/lib/msvc2019/freeglut.${LIB_EXTENSION}   # libpng.${LIB_EXTENSION}"
    )
endif()

        # add_custom_target(translation_copy    COMMAND  "${CMAKE_COMMAND}" -E copy_if_different
        add_custom_command(TARGET ${TARGET_NAME} PRE_BUILD
            COMMAND ${CMAKE_COMMAND} -E make_directory ${directory} ${CMAKE_CURRENT_BINARY_DIR}/po
        )

foreach(translation ${TRANSLATIONS})
        add_custom_command(TARGET ${TARGET_NAME} PRE_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECTGROUP_SOURCE_DIR}/output/po/${translation}.mo ${CMAKE_CURRENT_BINARY_DIR}/po/${translation}.mo
        )
#    if(NOT MSVC)
#            list(APPEND SOURCE_FILES "${PROJECTGROUP_SOURCE_DIR}/output/data/${translation}.mo.c")
#    endif()
endforeach()

# add_dependencies(${TARGET_NAME} curl lua jasper libpng zlib mapserver zzip boost googletest)   #XCSoar Dialogs)

if (OFF)  # only if to build
    add_dependencies(${TARGET_NAME} curl lua jasper libpng)
    add_dependencies(${TARGET_NAME} zlib)
    add_dependencies(${TARGET_NAME} mapserver zzip)   # missing: boost xmlparser
    add_dependencies(${TARGET_NAME} googletest )   # missing: boost xmlparser
# missing: add_dependencies(${TARGET_NAME} boost)
# missing: add_dependencies(${TARGET_NAME} xmlparser)
endif()

