# Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### 
cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)


file(GLOB_RECURSE SOURCE_FILES *.c *.cxx *.cpp *.cc)
file(GLOB_RECURSE HEADER_FILES *.h *.hxx *.hpp)

include_directories(${PROJECTGROUP_SOURCE_DIR}/src)
include_directories(${CMAKE_SOURCE_DIR})

if(OFF)  # show files
  foreach(src ${SOURCE_FILES} ${HEADER_FILES})
      message(STATUS "+++  ${src}!")
  endforeach()
  message(FATAL_ERROR  "--- Stop!")
endif()

add_library(${TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)

# target_link_libraries(${TARGET_NAME} PUBLIC IO Engine)

# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Deprecated)
# Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### Deprecated ### 
