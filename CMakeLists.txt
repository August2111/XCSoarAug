# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.15)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # important for folder structure f.e. in Visual Studio

message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

set(ENABLE_OPENGL ON)  # better outside????

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  message(STATUS "+++ TARGET_NAME = ${TARGET_NAME}")
  project(${TARGET_NAME} CXX) # Your project name

get_filename_component(PROJECTGROUP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} ABSOLUTE)
get_filename_component(PROJECTGROUP_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} ABSOLUTE)

message(STATUS "*** PROJECTGROUP_SOURCE_DIR = '${PROJECTGROUP_SOURCE_DIR}'")
message(STATUS "*** PROJECTGROUP_BINARY_DIR = '${PROJECTGROUP_BINARY_DIR}'")


# file(GLOB_RECURSE SOURCE_FILES  ${PROJECTGROUP_SOURCE_DIR}/src/*.cpp)
# file(GLOB_RECURSE HEADER_FILES  ${PROJECTGROUP_SOURCE_DIR}/src/*.h*)
set(SRC "${PROJECTGROUP_SOURCE_DIR}/src")
include(CMakeSource.cmake)

if (WIN32 AND MSVC)
      message(STATUS "+++ System = WIN32 / MSVC!")
      # LUA ist vermutlich besser im output ordner aufgehoben...
      include_directories("D:/Projects/3rd_Party/lua/lua-5.3.5/src")
      # add_definitions("/ZW")
elseif(WIN32 AND MINGW)
      # Only MinGW / GCC:
      message(STATUS "+++ System = WIN32 / MinGW!")
      set(Boost_COMPILER "mgw73")  # necessary: changed mgw as boost compiler to mgw73!
      include_directories(D:/Projects/3rd_Party/qt/Qt5.14.0/Tools/mingw730_64/x86_64-w64-mingw32/include)
      # LUA ist vermutlich besser im output ordner aufgehoben...
      include_directories(D:/Projects/3rd_Party/lua/lua-5.3.5/src)
elseif(ANDROID)
    message(STATUS "+++ System = ANDROID / ${ANDROID_ABI}!")
    set(Boost_COMPILER "clang")  # necessary: changed clang8 as boost compiler to clang!
else()
   message(FATAL_ERROR "+++ Unbekanntes System: !")
endif()

if (NOT Boost_ROOT)
    set(Boost_ROOT $ENV{Boost_ROOT})
endif()
if (NOT Boost_ROOT)
    set(Boost_ROOT "D:/Projects/3rd_party/boost/boost_1_72_0")  # Flaps5!
endif()
string(REPLACE "\\" "/" Boost_ROOT ${Boost_ROOT})
# message(FATAL_ERROR "+++ Boost_ROOT: ${Boost_ROOT} vs. $ENV{Boost_ROOT}!")
#####################################################################################
#####################################################################################
include_directories(D:/Projects/3rd_Party/zlib)
# add_compile_definitions(USE_MEMORY_CANVAS)
add_compile_definitions(NOMINMAX)
add_compile_definitions("XCSOAR_VERSION=\"7.1\"")
# add_definitions(/std:c++11 /Zc:__cplusplus)
if(MSVC)
  add_definitions(/std:c++14 /Zc:__cplusplus)
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
    add_compile_definitions(USE_MEMORY_CANVAS)
    # add_compile_definitions(USE_GDI)
endif()
#####################################################################################
#####################################################################################

if(NOT Boost_DIR)
  set(Boost_DIR "${Boost_ROOT}/lib/cmake/Boost-1.72.0")
endif()
set(Boost_USE_STATIC_LIBS         ON)
set(Boost_USE_MULTITHREADED       ON)
set(Boost_USE_STATIC_RUNTIME      OFF)
# set(Boost_DEBUG                   ON)
set(Boost_DEBUG                   OFF)
# add_definitions(-DBOOST_AUTO_LINK_SYSTEM)         # -DBOOST_AUTO_LINK_VERSIONED)
set(BOOST_COMPONENTS system regex filesystem thread chrono)
find_package(Boost 1.60 REQUIRED COMPONENTS ${BOOST_COMPONENTS})

if(EXISTS "${Boost_ROOT}/include/boost-1_72/boost/version.hpp")
    set(Boost_INCLUDE_DIR "${Boost_ROOT}/include/boost-1_72")
elseif(EXISTS "${Boost_ROOT}/include/boost/version.hpp")
    set(Boost_INCLUDE_DIR "${Boost_ROOT}/include")
else()
    message(FATAL_ERROR "!!! Boost: include dir not found! (Boost_ROOT = ${Boost_ROOT})")
endif()
include_directories( ${Boost_INCLUDE_DIR})
link_directories(${Boost_ROOT}/lib)

include_directories(
    ${PROJECTGROUP_SOURCE_DIR}/src
    ${PROJECTGROUP_SOURCE_DIR}/src/Engine
    ${PROJECTGROUP_SOURCE_DIR}/output/include
    # besser mit find_package
    ${PROJECTGROUP_SOURCE_DIR}/output/src/curl-7.64.1/include

    # D:/Projects/3rd_Party/boost/boost_1_72_0/vc142/include/boost-1_72/boost/predef/other
    ${Boost_INCLUDE_DIR}/boost/predef/other
    #  ${Boost_INCLUDE_DIR}/boost/beast/zlib  # wegen zlib.h, hier liegt aber zlib.hpp!
    D:/link_libs/opencv/opencv_3_4_3/sources/3rdparty/zlib  # wegen zlib.h!
)
# organize the files in subdirectories
# foreach(source_file ${SOURCE_FILES})
#     get_filename_component(src_path ${source_file} DIRECTORY)
#     string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/src" "" src_path ${src_path})
#     if (src_path)
#         string(REPLACE "/" "\\" src_path ${src_path})
#     else()
#         set(src_path "\\_src")
#     endif()
#     source_group("Source${src_path}" FILES  ${source_file})
#     message(STATUS "### ${src_path}  --- ${source_file}")
# endforeach()

# message(FATAL_ERROR "Test-Stop!")

add_subdirectory(src)
# add_subdirectory(src/Dialogs)
add_subdirectory(src/Airspace)
### # add_subdirectory(src/Geo)
### # add_subdirectory(src/IGC)

add_subdirectory(src/Atmosphere)
add_subdirectory(src/Audio)
add_subdirectory(src/Blackboard)
add_subdirectory(src/Computer)
add_subdirectory(src/CrossSection)
add_subdirectory(src/Device)
add_subdirectory(src/Dialogs)
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
add_subdirectory(src/IO)
add_subdirectory(src/Job)
add_subdirectory(src/Language)
add_subdirectory(src/Logger)
add_subdirectory(src/Look)
add_subdirectory(src/Lua)
add_subdirectory(src/MapWindow)
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
add_subdirectory(src/Thread)
add_subdirectory(src/Time)
add_subdirectory(src/Topography)
add_subdirectory(src/Tracking)
add_subdirectory(src/UIUtil)
add_subdirectory(src/Units)
add_subdirectory(src/Util)
add_subdirectory(src/Waypoint)
add_subdirectory(src/Weather)
add_subdirectory(src/Widget)
add_subdirectory(src/XML)
add_subdirectory(src/zzip)



# nur test: 
add_executable(${TARGET_NAME}
# add_library(${TARGET_NAME} STATIC
      src/XCSoar.cpp
      XCSoarDummy.cpp
      src/Version.cpp
      XCSoar.def)

target_link_libraries(${TARGET_NAME}
    PUBLIC
    Airspace
    Atmosphere
    Audio
    Blackboard
    Computer
    CrossSection
    Device
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
    IO
    Job
    Language
    Logger
    Look
    Lua
    MapWindow
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
#    Screen
    Task
    TeamCode
    Terrain
    Thread
    Time
    Topography
    Tracking
    UIUtil
    Units
    Util
    Waypoint
    Weather
    Widget
    XML
#    zzip

#  
    XCSoar
) # Reihenfolge is very important!!!!

if(ENABLE_OPENGL)
    target_link_libraries(${TARGET_NAME}
        PRIVATE   # PUBLIC
        OpenGL::GL
        OpenGL:GLU # single colon!
        GLUT::GLUT
    )
endif()

add_dependencies(${TARGET_NAME} XCSoar Dialogs)

