# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.15)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # important for folder structure f.e. in Visual Studio

message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}! TARGET_NAME = ${TARGET_NAME}")

set(ENABLE_OPENGL OFF)  # better outside????

# Debugging Path: 
# PATH=$(PATH);D:\link_libs\curl\curl-7.64.1\lib\msvc2019;D:\link_libs\jasper\JasPer-2.0.14\lib\msvc2019

set(ASIO_GROUPING ON)

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

  project(${TARGET_NAME} CXX) # Your project name

get_filename_component(PROJECTGROUP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} ABSOLUTE)
get_filename_component(PROJECTGROUP_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} ABSOLUTE)

message(STATUS "*** PROJECTGROUP_SOURCE_DIR = '${PROJECTGROUP_SOURCE_DIR}'")
message(STATUS "*** PROJECTGROUP_BINARY_DIR = '${PROJECTGROUP_BINARY_DIR}'")

set(SRC "${PROJECTGROUP_SOURCE_DIR}/src")
include(CMakeSource.cmake)
# message(FATAL_ERROR "Stop. !")

if (WIN32 AND MSVC)
      message(STATUS "+++ System = WIN32 / MSVC!")
      # add_compile_definitions(BOOST_ASIO_WORKAROUND=1)
      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      add_compile_definitions(_AUG_MSC=1)

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
      # include_directories("${THIRD_PARTY}/lua-5.3.5/src")
      include_directories("${LINK_LIBS}/lua/lua-5.3.5/include")
      include_directories("${LINK_LIBS}/curl/curl-7.64.1/include")
      # include_directories("${THIRD_PARTY}/jasper/JasPer/include")
      # include_directories("${THIRD_PARTY}/jasper/Jasper-2.0.0/src")
      include_directories("${LINK_LIBS}/jasper/JasPer-2.0.14/include")
      # include_directories("${THIRD_PARTY}/MapServer/src")
      include_directories("${THIRD_PARTY}/mapserver/mapserver-0")
      include_directories("${LINK_LIBS}/zlib/zlib-1.2.11/include")
elseif(WIN32 AND MINGW)
      # Only MinGW / GCC:
      # set(THIRD_PARTY "D:/Projects/3rd_Party")
      # set(LINK_LIBS "D:/link_libs")
      message(STATUS "+++ System = WIN32 / MinGW!")
      set(Boost_COMPILER "mgw73")  # necessary: changed mgw as boost compiler to mgw73!
      include_directories("${THIRD_PARTY}/qt/Qt5.14.0/Tools/mingw730_64/x86_64-w64-mingw32/include")
      # LUA ist vermutlich besser im output ordner aufgehoben...
      include_directories("${THIRD_PARTY}/lua/lua-5.3.5/src")
      include_directories("${THIRD_PARTY}/mapserver/mapserver-0")
      include_directories("${THIRD_PARTY}/curl/curl-7.64.1/include")
      include_directories("${LINK_LIBS}/zlib/zlib-1.2.11/include")
      include_directories("${LINK_LIBS}/jasper/JasPer-2.0.14/include")

      include_directories("${PROJECTGROUP_SOURCE_DIR}/temp/data")  # temporory data!

      add_compile_definitions(BOOST_ASIO_SEPARATE_COMPILATION)
      set(CMAKE_C_COMPILE_OBJECT "${CMAKE_C_COMPILER} -c <FLAGS> -o <OBJECT>")

elseif(ANDROID)
    message(STATUS "+++ System = ANDROID / ${ANDROID_ABI}!")
    set(Boost_COMPILER "clang")  # necessary: changed clang8 as boost compiler to clang!
else()
   message(FATAL_ERROR "+++ Unbekanntes System: !")
endif()

## if (NOT Boost_ROOT)
##     set(Boost_ROOT $ENV{Boost_ROOT})
## endif()
## #  if (NOT Boost_ROOT)
#      set(Boost_ROOT "D:/link_libs/boost/boost_1_72_0")  # Flaps5!
#  endif()
###string(REPLACE "\\" "/" Boost_ROOT ${Boost_ROOT})
# message(FATAL_ERROR "+++ Boost_ROOT: ${Boost_ROOT} vs. $ENV{Boost_ROOT}!")
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
    find_package(OpenGL REQUIRED)
    
    if(NOT TARGET OpenGL::GLU)
        message(FATAL_ERROR "GLU could not be found")
    endif(NOT TARGET OpenGL::GLU)
    
    message(STATUS "glu: ${OPENGL_glu_LIBRARY}")
    
    get_target_property(GLU_IMPORTED_LIBNAME OpenGL::GLU IMPORTED_LIBNAME)
    message(STATUS "glu imported libname: ${GLU_IMPORTED_LIBNAME}")
    add_compile_definitions(ENABLE_OPENGL)
else()
    # add_compile_definitions(USE_MEMORY_CANVAS)
    add_compile_definitions(USE_GDI)
    add_compile_definitions(USE_WIN32_RESOURCES USE_WINUSER)
endif()

#####################################################################################
#####################################################################################

# add_compile_definitions(CURL_STATICLIB)

if(NOT Boost_DIR)
  set(Boost_DIR "${Boost_ROOT}/lib/cmake/Boost-1.72.0")

  message(STATUS "!!!!  Boost_DIR ${Boost_DIR}")
endif()
#  message(FATAL_ERROR "!!!!  Boost_DIR ${Boost_DIR}")


set(Boost_USE_STATIC_LIBS         ON)
set(Boost_USE_MULTITHREADED       ON)
set(Boost_USE_STATIC_RUNTIME      OFF)
# set(Boost_DEBUG                   ON)
set(Boost_DEBUG                   OFF)
if ($ENV{COMPUTERNAME} MATCHES "PCDERAD0781")
    add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
endif()
set(BOOST_COMPONENTS system regex filesystem thread chrono date_time serialization)  #  network)
find_package(Boost 1.60 REQUIRED COMPONENTS ${BOOST_COMPONENTS})

#    message(FATAL_ERROR "!!! Boost_DIR = ${Boost_DIR} at $ENV{COMPUTERNAME}")

if(EXISTS "${Boost_ROOT}/include/boost-1_72/boost/version.hpp")
    set(Boost_INCLUDE_DIR "${Boost_ROOT}/include/boost-1_72")
elseif(EXISTS "${Boost_ROOT}/include/boost/version.hpp")
    set(Boost_INCLUDE_DIR "${Boost_ROOT}/include")
else()
    message(FATAL_ERROR "!!! Boost: include directories not found! (Boost_ROOT = ${Boost_ROOT})")
endif()
include_directories( ${Boost_INCLUDE_DIR})
link_directories(${Boost_ROOT}/lib)

include_directories(
    ${PROJECTGROUP_SOURCE_DIR}/src
    ${PROJECTGROUP_SOURCE_DIR}/src/Engine
    # ${PROJECTGROUP_SOURCE_DIR}/
    ${PROJECTGROUP_BINARY_DIR}/output/include
    # better with find_package
#    ${PROJECTGROUP_BINARY_DIR}/output/src/curl-7.64.1/include

    # D:/Projects/3rd_Party/boost/boost_1_72_0/msvc2019/include/boost-1_72/boost/predef/other
    ${Boost_INCLUDE_DIR}/boost/predef/other
    #  ${Boost_INCLUDE_DIR}/boost/beast/zlib  # wegen zlib.h, hier liegt aber zlib.hpp!
    # D:/link_libs/opencv/opencv_3_4_3/sources/3rdparty/zlib  # wegen zlib.h!
)

# message(FATAL_ERROR "Test-Stop!")

add_subdirectory(src)

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
if (NOT MINGW)
  # TODO(aug) fuer MinGW erst einmal weglassen!
  add_subdirectory(src/zzip 3rd_party/zzip)
endif()

    add_subdirectory(${THIRD_PARTY}/lua/lua-5.3.5  3rd_party/lua)
    add_subdirectory(${THIRD_PARTY}/mapserver/mapserver-0  3rd_party/MapServer)
# add_subdirectory(${THIRD_PARTY}/jasper/Jasper-2.0.0  3rd_party/jasper)

if(ASIO_GROUPING)   # test ASIO: 
    add_subdirectory(src/Device)
    add_subdirectory(src/Dialogs)
    add_subdirectory(src/IO)
    add_subdirectory(src/MapWindow)
    add_subdirectory(src/Tracking)
endif()

set(SOURCE_FILES )
if (NOT ASIO_GROUPING)  #next test: ASIO
    foreach(source_file
          ${Device_SOURCES}
          ${MapWindow_SOURCES}
          ${Tracking_SOURCES}
          ${Dialogs_SOURCES}
          ${IO_SOURCES}
    )
        get_filename_component(src_path ${source_file} DIRECTORY)
        if (src_path)
            string(REPLACE "/" "\\" src_path ${src_path})
        endif()
        source_group("Source\\${src_path}" FILES  src/${source_file})
        list(APPEND SOURCE_FILES src/${source_file})
        message(STATUS "xxx ${src_path}  --- ${source_file}")
    endforeach()
endif()

list(APPEND SOURCE_FILES "src/XCSoar.cpp")
list(APPEND SOURCE_FILES "src/Version.cpp")
if (MSVC)
  list(APPEND SOURCE_FILES "Data/XCSoar.def")
  list(APPEND SOURCE_FILES "Data/XCSoarVS.rc")
elseif(MINGW)
  list(APPEND SOURCE_FILES "Data/XCSoarVS.rc")
else()
  list(APPEND SOURCE_FILES "Data/XCSoar.rc")
endif()
  list(APPEND SOURCE_FILES "CMakeSource.cmake")

if (ANDROID)  # library!
   add_library(${TARGET_NAME} STATIC ${SOURCE_FILES})
else()        # executable!
   add_executable(${TARGET_NAME}     ${SOURCE_FILES})
endif()

# preparing target_link_libraries!
set(XCSOAR_LINK_LIBRARIES
    Airspace
    Atmosphere
    Audio
    Blackboard
    Computer
    CrossSection
    Dialogs
    Engine
    Event
    FLARM
    Form
    Formatter
    Gauge
    Geo
    Hardware
    IGC
    InfoBoxes
    Input
    Job
    Language
    Logger
    Look
    Lua
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
)

if(ASIO_GROUPING)   # test ASIO: 
    list(APPEND XCSOAR_LINK_LIBRARIES
        Device
        Dialogs
        IO
        MapWindow
        Tracking
    )
endif()

#3rd party XCSOAR_LINK_LIBRARIES:
list(APPEND XCSOAR_LINK_LIBRARIES
    zzip
    MapServer
    lua1
#    "${LINK_LIBS}/jasper/JasPer-2.0.14/lib/msvc2019/jasperstatic.lib"
    "${LINK_LIBS}/jasper/JasPer-2.0.14/lib/msvc2019/jasper.lib"
#    "${LINK_LIBS}/curl/curl-7.64.1/lib/msvc2019/libcurlstatic.lib"
    "${LINK_LIBS}/curl/curl-7.64.1/lib/msvc2019/libcurl.lib"
    "${LINK_LIBS}/zlib/zlib-1.2.11/lib/msvc2019/zlibstatic.lib"
)

if (WIN32)  # Windows only:
    list(APPEND XCSOAR_LINK_LIBRARIES
    msimg32.lib  # Windows
    Winmm.lib  # Windows!
    )
else()
###  .. other OS!
endif()

# target_link_libraries(${TARGET_NAME}
list(APPEND XCSOAR_LINK_LIBRARIES
    ${Boost_LIBRARIES}
    XCSoar
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
    )
endif()

# add_dependencies(${TARGET_NAME} XCSoar Dialogs)

