static const TCHAR *const default_modes[] = {
  _T("Nav1"),
  _T("Nav2"),
  _T("Display1"),
  _T("Display2"),
  _T("Config1"),
  _T("Config2"),
  _T("Config3"),
  _T("Info1"),
  _T("Info2"),
  _T("Vario1"),
  _T("Vario2"),
  _T("default.Traffic"),
  _T("Info3"),
  _T("Display1.Traffic"),
  _T("Display2.Traffic"),
  _T("RemoteStick"),
  NULL
};
static constexpr InputConfig::Event default_events[] = {
  { InputEvents::eventBeep, _T("1"), 0 },
  { InputEvents::eventTaskTransition, _T("start"), 1 },
  { InputEvents::eventTaskTransition, _T("finish"), 1 },
  { InputEvents::eventTaskTransition, _T("next"), 1 },
  { InputEvents::eventAutoLogger, _T("start"), 0 },
  { InputEvents::eventAddWaypoint, _T("takeoff"), 5 },
  { InputEvents::eventStatusMessage, _T("Takeoff"), 6 },
  { InputEvents::eventStatusMessage, _T("Landing"), 0 },
  { InputEvents::eventAutoLogger, _T("stop"), 8 },
  { InputEvents::eventStatusMessage, _T("Above final glide"), 0 },
  { InputEvents::eventStatusMessage, _T("Below final glide"), 0 },
  { InputEvents::eventStatusMessage, _T("Final glide through terrain"), 0 },
  { InputEvents::eventMode, _T("default"), 0 },
  { InputEvents::eventPage, _T("restore"), 0 },
  { InputEvents::eventTraffic, _T("details"), 0 },
  { InputEvents::eventPan, _T("down"), 0 },
  { InputEvents::eventPan, _T("up"), 0 },
  { InputEvents::eventPan, _T("left"), 0 },
  { InputEvents::eventPan, _T("right"), 0 },
  { InputEvents::eventPan, _T("off"), 0 },
  { InputEvents::eventZoom, _T("in"), 0 },
  { InputEvents::eventZoom, _T("out"), 0 },
  { InputEvents::eventNearestMapItems, _T(""), 0 },
  { InputEvents::eventQuickMenu, _T(""), 0 },
  { InputEvents::eventAnalysis, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 25 },
  { InputEvents::eventChecklist, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 27 },
  { InputEvents::eventFlarmTraffic, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 29 },
  { InputEvents::eventGotoLookup, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 31 },
  { InputEvents::eventSetup, _T("Alternates"), 0 },
  { InputEvents::eventMode, _T("default"), 33 },
  { InputEvents::eventSetup, _T("Task"), 0 },
  { InputEvents::eventMode, _T("default"), 35 },
  { InputEvents::eventSetup, _T("Basic"), 0 },
  { InputEvents::eventMode, _T("default"), 37 },
  { InputEvents::eventMode, _T("Menu"), 0 },
  { InputEvents::eventMode, _T("Nav1"), 0 },
  { InputEvents::eventMode, _T("Display1"), 0 },
  { InputEvents::eventMode, _T("Config1"), 0 },
  { InputEvents::eventMode, _T("Info1"), 0 },
  { InputEvents::eventFLARMRadar, _T("toggle"), 0 },
  { InputEvents::eventClearAirspaceWarnings, _T(""), 44 },
  { InputEvents::eventClearStatusMessages, _T(""), 45 },
  { InputEvents::eventScreenModes, _T("previous"), 0 },
  { InputEvents::eventScreenModes, _T("next"), 0 },
  { InputEvents::eventZoom, _T("auto show"), 0 },
  { InputEvents::eventZoom, _T("auto on"), 49 },
  { InputEvents::eventWaypointDetails, _T("select"), 0 },
  { InputEvents::eventCalculator, _T(""), 0 },
  { InputEvents::eventPan, _T("on"), 0 },
  { InputEvents::eventStatus, _T("all"), 0 },
  { InputEvents::eventSetup, _T("Target"), 0 },
  { InputEvents::eventMode, _T("Nav2"), 0 },
  { InputEvents::eventMode, _T("default"), 52 },
  { InputEvents::eventAdjustWaypoint, _T("previousarm"), 0 },
  { InputEvents::eventAdjustWaypoint, _T("nextarm"), 0 },
  { InputEvents::eventMode, _T("default"), 51 },
  { InputEvents::eventAbortTask, _T("toggle"), 13 },
  { InputEvents::eventStatusMessage, _T("Dropped marker"), 13 },
  { InputEvents::eventLogger, _T("note Mark"), 62 },
  { InputEvents::eventMarkLocation, _T(""), 63 },
  { InputEvents::eventMode, _T("default"), 55 },
  { InputEvents::eventMode, _T("Display2"), 0 },
  { InputEvents::eventZoom, _T("auto toggle"), 49 },
  { InputEvents::eventScreenModes, _T("cycle"), 0 },
  { InputEvents::eventDeclutterLabels, _T("show"), 0 },
  { InputEvents::eventDeclutterLabels, _T("toggle"), 69 },
  { InputEvents::eventSnailTrail, _T("show"), 0 },
  { InputEvents::eventSnailTrail, _T("toggle"), 71 },
  { InputEvents::eventTerrainTopography, _T("terrain toggle"), 0 },
  { InputEvents::eventTerrainTopography, _T("topography toggle"), 0 },
  { InputEvents::eventAirSpace, _T("toggle"), 0 },
  { InputEvents::eventMode, _T("Config2"), 0 },
  { InputEvents::eventSetup, _T("System"), 0 },
  { InputEvents::eventMode, _T("default"), 77 },
  { InputEvents::eventSetup, _T("Plane"), 0 },
  { InputEvents::eventMode, _T("default"), 79 },
  { InputEvents::eventDevice, _T("list"), 0 },
  { InputEvents::eventMode, _T("default"), 81 },
  { InputEvents::eventSetup, _T("Wind"), 0 },
  { InputEvents::eventMode, _T("default"), 83 },
  { InputEvents::eventMode, _T("Config3"), 0 },
  { InputEvents::eventSetup, _T("Profile"), 0 },
  { InputEvents::eventMode, _T("default"), 86 },
  { InputEvents::eventWaypointEditor, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 88 },
  { InputEvents::eventFileManager, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 90 },
  { InputEvents::eventSetup, _T("Replay"), 0 },
  { InputEvents::eventMode, _T("default"), 92 },
  { InputEvents::eventLogger, _T("show"), 0 },
  { InputEvents::eventLogger, _T("toggle ask"), 94 },
  { InputEvents::eventRunLuaFile, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 96 },
  { InputEvents::eventMode, _T("Vario1"), 0 },
  { InputEvents::eventMode, _T("Vario2"), 0 },
  { InputEvents::eventSetup, _T("Switches"), 0 },
  { InputEvents::eventMode, _T("default"), 100 },
  { InputEvents::eventAdjustVarioFilter, _T("xdemo"), 0 },
  { InputEvents::eventAdjustVarioFilter, _T("zero"), 0 },
  { InputEvents::eventAdjustVarioFilter, _T("accel"), 0 },
  { InputEvents::eventStatusMessage, _T("Vario ASI zeroed"), 103 },
  { InputEvents::eventStatusMessage, _T("Accelerometer leveled"), 0 },
  { InputEvents::eventAdjustVarioFilter, _T("save"), 0 },
  { InputEvents::eventStatusMessage, _T("Stored to EEPROM"), 107 },
  { InputEvents::eventAdjustVarioFilter, _T("demostf"), 0 },
  { InputEvents::eventAdjustVarioFilter, _T("democlimb"), 0 },
  { InputEvents::eventMode, _T("Info2"), 0 },
  { InputEvents::eventWeather, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 112 },
  { InputEvents::eventMode, _T("default"), 23 },
  { InputEvents::eventMode, _T("Info3"), 0 },
  { InputEvents::eventMode, _T("default"), 54 },
  { InputEvents::eventSetup, _T("Teamcode"), 0 },
  { InputEvents::eventMode, _T("default"), 117 },
  { InputEvents::eventFlarmDetails, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 119 },
  { InputEvents::eventThermalAssistant, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 121 },
  { InputEvents::eventCredits, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 123 },
  { InputEvents::eventAirSpace, _T("list"), 0 },
  { InputEvents::eventMode, _T("default"), 125 },
  { InputEvents::eventRepeatStatusMessage, _T(""), 0 },
  { InputEvents::eventLockScreen, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 128 },
  { InputEvents::eventExit, _T("system"), 0 },
  { InputEvents::eventMode, _T("default"), 130 },
  { InputEvents::eventTraffic, _T("zoom in"), 0 },
  { InputEvents::eventTraffic, _T("zoom out"), 0 },
  { InputEvents::eventTraffic, _T("zoom auto toggle"), 0 },
  { InputEvents::eventTraffic, _T("northup toggle"), 0 },
  { InputEvents::eventTraffic, _T("label toggle"), 0 },
  { InputEvents::eventMacCready, _T("auto show"), 0 },
  { InputEvents::eventMacCready, _T("auto toggle"), 137 },
  { InputEvents::eventSetup, _T("Airspace"), 0 },
  { InputEvents::eventMode, _T("default"), 139 },
  { InputEvents::eventLogger, _T("nmea"), 0 },
  { InputEvents::eventNearestAirspaceDetails, _T(""), 0 },
  { InputEvents::eventMode, _T("default"), 142 },
};
static constexpr struct flat_event_map default_key2event[] = {
  { 4, KEY_ESCAPE, 13 },
  { 5, KEY_ESCAPE, 13 },
  { 6, KEY_ESCAPE, 13 },
  { 7, KEY_ESCAPE, 13 },
  { 8, KEY_ESCAPE, 13 },
  { 9, KEY_ESCAPE, 13 },
  { 10, KEY_ESCAPE, 13 },
  { 11, KEY_ESCAPE, 13 },
  { 12, KEY_ESCAPE, 13 },
  { 3, KEY_ESCAPE, 13 },
  { 13, KEY_ESCAPE, 13 },
  { 14, KEY_ESCAPE, 13 },
  { 0, KEY_ESCAPE, 14 },
  { 1, KEY_ESCAPE, 14 },
  { 15, KEY_RETURN, 15 },
  { 1, KEY_DOWN, 16 },
  { 1, KEY_UP, 17 },
  { 1, KEY_LEFT, 18 },
  { 1, KEY_RIGHT, 19 },
  { 1, KEY_APP1, 20 },
  { 1, KEY_APP2, 21 },
  { 1, KEY_APP3, 22 },
  { 1, KEY_APP4, 23 },
  { 0, KEY_F1, 24 },
  { 0, KEY_F2, 26 },
  { 0, KEY_F3, 28 },
  { 0, KEY_F4, 30 },
  { 0, KEY_F5, 32 },
  { 0, KEY_F6, 34 },
  { 0, KEY_F7, 36 },
  { 0, KEY_F8, 38 },
  { 0, KEY_MENU, 39 },
  { 0, KEY_APP1, 40 },
  { 0, KEY_APP2, 41 },
  { 0, KEY_APP3, 42 },
  { 0, KEY_APP4, 43 },
  { 0, KEY_DOWN, 22 },
  { 0, KEY_UP, 21 },
  { 0, KEY_RETURN, 46 },
  { 0, KEY_LEFT, 47 },
  { 0, KEY_RIGHT, 48 },
  { 0, (int)'6', 38 },
  { 0, (int)'7', 52 },
  { 0, (int)'9', 55 },
  { 4, KEY_APP1, 56 },
  { 4, (int)'6', 57 },
  { 4, (int)'7', 58 },
  { 4, (int)'8', 59 },
  { 4, (int)'9', 60 },
  { 4, (int)'0', 34 },
  { 5, KEY_APP1, 13 },
  { 5, (int)'6', 61 },
  { 5, (int)'7', 64 },
  { 5, (int)'9', 65 },
  { 6, KEY_APP2, 66 },
  { 6, (int)'6', 21 },
  { 6, (int)'7', 22 },
  { 6, (int)'8', 67 },
  { 6, (int)'9', 68 },
  { 6, (int)'0', 53 },
  { 7, KEY_APP2, 13 },
  { 7, (int)'6', 70 },
  { 7, (int)'7', 72 },
  { 7, (int)'8', 73 },
  { 7, (int)'9', 74 },
  { 7, (int)'0', 75 },
  { 8, KEY_APP3, 76 },
  { 8, (int)'6', 78 },
  { 8, (int)'7', 80 },
  { 8, (int)'8', 82 },
  { 8, (int)'9', 38 },
  { 8, (int)'0', 84 },
  { 9, KEY_APP3, 85 },
  { 9, (int)'6', 87 },
  { 9, (int)'8', 89 },
  { 9, (int)'9', 91 },
  { 9, (int)'0', 93 },
  { 10, KEY_APP3, 13 },
  { 10, (int)'6', 95 },
  { 10, (int)'7', 97 },
  { 10, (int)'9', 98 },
  { 13, KEY_APP3, 99 },
  { 13, (int)'6', 101 },
  { 13, (int)'8', 102 },
  { 13, (int)'9', 103 },
  { 13, (int)'0', 104 },
  { 14, KEY_APP3, 13 },
  { 14, (int)'6', 105 },
  { 14, (int)'7', 106 },
  { 14, (int)'8', 108 },
  { 14, (int)'9', 109 },
  { 14, (int)'0', 110 },
  { 11, KEY_APP4, 111 },
  { 11, (int)'6', 30 },
  { 11, (int)'7', 113 },
  { 11, (int)'8', 114 },
  { 11, (int)'9', 28 },
  { 11, (int)'0', 26 },
  { 12, KEY_APP4, 115 },
  { 12, (int)'6', 116 },
  { 12, (int)'8', 118 },
  { 12, (int)'9', 120 },
  { 12, (int)'0', 122 },
  { 16, KEY_APP4, 13 },
  { 16, (int)'6', 124 },
  { 16, (int)'7', 126 },
  { 16, (int)'8', 127 },
  { 3, KEY_APP1, 40 },
  { 3, KEY_APP2, 41 },
  { 3, KEY_APP3, 42 },
  { 3, KEY_APP4, 43 },
  { 3, (int)'9', 129 },
  { 3, (int)'9', 13 },
  { 3, (int)'0', 131 },
  { 17, (int)'6', 132 },
  { 17, (int)'7', 133 },
  { 17, (int)'8', 134 },
  { 17, (int)'0', 135 },
  { 18, (int)'6', 136 },
  { 19, (int)'0', 57 },
  { 19, (int)'0', 58 },
  { 19, (int)'0', 59 },
  { 19, (int)'0', 60 },
  { 19, (int)'0', 34 },
  { 19, (int)'0', 61 },
  { 19, (int)'0', 32 },
  { 19, (int)'0', 65 },
  { 19, (int)'0', 67 },
  { 19, (int)'0', 64 },
  { 19, (int)'0', 53 },
  { 19, (int)'0', 70 },
  { 19, (int)'0', 72 },
  { 19, (int)'0', 73 },
  { 19, (int)'0', 74 },
  { 19, (int)'0', 138 },
  { 19, (int)'0', 38 },
  { 19, (int)'0', 84 },
  { 19, (int)'0', 78 },
  { 19, (int)'0', 140 },
  { 19, (int)'0', 95 },
  { 19, (int)'0', 141 },
  { 19, (int)'0', 82 },
  { 19, (int)'0', 80 },
  { 19, (int)'0', 29 },
  { 19, (int)'0', 113 },
  { 19, (int)'0', 143 },
  { 19, (int)'0', 28 },
  { 19, (int)'0', 26 },
  { 19, (int)'0', 116 },
  { 19, (int)'0', 122 },
  { 0, 0, 0 },
};
static constexpr struct flat_event_map default_gc2event[] = {
  { 0, GCE_TASK_START, 2 },
  { 0, GCE_TASK_FINISH, 3 },
  { 0, GCE_TASK_NEXTWAYPOINT, 4 },
  { 0, GCE_TAKEOFF, 7 },
  { 0, GCE_LANDING, 9 },
  { 0, GCE_FLIGHTMODE_FINALGLIDE_ABOVE, 10 },
  { 0, GCE_FLIGHTMODE_FINALGLIDE_BELOW, 11 },
  { 0, GCE_FLIGHTMODE_FINALGLIDE_TERRAIN, 12 },
  { 0, GCE_LANDABLE_UNREACHABLE, 1 },
  { 0, 0, 0 },
};
static constexpr struct flat_event_map default_n2event[] = {
  { 0, 0, 0 },
};
static constexpr struct flat_label default_labels[] = {
  { 1, 1, 20, _T("Pan\nOff") },
  { 1, 2, 21, _T("Zoom\nIn") },
  { 1, 3, 22, _T("Zoom\nOut") },
  { 1, 4, 23, _T("What's\nhere?") },
  { 4, 1, 56, _T("Nav\n1/2") },
  { 4, 5, 57, _T("Task") },
  { 4, 6, 58, _T("$(WaypointPreviousArm)") },
  { 4, 7, 59, _T("$(WaypointNextArm)") },
  { 4, 8, 60, _T("Waypoint\nList$(CheckWaypointFile)") },
  { 4, 9, 34, _T("Alternates$(CheckWaypointFile)") },
  { 5, 1, 13, _T("Nav\n2/2") },
  { 5, 5, 61, _T("Task\n$(TaskAbortToggleActionName)$(CheckWaypointFile)") },
  { 5, 6, 64, _T("Mark\nDrop") },
  { 5, 7, 65, _T("Target$(CheckTask)$(CheckTaskResumed)") },
  { 6, 2, 66, _T("Display\n1/2") },
  { 6, 5, 21, _T("Zoom\nIn") },
  { 6, 6, 22, _T("Zoom\nOut") },
  { 6, 7, 67, _T("Zoom\n$(ZoomAutoToggleActionName)") },
  { 6, 8, 68, _T("$(NextPageName)") },
  { 6, 9, 53, _T("Pan\nOn") },
  { 7, 2, 13, _T("Display\n2/2") },
  { 7, 5, 70, _T("Labels\n$(MapLabelsToggleActionName)") },
  { 7, 6, 72, _T("Trail\n$(SnailTrailToggleName)") },
  { 7, 7, 73, _T("Terrain\n$(TerrainToggleActionName)") },
  { 7, 8, 74, _T("Topo.\n$(TopographyToggleActionName)") },
  { 7, 9, 75, _T("Airspace\n$(AirspaceToggleActionName)") },
  { 8, 3, 76, _T("Config\n1/3") },
  { 8, 5, 78, _T("System") },
  { 8, 6, 80, _T("Plane") },
  { 8, 7, 82, _T("Devices") },
  { 8, 8, 38, _T("Flight") },
  { 8, 9, 84, _T("Wind") },
  { 9, 3, 85, _T("Config\n2/3") },
  { 9, 5, 87, _T("Profiles") },
  { 9, 7, 89, _T("Waypoints Editor") },
  { 9, 8, 91, _T("File Manager") },
  { 9, 9, 93, _T("Replay$(CheckReplay)") },
  { 10, 3, 13, _T("Config\n3/3") },
  { 10, 5, 95, _T("Logger\n$(LoggerActive)$(CheckLogger)") },
  { 10, 6, 97, _T("Lua") },
  { 10, 8, 98, _T("Vega$(CheckVega)") },
  { 13, 3, 99, _T("Vega\n1/2") },
  { 13, 5, 101, _T("Airframe\nSwitches") },
  { 13, 7, 102, _T("Manual\nDemo") },
  { 13, 8, 103, _T("Setup\nStall") },
  { 13, 9, 104, _T("Accel") },
  { 14, 3, 13, _T("Vega\n2/2") },
  { 14, 5, 105, _T("ASI\nZero") },
  { 14, 6, 106, _T("Accel\nZero") },
  { 14, 7, 108, _T("Store") },
  { 14, 8, 109, _T("Cruise\nDemo") },
  { 14, 9, 110, _T("Climb\nDemo") },
  { 11, 4, 111, _T("Info\n1/3") },
  { 11, 5, 30, _T("FLARM Radar$(CheckFLARM)") },
  { 11, 6, 113, _T("Weather") },
  { 11, 7, 114, _T("What's\nhere?") },
  { 11, 8, 28, _T("Check\nlist") },
  { 11, 9, 26, _T("Analysis") },
  { 12, 4, 115, _T("Info\n2/3") },
  { 12, 5, 116, _T("Status") },
  { 12, 7, 118, _T("Team\nCode") },
  { 12, 8, 120, _T("Traffic List") },
  { 12, 9, 122, _T("Thermal Assistant") },
  { 16, 4, 13, _T("Info\n3/3") },
  { 16, 5, 124, _T("Credits") },
  { 16, 6, 126, _T("Airspaces") },
  { 16, 7, 127, _T("Message\nRepeat") },
  { 3, 1, 40, _T("Nav") },
  { 3, 2, 41, _T("Display") },
  { 3, 3, 42, _T("Config") },
  { 3, 4, 43, _T("Info") },
  { 3, 7, 129, _T("Lock\nScreen") },
  { 3, 8, 13, _T("Cancel") },
  { 3, 9, 131, _T("Quit") },
  { 17, 5, 132, _T("Zoom\nIn") },
  { 17, 6, 133, _T("Zoom\nOut") },
  { 17, 7, 134, _T("Zoom\n$(TrafficZoomAutoToggleActionName)") },
  { 17, 9, 135, _T("$(TrafficNorthUpToggleActionName)") },
  { 18, 5, 136, _T("AVG/ALT") },
  { 19, 0, 57, _T("Task") },
  { 19, 1, 58, _T("$(WaypointPreviousArm)") },
  { 19, 2, 59, _T("$(WaypointNextArm)") },
  { 19, 3, 60, _T("Waypoint\nList$(CheckWaypointFile)") },
  { 19, 4, 34, _T("Alternates$(CheckWaypointFile)") },
  { 19, 5, 61, _T("Task\n$(TaskAbortToggleActionName)$(CheckWaypointFile)") },
  { 19, 6, 32, _T("GoTo$(CheckWaypointFile)") },
  { 19, 7, 65, _T("Target$(CheckTask)$(CheckTaskResumed)") },
  { 19, 9, 67, _T("Zoom\n$(ZoomAutoToggleActionName)") },
  { 19, 10, 64, _T("Mark\nDrop") },
  { 19, 11, 53, _T("Pan\nOn") },
  { 19, 12, 70, _T("Labels\n$(MapLabelsToggleActionName)") },
  { 19, 13, 72, _T("Trail\n$(SnailTrailToggleName)") },
  { 19, 14, 73, _T("Terrain\n$(TerrainToggleActionName)") },
  { 19, 15, 74, _T("Topo.\n$(TopographyToggleActionName)") },
  { 19, 16, 138, _T("$(CheckAutoMc)MC\n$(MacCreadyToggleActionName)") },
  { 19, 17, 38, _T("Flight\nSetup") },
  { 19, 18, 84, _T("Setup\nWind") },
  { 19, 19, 78, _T("Setup\nSystem") },
  { 19, 20, 140, _T("Settings\nAirspace$(CheckAirspace)") },
  { 19, 21, 95, _T("Logger\n$(LoggerActive)$(CheckLogger)") },
  { 19, 22, 141, _T("Raw Logger$(CheckLogger)") },
  { 19, 23, 82, _T("Devices") },
  { 19, 24, 80, _T("Setup Plane") },
  { 19, 25, 29, _T("FLARM Radar$(CheckFLARM)") },
  { 19, 26, 113, _T("Weather") },
  { 19, 27, 143, _T("Nearest\nAirspace$(CheckAirspace)") },
  { 19, 28, 28, _T("Check\nlist") },
  { 19, 29, 26, _T("Analysis") },
  { 19, 30, 116, _T("Status") },
  { 19, 31, 122, _T("Thermal Assistant$(CheckCircling)") },
  { 0, 0, 0, NULL },
};
static constexpr struct flat_gesture_map default_gesture2event[] = {
  { 0, 21, _T("U") },
  { 0, 22, _T("D") },
  { 0, 50, _T("UD") },
  { 0, 47, _T("R") },
  { 0, 48, _T("L") },
  { 0, 51, _T("DR") },
  { 0, 33, _T("DL") },
  { 0, 39, _T("DU") },
  { 0, 52, _T("RD") },
  { 0, 25, _T("URD") },
  { 0, 53, _T("URDL") },
  { 0, 54, _T("LDRDL") },
  { 0, 0, NULL },
};