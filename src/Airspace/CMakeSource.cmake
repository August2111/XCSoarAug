set(Airspace_SOURCES
        Airspace/ActivePredicate.cpp
        Airspace/AirspaceComputerSettings.cpp
        Airspace/AirspaceGlue.cpp
        Airspace/AirspaceParser.cpp
        Airspace/AirspaceVisibility.cpp
        Airspace/NearestAirspace.cpp
        Airspace/ProtectedAirspaceWarningManager.cpp
)

message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

#  get_filename_component(LIB_TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
  set(LIB_TARGET_NAME "Airspace")

#  project(${LIB_TARGET_NAME} CXX) # Your project name

# include(../../CMakeSource.cmake)
# organize the files in subdirectories
set(SOURCE_FILES )
foreach(source_file ${${LIB_TARGET_NAME}_SOURCES})
    string(REPLACE "${LIB_TARGET_NAME}/" "" source_file ${source_file})
#    list(APPEND SOURCE_FILES ${source_file})
    if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/src/${LIB_TARGET_NAME}/${source_file})
       list(APPEND SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/${LIB_TARGET_NAME}/${source_file})
    else()
        message(STATUS "+++ ${LIB_TARGET_NAME}/${source_file} don't exists!")
    endif()
    ### get_filename_component(src_path ${source_file} DIRECTORY)
    get_filename_component(src_path ${source_file} DIRECTORY)
    if (src_path)
        string(REPLACE "/" "\\" src_path ${src_path})
        source_group("Source" FILES  ${source_file})
    else()
        source_group("Source\\${src_path}" FILES  ${source_file})
    endif()
    message(STATUS "### '${src_path}'  --- ${source_file}")
endforeach()

# include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${SRC}/${LIB_TARGET_NAME})

# message(STATUS "### ${LIB_TARGET_NAME} SOURCE_FILES:  ${SOURCE_FILES}")
# message(FATAL_ERROR "### ${LIB_TARGET_NAME} SOURCE_FILES:  ${SOURCE_FILES}")


add_library(${LIB_TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")

set_target_properties(${LIB_TARGET_NAME} PROPERTIES FOLDER Libs)

