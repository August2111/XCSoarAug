cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  # get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  get_filename_component(PUR_TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  set(TARGET_NAME "${PUR_TARGET_NAME}")

# organize the files in subdirectories
set(SOURCE_FILES )
foreach(source_file ${${PUR_TARGET_NAME}_SOURCES})
    string(REPLACE "${PUR_TARGET_NAME}/" "" source_file ${source_file})
    list(APPEND SOURCE_FILES ${source_file})
    get_filename_component(src_path ${source_file} DIRECTORY)
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
    endif()
    source_group("Source\\${src_path}" FILES  ${source_file})
    # message(STATUS "### ${src_path}  --- ${source_file}")
endforeach()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_library(${TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)

if (OFF)
    add_dependencies(${TARGET_NAME} lua)
endif()
