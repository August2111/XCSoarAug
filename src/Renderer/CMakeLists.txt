cmake_minimum_required(VERSION 3.15)
message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

  get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)

# include(../../CMakeSource.cmake)
# organize the files in subdirectories


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

# # # !!! # ATTENTION Terrain inside Renderer!
# # # !!! foreach(cpp_file  ${Terrain_SOURCES})
# # # !!!   list(APPEND SOURCE_FILES  ${PROJECTGROUP_SOURCE_DIR}/src/${cpp_file})
# # # !!! endforeach()
# # # !!! 
# # # !!! # ATTENTION Engine inside Renderer!
# # # !!! foreach(cpp_file  ${Engine_SOURCES})
# # # !!!   list(APPEND SOURCE_FILES  ${PROJECTGROUP_SOURCE_DIR}/src/${cpp_file})
# # # !!! endforeach()


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_library(${TARGET_NAME} ${XCSOAR_LIB_TYPE}
    ${SOURCE_FILES}
    ${HEADER_FILES}
    ${SCRIPT_FILES}
)
# message(FATAL_ERROR "Stop!")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER Libs)
# add_dependencies(${TARGET_NAME} Terrain)

target_link_libraries(${TARGET_NAME} PUBLIC Projection Engine Terrain MapWindow)
add_dependencies(${TARGET_NAME} Projection Engine Terrain)
