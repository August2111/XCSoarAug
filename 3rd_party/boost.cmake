# BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # ZLIB 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                       boost)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # ${TARGET_CNAME} ")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "1.73.0")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")

set(TOOLSET gcc)
set(TOOLSETNAME ${TOOLCHAIN})
#-------------------
ExternalProject_Add(
   ${TARGET_NAME}
   GIT_REPOSITORY "https://github.com/boostorg/boost.git"
   GIT_TAG "${XCSOAR_${TARGET_CNAME}_VERSION}"

   PREFIX  "${${TARGET_CNAME}_PREFIX}"
   BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
   INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"

   CONFIGURE_COMMAND ""
   # PATCH_COMMAND "bootstrap"
   BUILD_COMMAND "b2 -j4 toolset=${TOOLSET} variant=release link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=D:/link_libs/boost/boost_1_73_0 --build-dir=D:/Projects/3rd_Party/boost/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=D:/link_libs/boost/boost_1_73_0/include --libdir=D:/link_libs/boost/boost_1_73_0/lib/${TOOLSETNAME} install"

##     CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
##     "-DINSTALL_BIN_DIR:PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
##     "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
    # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_ALWAYS On
    # BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
    WORKING_DIRECTORY D:/Projects/3rd_Party/boost/build/${TOOLSETNAME}  # = build_dir!
)

