cmake_minimum_required(VERSION 3.9.3)

message(STATUS "## ${CMAKE_CURRENT_BINARY_DIR}/CMakelist.txt")

set(TARGET_NAME XCSoar)
# add_subdirectory(Dialogs)
include(CMakeSource.txt)


# add_executable(${TARGET_NAME}
add_library(${TARGET_NAME} STATIC
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)

# set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".cti")
# set_target_properties(${TARGET_NAME} PROPERTIES VERSION ${CMAKE_PROJECT_VERSION}${BO_PROJECT_VERSION_TWEAK})
# set_target_properties(${TARGET_NAME} PROPERTIES SOVERSION ${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR})

set_target_properties(${TARGET_NAME} PROPERTIES FOLDER _Main)
