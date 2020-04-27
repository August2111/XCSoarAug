#  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                  mapserver)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")

  set(${TARGET_CNAME}_VERSION "xcsoar")  # gdraheim

  set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
  set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
  set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
  set(${TARGET_CNAME}_URL "file://${THIRD_PARTY}/mapserver/mapserver-xcsoar")
  if (UNIX)  # only temporarily
      set(${TARGET_CNAME}_URL "file:///home/august/Projects/Gliding/Download/mapserver-xcsoar.7z")
  endif()
  # ------------------
  ExternalProject_Add(
     ${TARGET_NAME}
     URL "${${TARGET_CNAME}_URL}"
     PREFIX  "${${TARGET_CNAME}_PREFIX}"
     BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
     INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"
     CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
       "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_INCLUDEDIR=include"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
       "-DXCSOAR_DIR=${PROJECTGROUP_SOURCE_DIR}/src"
    BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
    DEPENDS zlib zzip
)
# add_subdirectory(${THIRD_PARTY}/mapserver/${XCSOAR_MAPSERVER_VERSION}         mapserver)

