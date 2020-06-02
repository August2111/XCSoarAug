# ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB 
cmake_minimum_required(VERSION 3.15)

set(LIB_TARGET_NAME                                       zlib)
#==========================================================
string(TOUPPER ${LIB_TARGET_NAME} TARGET_CNAME)
# get_filename_component(LIB_TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")

# message(FATAL_ERROR "### LIB_TARGET_NAME = ${LIB_TARGET_NAME}")
# message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${LIB_TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "1.2.11")
set(XCSOAR_${TARGET_CNAME}_VERSION "${LIB_TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${LIB_TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${LIB_TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
set(INSTALL_DIR "${LINK_LIBS}/${LIB_TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
if(NOT EXISTS "${INSTALL_DIR}")
    ExternalProject_Add(
       ${LIB_TARGET_NAME}
       GIT_REPOSITORY "https://github.com/madler/zlib.git"
       GIT_TAG "v${${TARGET_CNAME}_VERSION}"
    
       PREFIX  "${${TARGET_CNAME}_PREFIX}"
       BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
       INSTALL_DIR "${INSTALL_DIR}"     # "${LINK_LIBS}/zlib/${XCSOAR_${TARGET_CNAME}_VERSION}"
    
         CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
         "-DINSTALL_BIN_DIR:PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
         "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
        # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
        BUILD_ALWAYS OFF
        BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
    )
endif()

