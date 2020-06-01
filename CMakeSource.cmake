# Location ./XCSoarAug/CMakeSour
# What is better?
# * src/Airspace/Airspace.cmake   or
# * src/Airspace/CMakeSource.cmake

include(src/Airspace/CMakeSource.cmake)
include(src/Atmosphere/CMakeSource.cmake)
include(src/Audio/CMakeSource.cmake)
include(src/Blackboard/CMakeSource.cmake)
include(src/Computer/CMakeSource.cmake)
include(src/CrossSection/CMakeSource.cmake)
include(src/Device/CMakeSource.cmake)
include(src/Dialogs/CMakeSource.cmake)
include(src/Engine/CMakeSource.cmake)
include(src/Event/CMakeSource.cmake)
include(src/FLARM/CMakeSource.cmake)
include(src/Form/CMakeSource.cmake)
include(src/Formatter/CMakeSource.cmake)
include(src/Gauge/CMakeSource.cmake)
include(src/Geo/CMakeSource.cmake)
include(src/Hardware/CMakeSource.cmake)
include(src/IGC/CMakeSource.cmake)
include(src/InfoBoxes/CMakeSource.cmake)
include(src/Input/CMakeSource.cmake)
include(src/IO/CMakeSource.cmake)
include(src/Job/CMakeSource.cmake)
include(src/Language/CMakeSource.cmake)
include(src/Logger/CMakeSource.cmake)
include(src/Look/CMakeSource.cmake)
include(src/Lua/CMakeSource.cmake)
include(src/MapWindow/CMakeSource.cmake)
# include(src/Markers/CMakeSource.cmake)
include(src/Math/CMakeSource.cmake)
include(src/Menu/CMakeSource.cmake)
include(src/Monitor/CMakeSource.cmake)
include(src/Net/CMakeSource.cmake)
include(src/NMEA/CMakeSource.cmake)
include(src/Operation/CMakeSource.cmake)
include(src/OS/CMakeSource.cmake)
include(src/Plane/CMakeSource.cmake)
include(src/Polar/CMakeSource.cmake)
include(src/Profile/CMakeSource.cmake)
include(src/Projection/CMakeSource.cmake)
include(src/Renderer/CMakeSource.cmake)
include(src/Replay/CMakeSource.cmake)
include(src/Repository/CMakeSource.cmake)
include(src/Screen/CMakeSource.cmake)
include(src/Task/CMakeSource.cmake)
include(src/TeamCode/CMakeSource.cmake)
include(src/TeamCode/CMakeSource.cmake)
include(src/Terrain/CMakeSource.cmake)
include(src/Thread/CMakeSource.cmake)
include(src/Time/CMakeSource.cmake)
include(src/Topography/CMakeSource.cmake)
include(src/Tracking/CMakeSource.cmake)
include(src/UIUtil/CMakeSource.cmake)
include(src/Units/CMakeSource.cmake)
include(src/Util/CMakeSource.cmake)
include(src/Waypoint/CMakeSource.cmake)
include(src/Weather/CMakeSource.cmake)
include(src/Widget/CMakeSource.cmake)
include(src/XML/CMakeSource.cmake)
# include(src//CMakeSource.cmake)

# set(zzip_SOURCES
#         zzip/fetch.c
#         zzip/file.c
#         zzip/plugin.c
#         zzip/stat.c
#         zzip/zip.c
# )
set(Compatibility_SOURCES
        Compatibility/fmode.cpp
)

set(Markers_SOURCES
        Markers/Markers.cpp
)

### set (MapServer_SOURCES
###    not used up to now!
###         Topography/shapelib/mapalloc.c
###         Topography/shapelib/mapbits.c
###         Topography/shapelib/mapprimitive.c
###         Topography/shapelib/mapsearch.c
###         Topography/shapelib/mapshape.c
###         Topography/shapelib/mapstring.c
###         Topography/shapelib/maptree.c
###         Topography/shapelib/mapxbase.c
### )

### set(jasper_SOURCES
###         jasper/base/jas_malloc.c
###         jasper/base/jas_seq.c
###         jasper/base/jas_stream.c
###         jasper/base/jas_string.c
###         jasper/base/jas_tvp.c
###         jasper/jp2/jp2_cod.c
###         jasper/jpc/jpc_bs.c
###         jasper/jpc/jpc_cs.c
###         jasper/jpc/jpc_dec.c
###         jasper/jpc/jpc_math.c
###         jasper/jpc/jpc_mqcod.c
###         jasper/jpc/jpc_mqdec.c
###         jasper/jpc/jpc_qmfb.c
###         jasper/jpc/jpc_rtc.cpp
###         jasper/jpc/jpc_t1cod.c
###         jasper/jpc/jpc_t1dec.c
###         jasper/jpc/jpc_t2cod.c
###         jasper/jpc/jpc_t2dec.c
###         jasper/jpc/jpc_tagtree.c
###         jasper/jpc/jpc_tsfb.c
### )
# set(jasper_SOURCES
#         Terrain/jasper/base/jas_malloc.c
#         Terrain/jasper/base/jas_seq.c
#         Terrain/jasper/base/jas_stream.c
#         Terrain/jasper/base/jas_string.c
#         Terrain/jasper/base/jas_tvp.c
#         Terrain/jasper/jp2/jp2_cod.c
#         Terrain/jasper/jpc/jpc_bs.c
#         Terrain/jasper/jpc/jpc_cs.c
#         Terrain/jasper/jpc/jpc_dec.c
#         Terrain/jasper/jpc/jpc_math.c
#         Terrain/jasper/jpc/jpc_mqcod.c
#         Terrain/jasper/jpc/jpc_mqdec.c
#         Terrain/jasper/jpc/jpc_qmfb.c
#         Terrain/jasper/jpc/jpc_rtc.cpp
#         Terrain/jasper/jpc/jpc_t1cod.c
#         Terrain/jasper/jpc/jpc_t1dec.c
#         Terrain/jasper/jpc/jpc_t2cod.c
#         Terrain/jasper/jpc/jpc_t2dec.c
#         Terrain/jasper/jpc/jpc_tagtree.c
#         Terrain/jasper/jpc/jpc_tsfb.c
# )

# list(APPEND XCSOAR_SOURCE_LISTS
set(XCSOAR_LIB_LISTS 
    

    Profile  # profile.a
#!!!    Engine #???
    Renderer  ##??
#!!!!    Terrain   # libterrain.a
    Widget    # libwidget.a
    Form      # form.a
    # AR      output/UNIX/dbg/datafield.a
    Look      # liblook.a
    Screen    # screen.a
    Event     # libevent.a
    # AR      output/UNIX/dbg/libresource.a
    # AR      output/UNIX/dbg/resources.a
    # AR      output/UNIX/dbg/libdata.a
    # AR      output/UNIX/dbg/driver.a
    # AR      output/UNIX/dbg/port.a
    IO        # io.a
    # AR      output/UNIX/dbg/async.a
    Task  # libtask
    # AR      output/UNIX/dbg/libcontest.a
    # AR      output/UNIX/dbg/libroute.a
    # AR      output/UNIX/dbg/libglide.a
    # AR      output/UNIX/dbg/libwaypoint.a
    Airspace  # AR      output/UNIX/dbg/libairspace.a
    Net     
## ??    Time    
    OS      
    Thread  
    Util    
## !!    Geo     
##??    Math    

    InfoBoxes ## ??

    Computer
    CrossSection
    Gauge

    # Airspace
    Atmosphere
    Audio
    Blackboard
    # Computer
    # CrossSection
    Dialogs
#???    Engine
    # Event
    FLARM
    # Form
    Formatter
    # Gauge
    # Geo
    Hardware
    IGC
## ??    InfoBoxes
    Input
    Job
    Language
    Logger
    # Look
    xcsLua
    #  lua1
    Markers
    # Math
    Menu
    Monitor
    # Net
    NMEA
    Operation
    # OS
    Plane
    Polar
    # Profile
## !!!    Projection
## ??    Renderer
    Replay
    Repository
    # Screen
    # Task
    TeamCode
    # Terrain
    # Thread
    # Time
    Topography
    UIUtil
    Units
    # Util
    Waypoint
    Weather
    # Widget
    XML

    Device
    Dialogs
    # IO
    MapWindow
    Tracking

#!!!!    Math ## ??   
    Time ## ??
)


list(APPEND XCSOAR_SOURCE_LISTS ${XCSOAR_LIB_LISTS})
