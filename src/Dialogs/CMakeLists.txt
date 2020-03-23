# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC# XCSoar-MSVC
cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  message(STATUS "+++ TARGET_NAME = ${TARGET_NAME}")
  project(${TARGET_NAME} CXX) # Your project name

# include(../../CMakeSource.txt)
# organize the files in subdirectories
message(STATUS "##### PROJECTGROUP_SOURCE_DIR:  --- ${PROJECTGROUP_SOURCE_DIR}")

set(SOURCE_FILES )
foreach(source_file ${${TARGET_NAME}_SOURCES})
    string(REPLACE "${TARGET_NAME}/" "" source_file ${source_file})
    list(APPEND SOURCE_FILES ${source_file})
    get_filename_component(src_path ${source_file} DIRECTORY)
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
    endif()
    source_group("Source Files\\${src_path}" FILES  ${source_file})
    # message(STATUS "### ${src_path}  --- ${source_file}")
endforeach()

file(GLOB_RECURSE ${TARGET_NAME}_HEADERS "*.h*")
set(HEADER_FILES )
foreach(source_file ${${TARGET_NAME}_HEADERS})
    # string(REPLACE "${TARGET_NAME}/" "" source_file ${source_file})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" source_file ${source_file})
    list(APPEND SOURCE_FILES ${source_file})
    get_filename_component(src_path ${source_file} DIRECTORY)
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
    endif()
    source_group("Header Files\\${src_path}" FILES  ${source_file})
    message(STATUS "### ${src_path}  --- ${source_file}")
endforeach()
# message(FATAL_ERROR Stop!)
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# to Language! message(STATUS "!!!!!! PROJECTGROUP_SOURCE_DIR = '${PROJECTGROUP_SOURCE_DIR}'")
# to Language! set_source_files_properties(${PROJECTGROUP_SOURCE_DIR}/temp/data/memory_fields.c PROPERTIES LANGUAGE CXX)

add_library(${TARGET_NAME} STATIC
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
# to Language!    ${PROJECTGROUP_SOURCE_DIR}/temp_data/memory_fields.c
)
# target_link_libraries(${TARGET_NAME} data)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)
