# 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party # 3rd-Party 
cmake_minimum_required(VERSION 3.15)

message(STATUS "+++ Start CMake ${CMAKE_CURRENT_SOURCE_DIR}!")

set(EP_BASE "${THIRD_PARTY}/external")  # later remove 'External!'
set(EP_CMAKE "${THIRD_PARTY}/cmake")  # later remove 'cmake!'
option(USE_SYSTEM_${TARGET_CNAME} "Should we use the system ${TARGET_NAME}?" OFF)
option(EP_BUILD_ALWAYS "Build 3rd party packages always?" OFF)
option(EP_BUILD_IN_SOURCE "Build 3rd party in sources (Recommended: OFF)?" OFF)



# add_subdirectory(lua)
# add_subdirectory(zlib)
include(curl.cmake)
include(lua.cmake)
include(zlib.cmake)
include(jasper.cmake)
include(zzip.cmake)
include(mapserver.cmake)
include(libpng.cmake)
# add_subdirectory(mapserver)
# noch nicht! add_subdirectory(boost)
# add_subdirectory(zzip)
