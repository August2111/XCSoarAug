set(DISPLY_STRING "# GTEST          # GTEST          # GTEST          # GTEST          # GTEST          # GTEST          # GTEST          # GTEST          # GTEST          # GTEST")
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME googletest)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "${DISPLY_STRING}")

# message(FATAL_ERROR "### TARGET_NAME = ${TARGET_NAME}")
# message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "1.10.0")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
ExternalProject_Add(
   ${TARGET_NAME}
#   URL "file://${THIRD_PARTY}/_Download/zlib1211.zip"
   GIT_REPOSITORY "https://github.com/google/googletest.git"
   GIT_TAG "release-${${TARGET_CNAME}_VERSION}"

   PREFIX  "${${TARGET_CNAME}_PREFIX}"
   BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
   INSTALL_DIR "${LINK_LIBS}/zlib/${XCSOAR_${TARGET_CNAME}_VERSION}"

     CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
     "-DINSTALL_BIN_DIR:PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
     "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
    # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_ALWAYS OFF
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
)

