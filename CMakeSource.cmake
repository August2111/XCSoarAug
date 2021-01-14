# Location ./XCSoarAug/CMakeSour
# What is better?
# * src/Airspace/Airspace.cmake   or
# * src/Airspace/CMakeSource.cmake

include(src/_Deprecated/CMakeSource.cmake)
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

#==============================================================================
### NO LIBRARY: ###
set(Compatibility_SOURCES
        Compatibility/fmode.cpp
)

set(Markers_SOURCES
        Markers/Markers.cpp
)
#==============================================================================


# list(APPEND XCSOAR_SOURCE_LISTS
set(XCSOAR_LIB_LISTS
    _Deprecated
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
    Lua
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
