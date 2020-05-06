# ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB # ZLIB 
cmake_minimum_required(VERSION 3.15)

if (OFF)
  # noch ohne XML-Parser
set(TARGET_NAME                                       xml)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
string(LENGTH 15 ${TARGET_CNAME} TARGET_CNAME15)
message(STATUS "# ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} ")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

# set(${TARGET_CNAME}_VERSION "2.44")
set(${TARGET_CNAME}_VERSION "1.08")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_URL "http://www.FlapsOnline.de/XCSoarAug/xml-1.08.zip")

#-------------------
ExternalProject_Add(
    ${TARGET_NAME}
    # GIT_REPOSITORY "https://github.com/"
    # GIT_TAG "v${${TARGET_CNAME}_VERSION}"

    URL "${${TARGET_CNAME}_URL}"
    PREFIX  "${${TARGET_CNAME}_PREFIX}"
    BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
    INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"
   PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_CNAME}_CMakeLists.txt.in" <SOURCE_DIR>/CMakeLists.txt
    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
     "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
     "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
     "-DCMAKE_INSTALL_INCLUDEDIR=include"
    BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
)

endif()