# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}! TARGET_NAME = ${TARGET_NAME}")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

  project(${TARGET_NAME} C) # Your project name

 set(CMAKE_C_COMPILE_OBJECT "${CMAKE_C_COMPILER} -c <FLAGS> -o <OBJECT>")

#   set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)

# include(../../CMakeSource.txt)

# add_compile_definitions(_WINSOCKAPI_)
# organize the files in subdirectories


set(SOURCE_FILES )
foreach(source_file ${${TARGET_NAME}_SOURCES})
    # message(STATUS "!!! Source File from List:  --- ${source_file}")
    string(REPLACE "${TARGET_NAME}/" "" source_file ${source_file})
    list(APPEND SOURCE_FILES ${source_file})
    # set_source_files_properties(${source_file} PROPERTIES LANGUAGE CXX)
    get_filename_component(src_path ${source_file} DIRECTORY)
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
    endif()
    source_group("Source\\${src_path}" FILES  ${source_file})
    # message(STATUS "${src_path}  --- ${source_file}")
endforeach()

add_compile_definitions(ZZIP_PACKAGE)
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_compile_definitions(ZZLIB_PACKAGE)

add_library(${TARGET_NAME} STATIC
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER 3rdParty)

