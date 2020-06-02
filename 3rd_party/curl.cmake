# CURL # CURL # CURL # CURL # CURL # CURL # CURL # CURL # CURL # CURL 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                       curl)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")

set(ZLIB_DIR ${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION})

# ---------------------------------------------------------------------------
### option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)
### option(USE_DRAHEIM "Should we use the draheim (or the BBDE) system?" OFF)

#  set(${TARGET_CNAME}_VERSION "7.68.0")
  set(${TARGET_CNAME}_VERSION "7.69.1")
  string(REPLACE "." "_" GIT_TAG ${TARGET_NAME}-${${TARGET_CNAME}_VERSION})
  # message(FATAL_ERROR "### GIT_TAG = ${GIT_TAG}")
  set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
  set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
  set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")


set(INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
if(NOT EXISTS "${INSTALL_DIR}")
  ExternalProject_Add(
     ${TARGET_NAME}
   GIT_REPOSITORY "https://github.com/curl/curl.git"
   GIT_TAG  ${GIT_TAG}
     PREFIX  "${${TARGET_CNAME}_PREFIX}"
     BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
     INSTALL_DIR "${INSTALL_DIR}"  # ${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"
     # PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/CURL_CMakeLists.txt.in" <SOURCE_DIR>/CMakeLists.txt
     CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
         "-DCMAKE_INSTALL_BINDIR=bin/${TOOLCHAIN}"
         "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"
         # "-DCMAKE_INSTALL_COMPONENT=bin/${TOOLCHAIN}"
         "-DCMAKE_INSTALL_INCLUDEDIR=include"
         "-DBUILD_CURL_EXE=OFF"
         "-DBUILD_SHARED_LIBS=OFF"
         "-DBUILD_TESTING=OFF"
         "-DCMAKE_USE_LIBSSH2=OFF"
         "-DUSE_WIN32_LDAP=OFF"
         "-DZLIB_INCLUDE_DIR=${ZLIB_DIR}/include"
         "-DZLIB_LIBRARY_DEBUG=${ZLIB_DIR}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstaticd.${LIB_EXTENSION}"
         "-DZLIB_LIBRARY_RELEASE=${ZLIB_DIR}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstatic.${LIB_EXTENSION}"
    # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_ALWAYS OFF
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
    DEPENDS zlib
)
endif()
