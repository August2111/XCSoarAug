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
    source_group("Source\\${src_path}" FILES  ${source_file})
    # message(STATUS "### ${src_path}  --- ${source_file}")
endforeach()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set_source_files_properties(${PROJECTGROUP_SOURCE_DIR}/data_temp/memory_fields.c PROPERTIES LANGUAGE C)

add_library(${TARGET_NAME} STATIC
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
    ${PROJECTGROUP_SOURCE_DIR}/data_temp/memory_fields.c
)

# target_link_libraries( ${TARGET_NAME}
#     UTF8
# )
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)
