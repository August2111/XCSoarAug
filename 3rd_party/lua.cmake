# LUA # LUA # LUA # LUA # LUA # LUA # LUA # LUA # LUA # LUA 
cmake_minimum_required(VERSION 3.15)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
set(TARGET_NAME                                 lua)
#===================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "5.3.5")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")

# message(FATAL_ERROR "### ${TARGET_CNAME}_PREFIX = ${${TARGET_CNAME}_PREFIX}")
#-------------------
ExternalProject_Add(
   ${TARGET_NAME}
#   URL "https://www.lua.org/ftp/${XCSOAR_LUA_VERSION}.tar.gz"
   URL "https://www.lua.org/ftp/lua-5.3.5.tar.gz"
   URL_HASH MD5=4f4b4f323fd3514a68e0ab3da8ce3455
   # GIT_REPOSITORY "https://github.com/mdadams/jasper.git"
   # GIT_TAG "version-${${TARGET_CNAME}_VERSION}"           # git tag by jasper!

   PREFIX  "${${TARGET_CNAME}_PREFIX}"
   BINARY_DIR  "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
   INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"

   # PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/lua/CMakeLists.txt.in" <SOURCE_DIR>/CMakeLists.txt
   PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/lua_CMakeLists.txt.in" <SOURCE_DIR>/CMakeLists.txt
   CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
       "-DCMAKE_INSTALL_BINDIR=bin/${TOOLCHAIN}"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_COMPONENT=bin/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_INCLUDEDIR=include"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
    BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
)
