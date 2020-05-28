# D:\Projects\Binaries\XCSoarAug\msvc2019\3rd_party\3rd_party.cmake

set(XCSOAR_LUA_VERSION "lua-5.3.5")

# set(XCSOAR_CURL_VERSION "curl-7.64.1")  # curl-git")
set(XCSOAR_CURL_VERSION "curl-7.69.1")
add_definitions(-DCURL_STATICLIB)

# 3rd-party! 
set(XCSOAR_JASPER_VERSION "jasper-2.0.16")
# set(XCSOAR_JASPER_VERSION "JasPer-xcsoar)
# add_definitions(-DJAS_XCSOAR)

#  1>Terrain.lib(Loader.obj) : error LNK2019: Verweis auf nicht aufgelöstes externes Symbol "jas_stream_close" in Funktion ""bool __cdecl LoadTerrainOverview(struct zzip_dir *,char const *,char const *,class RasterTileCache &,bool,class OperationEnvironment &)" (?LoadTerrainOverview@@YA_NPEAUzzip_dir@@PEBD1AEAVRasterTileCache@@_NAEAVOperationEnvironment@@@Z)".
# 1>Terrain.lib(Loader.obj) : error LNK2019: Verweis auf nicht aufgelöstes externes Symbol "jas_stream_length" in Funktion ""bool __cdecl LoadTerrainOverview(struct zzip_dir *,char const *,char const *,class RasterTileCache &,bool,class OperationEnvironment &)" (?LoadTerrainOverview@@YA_NPEAUzzip_dir@@PEBD1AEAVRasterTileCache@@_NAEAVOperationEnvironment@@@Z)".

# set(XCSOAR_MAPSERVER_VERSION "mapserver-0.0.1")
set(XCSOAR_MAPSERVER_VERSION "mapserver-xcsoar")
# 3rd-party! 
set(XCSOAR_ZLIB_VERSION "zlib-1.2.11")   # "zlib-1.2.10")
# set(XCSOAR_ZZIP_VERSION "zzip-0.0.1")
# set(XCSOAR_ZZIP_VERSION "zzip-0.36c")
set(XCSOAR_ZZIP_VERSION "zzip-xcsoar")
set(XCSOAR_LIBPNG_VERSION "libpng-1.6.37")

set(XCSOAR_BOOST_VERSION "boost-1.73.0")
# if (NOT BOOST_ROOT)  # now always!!!!
###    set(BOOST_ROOT ${LINK_LIBS}/boost/${XCSOAR_BOOST_VERSION})  # only temporarily
###    set(BOOST_ROOT ${LINK_LIBS}/boost/boost_1_73_0)  # only temporarily
###    set(Boost_ROOT)  # 0 clearing!
# endif()

set(XCSOAR_XMLPARSER_VERSION "xml-1.08")



if (OFF)
# 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party 
# cmake_minimum_required(VERSION 3.15)

message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

# set(EP_BASE "${THIRD_PARTY}/external")  # later remove 'External!' # not used up to now!
set(EP_CMAKE "${THIRD_PARTY}/cmake")  # later remove 'cmake!'
# set(EP_BINARIES "${BINARY_DIR}/3rd_party")  # Binaries dahin verlagern?
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)
option(EP_BUILD_ALWAYS "Build 3rd party packages always?" OFF)
option(EP_BUILD_IN_SOURCE "Build 3rd party in sources (Recommended: OFF)?" OFF)

include(3rd_party/zlib.cmake)
include(3rd_party/lua.cmake)
include(3rd_party/jasper.cmake)
include(3rd_party/zzip.cmake)
include(3rd_party/mapserver.cmake)
include(3rd_party/libpng.cmake)
include(3rd_party/curl.cmake)
include(3rd_party/xmlparser.cmake)
include(3rd_party/boost.cmake)
include(3rd_party/googletest.cmake)
# include(Qt5.cmake)
# include(googlmock.cmake)
# noch nicht! include(boost.cmake)
endif()
