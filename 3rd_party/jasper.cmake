# JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                       jasper)
#============================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")
# string(LENGTH 15 ${TARGET_CNAME} TARGET_CNAME15)
# message(STATUS "# ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} # ${TARGET_CNAME15} ")
# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "2.0.16")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
set(INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
if(NOT EXISTS "${INSTALL_DIR}")
    ExternalProject_Add(
       ${TARGET_NAME}
       # URL "file://${THIRD_PARTY}/_Download/${XCSOAR_JASPER_VERSION}.tar.gz"
       GIT_REPOSITORY "https://github.com/mdadams/jasper.git"
       GIT_TAG "version-${${TARGET_CNAME}_VERSION}"           # git tag by jasper!
    
       PREFIX  "${${TARGET_CNAME}_PREFIX}"
       BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
       INSTALL_DIR "${INSTALL_DIR}"   # "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"
    
       CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
           "-DCMAKE_INSTALL_BINDIR=bin/${TOOLCHAIN}"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
           "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
    #       "-DCMAKE_INSTALL_COMPONENT=bin/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
     
     "-DJAS_ENABLE_PROGRAMS=OFF"
           "-DJAS_ENABLE_SHARED=OFF"
           "-DJAS_ENABLE_OPENGL=OFF"
        # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    #    BUILD_ALWAYS OFF
        BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
    )
endif()
