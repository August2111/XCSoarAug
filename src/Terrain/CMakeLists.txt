# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  message(STATUS "+++ TARGET_NAME = ${TARGET_NAME}")
  project(${TARGET_NAME} CXX) # Your project name

# include(../../CMakeSource.txt)

# add_compile_definitions(_WINSOCKAPI_)
# organize the files in subdirectories
message(STATUS "##### PROJECTGROUP_SOURCE_DIR:  --- ${PROJECTGROUP_SOURCE_DIR}")

set(SOURCE_FILES )
foreach(source_file ${${TARGET_NAME}_SOURCES})
    message(STATUS "!!! Source File from List:  --- ${source_file}")
    string(REPLACE "${TARGET_NAME}/" "" source_file ${source_file})
    list(APPEND SOURCE_FILES ${source_file})
    get_filename_component(src_path ${source_file} DIRECTORY)
    set_source_files_properties(${source_file} PROPERTIES LANGUAGE CXX)
    if (ON)
       # string(REPLACE "${PROJECTGROUP_SOURCE_DIR}/src" "" src_path ${src_path})
#      string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" src_path ${src_path})
#      string(REPLACE "${TARGET_NAME}" "" src_path ${src_path})
   endif()
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
    endif()
    source_group("Source\\${src_path}" FILES  ${source_file})
    message(STATUS "### ${src_path}  --- ${source_file}")
endforeach()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_library(${TARGET_NAME} STATIC
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)
