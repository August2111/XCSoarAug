# if (ON)  # MSVC)  # in this moment not for MinGW enabled!!
if (MSVC)  # in this moment not for MinGW enabled!!
#===========================================

# BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST
cmake_minimum_required(VERSION 3.10)

set(TARGET_NAME                                       boost)
#==========================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST          # BOOST ")

# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "1.73.0")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")

if(MSVC)
set(TOOLSET msvc)
set(TOOLSETNAME msvc2019)
else()
set(TOOLSET gcc)
set(TOOLSETNAME ${TOOLCHAIN})
endif()


# set(${TARGET_CNAME}_BUILD_CMD "cd ../../src/${TARGET_NAME} & .\\b2 -j4 toolset=${TOOLSET} variant=release link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install")
# set(${TARGET_CNAME}_BUILD_CMD "cd ../../src/build & echo %CD% & ./b2 -j4 toolset=${TOOLSET} variant=release link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install")
# set(${TARGET_CNAME}_BUILD_CMD "cd ../../src/build & echo %CD% & ./b2 -j4 toolset=${TOOLSET} link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install")
set(${TARGET_CNAME}_BUILD_CMD "./b2 -j4 toolset=${TOOLSET} link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install")


set(INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
if(NOT EXISTS "${INSTALL_DIR}")

## b2 -j4 toolset=msvc link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=D:/link_libs/boost/boost-1.73.0 --build-dir=D:/Projects/3rd_Party/boost/build/msvc2019 --with-chrono --with-system --with-filesystem --with-headers --with-regex --with-date_time  --includedir=D:/link_libs/boost/boost-1.73.0/include --libdir=D:/link_libs/boost/boost-1.73.0/lib/msvc2019 install
message(STATUS "### ${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/src/${TARGET_NAME}")
message(STATUS "### ${${TARGET_CNAME}_BUILD_CMD}")


#-------------------
ExternalProject_Add(
   ${TARGET_NAME}
   GIT_REPOSITORY        "https://github.com/boostorg/boost.git"
   GIT_TAG               "${XCSOAR_${TARGET_CNAME}_VERSION}"

   PREFIX                "${${TARGET_CNAME}_PREFIX}"
#   BINARY_DIR            "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
   INSTALL_DIR           "${INSTALL_DIR}"

   # PATCH_COMMAND         "bootstrap"
   CONFIGURE_COMMAND     bootstrap     ##  "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/src/${TARGET_NAME}/TestOutput.cmd"

   # BUILD_COMMAND ${CMAKE_COMMAND} -E echo "Starting $<CONFIG> build"
   # COMMAND       "cd ../../src/${TARGET_NAME} & b2.exe -j4 toolset=${TOOLSET} variant=release link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install"
   # BUILD_COMMAND         
   # CONFIGURE_COMMAND     "../../src/${TARGET_NAME}/TestOutput.cmd ${TARGET_NAME} ${TOOLSET} ${TOOLSETNAME} ${XCSOAR_${TARGET_CNAME}_VERSION}"
#  BUILD_COMMAND "cd ../../src/${TARGET_NAME} & b2.exe -j4 toolset=${TOOLSET} variant=release link=static runtime-link=shared threading=multi address-model=64 --layout=versioned --prefix=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION} --build-dir=D:/Projects/3rd_Party/${TARGET_NAME}/build/${TOOLSETNAME} --with-chrono --with-system --with-filesystem --with-headers --with-date_time  --includedir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/include --libdir=${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/lib/${TOOLSETNAME} install"
   BUILD_COMMAND "${${TARGET_CNAME}_BUILD_CMD}"

##     CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
##     "-DINSTALL_BIN_DIR:PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
##     "-DINSTALL_LIB_DIR:PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
    # BUILD_ALWAYS ${EP_BUILD_ALWAYS}
#    BUILD_ALWAYS ON
    BUILD_IN_SOURCE ON  ## ${EP_BUILD_IN_SOURCE}
    # WORKING_DIRECTORY ${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}/src/${TARGET_NAME}  # = src_dir!
)
#===========================================
endif()

endif(MSVC)
