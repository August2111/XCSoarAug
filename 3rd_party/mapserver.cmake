#  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER #  MAPSERVER 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                  mapserver)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")
# string(LENGTH 15 ${TARGET_CNAME} TARGET_CNAME15)
# message(STATUS "# ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} ")

  set(${TARGET_CNAME}_VERSION "xcsoar")  # gdraheim

  set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
  set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
  set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
  set(${TARGET_CNAME}_FILE "${THIRD_PARTY}/mapserver/mapserver-xcsoar.zip")
  if (UNIX)  # only temporarily
      set(${TARGET_CNAME}_FILE "/home/august/Projects/Gliding/Download/mapserver-xcsoar.7z")
  endif()
#  if(EXISTS      "${${TARGET_CNAME}_FILE}")
     set(${TARGET_CNAME}_URL "file://${${TARGET_CNAME}_FILE}")
  if(ON)
     set(${TARGET_CNAME}_URL "http://www.FlapsOnline.de/XCSoarAug/mapserver-xcsoar.zip")
#  if (EXIST      "${${TARGET_CNAME}_URL}")
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
       "-DLINK_LIBS=${LINK_LIBS}"
       "-DZZIP_INCLUDE_DIR=${LINK_LIBS}/zzip/${XCSOAR_ZZIP_VERSION}/include"
       "-DXCSOAR_ZZIP_VERSION=${XCSOAR_ZZIP_VERSION}"
    BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_ALWAYS OFF
    DEPENDS zlib zzip
)
  else()
    message(STATUS "!!! ZZIP-XCSOAR DON'T EXISTS !!!!!!!!!!!!!!!!!!!!!!!")
  endif()
# add_subdirectory(${THIRD_PARTY}/mapserver/${XCSOAR_MAPSERVER_VERSION}         mapserver)

