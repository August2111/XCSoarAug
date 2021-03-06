cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

  project(${TARGET_NAME} CXX) # Your project name

# include(../../CMakeSource.cmake)
# organize the files in subdirectories


list(APPEND ${TARGET_NAME}_SOURCES  ${TARGET_NAME}/jpc_rtc.cpp)
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
# include_directories(${3rd_Party}/jasper/Jasper-2.0.0/src/jasper)
# include_directories(${3rd_Party}/_install/jasper/JasPer_2.0.0/include)

add_library(${TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
target_link_libraries(${TARGET_NAME} PUBLIC
    IO
    Screen
    Renderer
    ${ZZIP_LIB}
    ${JASPER_LIB}
    # "${LINK_LIBS}/zzip/${XCSOAR_ZZIP_VERSION}/lib/${TOOLCHAIN}/${PRE_LIB}zzip.${LIB_EXTENSION}"
)

# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)

if (ON)
    # add_dependencies(${TARGET_NAME} jasper zzip)   #XCSoar Dialogs)
endif()

