# LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG # LIBPNG 
cmake_minimum_required(VERSION 3.15)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
set(TARGET_NAME                                 libpng)
#===================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

# set(${TARGET_CNAME}_VERSION "1.5.10") # https://github.com/LuaDist/libpng
# set(${TARGET_CNAME}_VERSION "1.6.34") # https://github.com/winlibs/libpng
set(${TARGET_CNAME}_VERSION "1.6.37") # https://github.com/glennrp/libpng.git
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")


set(ZLIB_DIR ${LINK_LIBS}/zlib/${XCSOAR_ZLIB_VERSION})

# message(FATAL_ERROR "### ${TARGET_CNAME}_PREFIX = ${${TARGET_CNAME}_PREFIX}")
#-------------------
set(INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
if(NOT EXISTS "${INSTALL_DIR}")
    ExternalProject_Add(
       ${TARGET_NAME}
       # GIT_REPOSITORY "https://github.com/winlibs/${TARGET_NAME}.git"
       # GIT_REPOSITORY "https://github.com/LuaDist/${TARGET_NAME}.git"
       GIT_REPOSITORY "https://github.com/glennrp/${TARGET_NAME}.git"
       GIT_TAG "v${${TARGET_CNAME}_VERSION}"           # git tag by jasper!
    
       PREFIX  "${${TARGET_CNAME}_PREFIX}"
       BINARY_DIR  "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
       INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"
    
    #   PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/LIBPNG/CMakeLists.txt.in" <SOURCE_DIR>/CMakeLists.txt
       CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
           "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"
           "-DCMAKE_INSTALL_INCLUDEDIR=include"
    
             "-DZLIB_INCLUDE_DIR=${ZLIB_DIR}/include"
             "-DZLIB_LIBRARY_DEBUG=${ZLIB_DIR}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstaticd.${LIB_EXTENSION}"
             "-DZLIB_LIBRARY_RELEASE=${ZLIB_DIR}/lib/${TOOLCHAIN}/${PRE_LIB}zlibstatic.${LIB_EXTENSION}"
    
             "-DPNG_SHARED=OFF"
             "-DPNG_STATIC=ON"
             "-DPNG_TEST=OFF"
        # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
        BUILD_ALWAYS OFF
       BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
       DEPENDS zlib
    )
endif()
