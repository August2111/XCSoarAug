# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net# XCSoar-Net
cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

  project(${TARGET_NAME} CXX) # Your project name

# include(../../CMakeSource.txt)
# organize the files in subdirectories

if(OFF)
#  if(${XCSOAR_CURL_VERSION} STREQUAL "curl-7.69.1")
    set(CURL_DIR "${LINK_LIBS}/curl/${XCSOAR_CURL_VERSION}/lib/msvc2019/cmake/CURL")
    find_package(CURL REQUIRED)
#  endif()
endif()
# add_compile_definitions(CURL_STATICLIB)
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

add_library(${TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)
