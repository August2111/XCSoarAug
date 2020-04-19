# JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER # JASPER 
cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME                                       jasper)
#============================================================
string(TOUPPER ${TARGET_NAME} TARGET_CNAME)
# get_filename_component(TARGET_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WE)
message(STATUS "# ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} # ${TARGET_CNAME} ")
# ---------------------------------------------------------------------------
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)

set(${TARGET_CNAME}_VERSION "2.0.16")
set(XCSOAR_${TARGET_CNAME}_VERSION "${TARGET_NAME}-${${TARGET_CNAME}_VERSION}")  # reset!
set(${TARGET_CNAME}_INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
set(${TARGET_CNAME}_PREFIX "${EP_CMAKE}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}")
#-------------------
ExternalProject_Add(
   ${TARGET_NAME}
   # URL "file://${THIRD_PARTY}/_Download/${XCSOAR_JASPER_VERSION}.tar.gz"
   GIT_REPOSITORY "https://github.com/mdadams/jasper.git"
   GIT_TAG "version-${${TARGET_CNAME}_VERSION}"           # git tag by jasper!

   PREFIX  "${${TARGET_CNAME}_PREFIX}"
   BINARY_DIR    "${${TARGET_CNAME}_PREFIX}/build/${TOOLCHAIN}"
   INSTALL_DIR "${LINK_LIBS}/${TARGET_NAME}/${XCSOAR_${TARGET_CNAME}_VERSION}"

   CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
       "-DCMAKE_INSTALL_BINDIR=bin/${TOOLCHAIN}"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
       "-DCMAKE_INSTALL_COMPONENT=bin/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
    BUILD_ALWAYS ${EP_BUILD_ALWAYS}
    BUILD_IN_SOURCE ${EP_BUILD_IN_SOURCE}
)

#  
#  
#  # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party 
#  cmake_minimum_required(VERSION 3.15)
#  
#  set(TARGET_NAME jasper)
#  message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")
#  
#  set(XCSOAR_JASPER_VERSION "jasper-2.0.16")  # reset!
#  set(JASPER_PREFIX "${EP_CMAKE}/jasper/${XCSOAR_JASPER_VERSION}")
#  ExternalProject_Add(
#     jasper
#     URL "file://${THIRD_PARTY}/_Download/${XCSOAR_JASPER_VERSION}.tar.gz"
#     GIT_REPOSITORY "https://github.com/mdadams/jasper.git"
#     GIT_TAG "version-2.0.16"
#     PREFIX  "${EP_CMAKE}/jasper/${XCSOAR_JASPER_VERSION}"
#     BINARY_DIR    "${JASPER_PREFIX}/build/${TOOLCHAIN}"
#     INSTALL_DIR "${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}"
#  
#       CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>"
#       "-DCMAKE_INSTALL_BINDIR=bin/${TOOLCHAIN}"  #  :PATH=<INSTALL_DIR>/bin/${TOOLCHAIN}"
#       "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
#       "-DCMAKE_INSTALL_COMPONENT=bin/${TOOLCHAIN}"  # :PATH=<INSTALL_DIR>/lib/${TOOLCHAIN}"
#  
#  #   CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${LINK_LIBS}/jasper/${XCSOAR_JASPER_VERSION}" "-DCMAKE_INSTALL_INCLUDEDIR=include" "-DCMAKE_INSTALL_LIBDIR=lib/${TOOLCHAIN}"
#     BUILD_ALWAYS true
#     # BUILD_IN_SOURCE true
#  )

