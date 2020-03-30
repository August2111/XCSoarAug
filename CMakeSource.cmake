
set(Airspace_SOURCES
        Airspace/ActivePredicate.cpp
        Airspace/AirspaceComputerSettings.cpp
        Airspace/AirspaceGlue.cpp
        Airspace/AirspaceParser.cpp
        Airspace/AirspaceVisibility.cpp
        Airspace/NearestAirspace.cpp
        Airspace/ProtectedAirspaceWarningManager.cpp
)

set(Atmosphere_SOURCES
        Atmosphere/AirDensity.cpp
        Atmosphere/CuSonde.cpp
        Atmosphere/Pressure.cpp
)

set(Audio_SOURCES
        Audio/Settings.cpp
        Audio/Sound.cpp
        Audio/VarioSettings.cpp
)

set(Blackboard_SOURCES
        Blackboard/BlackboardListener.cpp
        Blackboard/DeviceBlackboard.cpp
        Blackboard/InterfaceBlackboard.cpp
        Blackboard/LiveBlackboard.cpp
        Blackboard/ProxyBlackboardListener.cpp
        Blackboard/RateLimitedBlackboardListener.cpp
        Blackboard/ScopeCalculatedListener.cpp
        Blackboard/ScopeGPSListener.cpp
)

set(Compatibility_SOURCES
        Compatibility/fmode.cpp
)

set(Computer_SOURCES
        Computer/AutoQNH.cpp
        Computer/AverageVarioComputer.cpp
        Computer/BasicComputer.cpp
        Computer/CirclingComputer.cpp
        Computer/ClimbAverageCalculator.cpp
        Computer/ConditionMonitor/ConditionMonitor.cpp
        Computer/ConditionMonitor/ConditionMonitorAATTime.cpp
        Computer/ConditionMonitor/ConditionMonitorFinalGlide.cpp
        Computer/ConditionMonitor/ConditionMonitorGlideTerrain.cpp
        Computer/ConditionMonitor/ConditionMonitorLandableReachable.cpp
        Computer/ConditionMonitor/ConditionMonitors.cpp
        Computer/ConditionMonitor/ConditionMonitorSunset.cpp
        Computer/ConditionMonitor/ConditionMonitorWind.cpp
        Computer/ContestComputer.cpp
        Computer/CuComputer.cpp
        Computer/Events.cpp
        Computer/FlyingComputer.cpp
        Computer/GlideComputer.cpp
        Computer/GlideComputerAirData.cpp
        Computer/GlideComputerBlackboard.cpp
        Computer/GlideComputerInterface.cpp
        Computer/GlideRatioCalculator.cpp
        Computer/GlideRatioComputer.cpp
        Computer/GroundSpeedComputer.cpp
        Computer/LiftDatabaseComputer.cpp
        Computer/LogComputer.cpp
        Computer/RouteComputer.cpp
        Computer/Settings.cpp
        Computer/StatsComputer.cpp
        Computer/TaskComputer.cpp
        Computer/ThermalBandComputer.cpp
        Computer/ThermalBase.cpp
        Computer/ThermalLocator.cpp
        Computer/TraceComputer.cpp
        Computer/WarningComputer.cpp
        Computer/WaveComputer.cpp
        Computer/Wind/CirclingWind.cpp
        Computer/Wind/Computer.cpp
        Computer/Wind/MeasurementList.cpp
        Computer/Wind/Settings.cpp
        Computer/Wind/Store.cpp
        Computer/Wind/WindEKF.cpp
        Computer/Wind/WindEKFGlue.cpp
)

set(CrossSection_SOURCES
        CrossSection/AirspaceXSRenderer.cpp
        CrossSection/CrossSectionRenderer.cpp
        CrossSection/CrossSectionWidget.cpp
        CrossSection/CrossSectionWindow.cpp
        CrossSection/TerrainXSRenderer.cpp
)

set(Device_SOURCES
        Device/Config.cpp
        Device/Declaration.cpp
        Device/Descriptor.cpp
        Device/device.cpp
        Device/Dispatcher.cpp
        Device/Driver.cpp
        Device/Driver/AirControlDisplay.cpp
        Device/Driver/AltairPro.cpp
        Device/Driver/ATR833.cpp
        Device/Driver/BlueFly/Misc.cpp
        Device/Driver/BlueFly/Parser.cpp
        Device/Driver/BlueFly/Register.cpp
        Device/Driver/BlueFly/Settings.cpp
        Device/Driver/BorgeltB50.cpp
        Device/Driver/CAI302/Declare.cpp
        Device/Driver/CAI302/Logger.cpp
        Device/Driver/CAI302/Manage.cpp
        Device/Driver/CAI302/Mode.cpp
        Device/Driver/CAI302/Parser.cpp
        Device/Driver/CAI302/PocketNav.cpp
        Device/Driver/CAI302/Protocol.cpp
        Device/Driver/CAI302/Register.cpp
        Device/Driver/CAI302/Settings.cpp
        Device/Driver/CaiGpsNav.cpp
        Device/Driver/CaiLNav.cpp
        Device/Driver/Condor.cpp
        Device/Driver/CProbe.cpp
        Device/Driver/EW.cpp
        Device/Driver/EWMicroRecorder.cpp
        Device/Driver/Eye.cpp
        Device/Driver/FLARM/BinaryProtocol.cpp
        Device/Driver/FLARM/CRC16.cpp
        Device/Driver/FLARM/Declare.cpp
        Device/Driver/FLARM/Device.cpp
        Device/Driver/FLARM/Logger.cpp
        Device/Driver/FLARM/Mode.cpp
        Device/Driver/FLARM/Parser.cpp
        Device/Driver/FLARM/Register.cpp
        Device/Driver/FLARM/Settings.cpp
        Device/Driver/FLARM/StaticParser.cpp
        Device/Driver/FLARM/TextProtocol.cpp
        Device/Driver/FlymasterF1.cpp
        Device/Driver/FlyNet.cpp
        Device/Driver/Flytec/Logger.cpp
        Device/Driver/Flytec/Parser.cpp
        Device/Driver/Flytec/Register.cpp
        Device/Driver/Generic.cpp
        Device/Driver/ILEC.cpp
        Device/Driver/IMI/Declare.cpp
        Device/Driver/IMI/Internal.cpp
        Device/Driver/IMI/Logger.cpp
        Device/Driver/IMI/Protocol/Checksum.cpp
        Device/Driver/IMI/Protocol/Communication.cpp
        Device/Driver/IMI/Protocol/Conversion.cpp
        Device/Driver/IMI/Protocol/IGC.cpp
        Device/Driver/IMI/Protocol/MessageParser.cpp
        Device/Driver/IMI/Protocol/Protocol.cpp
        Device/Driver/IMI/Register.cpp
        Device/Driver/KRT2.cpp
        Device/Driver/Leonardo.cpp
        Device/Driver/LevilAHRS_G.cpp
        Device/Driver/LX/Convert.cpp
        Device/Driver/LX/Declare.cpp
        Device/Driver/LX/Logger.cpp
        Device/Driver/LX/LXN.cpp
        Device/Driver/LX/Mode.cpp
        Device/Driver/LX/NanoDeclare.cpp
        Device/Driver/LX/NanoLogger.cpp
        Device/Driver/LX/Parser.cpp
        Device/Driver/LX/Protocol.cpp
        Device/Driver/LX/Register.cpp
        Device/Driver/LX/Settings.cpp
        Device/Driver/NmeaOut.cpp
        Device/Driver/OpenVario.cpp
        Device/Driver/PosiGraph.cpp
        Device/Driver/ThermalExpress/Driver.cpp
        Device/Driver/Vaulter.cpp
        Device/Driver/Vega/Misc.cpp
        Device/Driver/Vega/Parser.cpp
        Device/Driver/Vega/Register.cpp
        Device/Driver/Vega/Settings.cpp
        Device/Driver/Vega/Volatile.cpp
        Device/Driver/Volkslogger/Database.cpp
        Device/Driver/Volkslogger/dbbconv.cpp
        Device/Driver/Volkslogger/Declare.cpp
        Device/Driver/Volkslogger/grecord.cpp
        Device/Driver/Volkslogger/Logger.cpp
        Device/Driver/Volkslogger/Parser.cpp
        Device/Driver/Volkslogger/Protocol.cpp
        Device/Driver/Volkslogger/Register.cpp
        Device/Driver/Volkslogger/Util.cpp
        Device/Driver/Volkslogger/vlapi2.cpp
        Device/Driver/Volkslogger/vlapihlp.cpp
        Device/Driver/Volkslogger/vlconv.cpp
        Device/Driver/Westerboer.cpp
        Device/Driver/XCOM760.cpp
        Device/Driver/XCTracer/Parser.cpp
        Device/Driver/XCTracer/Register.cpp
        Device/Driver/Zander.cpp
        Device/MultipleDevices.cpp
        Device/Parser.cpp
        Device/Port/BufferedPort.cpp
        Device/Port/ConfiguredPort.cpp
        Device/Port/DumpPort.cpp
        Device/Port/K6BtPort.cpp
        Device/Port/NullPort.cpp
        Device/Port/Port.cpp
        Device/Port/SerialPort.cpp
        Device/Port/TCPClientPort.cpp
        Device/Port/TCPPort.cpp
        Device/Port/UDPPort.cpp
        Device/Register.cpp
        Device/Simulator.cpp
        Device/Util/LineSplitter.cpp
        Device/Util/NMEAReader.cpp
        Device/Util/NMEAWriter.cpp
)

set(Dialogs_SOURCES
        Dialogs/Airspace/AirspaceCRendererSettingsDialog.cpp
        Dialogs/Airspace/AirspaceCRendererSettingsPanel.cpp
        Dialogs/Airspace/AirspaceList.cpp
        Dialogs/Airspace/dlgAirspace.cpp
        Dialogs/Airspace/dlgAirspaceDetails.cpp
        Dialogs/Airspace/dlgAirspacePatterns.cpp
        Dialogs/Airspace/dlgAirspaceWarnings.cpp
        Dialogs/ColorListDialog.cpp
        Dialogs/ComboPicker.cpp
        Dialogs/DataField.cpp
        Dialogs/Device/BlueFly/BlueFlyConfigurationDialog.cpp
        Dialogs/Device/CAI302/UnitsEditor.cpp
        Dialogs/Device/CAI302/WaypointUploader.cpp
        Dialogs/Device/DeviceEditWidget.cpp
        Dialogs/Device/DeviceListDialog.cpp
        Dialogs/Device/FLARM/ConfigWidget.cpp
        Dialogs/Device/LX/ManageLX16xxDialog.cpp
        Dialogs/Device/LX/ManageNanoDialog.cpp
        Dialogs/Device/LX/ManageV7Dialog.cpp
        Dialogs/Device/LX/NanoConfigWidget.cpp
        Dialogs/Device/LX/V7ConfigWidget.cpp
        Dialogs/Device/ManageCAI302Dialog.cpp
        Dialogs/Device/ManageFlarmDialog.cpp
        Dialogs/Device/PortMonitor.cpp
        Dialogs/Device/Vega/SwitchesDialog.cpp
        Dialogs/Device/Vega/VegaConfigurationDialog.cpp
        Dialogs/Device/Vega/VegaDemoDialog.cpp
        Dialogs/Device/Vega/VegaParametersWidget.cpp
        Dialogs/DialogSettings.cpp
        Dialogs/dlgAnalysis.cpp
        Dialogs/dlgChecklist.cpp
        Dialogs/dlgCredits.cpp
        Dialogs/dlgInfoBoxAccess.cpp
        Dialogs/dlgQuickMenu.cpp
        Dialogs/dlgSimulatorPrompt.cpp
        Dialogs/dlgStatus.cpp
        Dialogs/DownloadFilePicker.cpp
        Dialogs/Error.cpp
        Dialogs/FileManager.cpp
        Dialogs/FilePicker.cpp
        Dialogs/GeoPointEntry.cpp
        Dialogs/HelpDialog.cpp
        Dialogs/Inflate.cpp
        Dialogs/JobDialog.cpp
        Dialogs/KnobTextEntry.cpp
        Dialogs/ListPicker.cpp
        Dialogs/LockScreen.cpp
        Dialogs/MapItemListDialog.cpp
        Dialogs/MapItemListSettingsDialog.cpp
        Dialogs/MapItemListSettingsPanel.cpp
        Dialogs/Message.cpp
        Dialogs/NumberEntry.cpp
        Dialogs/Plane/PlaneDetailsDialog.cpp
        Dialogs/Plane/PlaneListDialog.cpp
        Dialogs/Plane/PlanePolarDialog.cpp
        Dialogs/Plane/PolarShapeEditWidget.cpp
        Dialogs/ProfileListDialog.cpp
        Dialogs/ProfilePasswordDialog.cpp
        Dialogs/ProgressDialog.cpp
        Dialogs/ReplayDialog.cpp
        Dialogs/Settings/dlgBasicSettings.cpp
        Dialogs/Settings/dlgConfigInfoboxes.cpp
        Dialogs/Settings/dlgConfiguration.cpp
        Dialogs/Settings/Panels/AirspaceConfigPanel.cpp
        Dialogs/Settings/Panels/CloudConfigPanel.cpp
        Dialogs/Settings/Panels/GaugesConfigPanel.cpp
        Dialogs/Settings/Panels/GlideComputerConfigPanel.cpp
        Dialogs/Settings/Panels/InfoBoxesConfigPanel.cpp
        Dialogs/Settings/Panels/InterfaceConfigPanel.cpp
        Dialogs/Settings/Panels/LayoutConfigPanel.cpp
        Dialogs/Settings/Panels/LoggerConfigPanel.cpp
        Dialogs/Settings/Panels/MapDisplayConfigPanel.cpp
        Dialogs/Settings/Panels/PagesConfigPanel.cpp
        Dialogs/Settings/Panels/RouteConfigPanel.cpp
        Dialogs/Settings/Panels/SafetyFactorsConfigPanel.cpp
        Dialogs/Settings/Panels/ScoringConfigPanel.cpp
        Dialogs/Settings/Panels/SiteConfigPanel.cpp
        Dialogs/Settings/Panels/SymbolsConfigPanel.cpp
        Dialogs/Settings/Panels/TaskDefaultsConfigPanel.cpp
        Dialogs/Settings/Panels/TaskRulesConfigPanel.cpp
        Dialogs/Settings/Panels/TerrainDisplayConfigPanel.cpp
        Dialogs/Settings/Panels/TimeConfigPanel.cpp
        Dialogs/Settings/Panels/TrackingConfigPanel.cpp
        Dialogs/Settings/Panels/UnitsConfigPanel.cpp
        Dialogs/Settings/Panels/VarioConfigPanel.cpp
        Dialogs/Settings/Panels/WaypointDisplayConfigPanel.cpp
        Dialogs/Settings/Panels/WeatherConfigPanel.cpp
        Dialogs/Settings/Panels/WindConfigPanel.cpp
        Dialogs/Settings/WindSettingsDialog.cpp
        Dialogs/Settings/WindSettingsPanel.cpp
        Dialogs/SimulatorPromptWindow.cpp
        Dialogs/StartupDialog.cpp
        Dialogs/StatusPanels/FlightStatusPanel.cpp
        Dialogs/StatusPanels/RulesStatusPanel.cpp
        Dialogs/StatusPanels/StatusPanel.cpp
        Dialogs/StatusPanels/SystemStatusPanel.cpp
        Dialogs/StatusPanels/TaskStatusPanel.cpp
        Dialogs/StatusPanels/TimesStatusPanel.cpp
        Dialogs/Task/AlternatesListDialog.cpp
        Dialogs/Task/dlgTaskHelpers.cpp
        Dialogs/Task/Manager/TaskActionsPanel.cpp
        Dialogs/Task/Manager/TaskClosePanel.cpp
        Dialogs/Task/Manager/TaskEditPanel.cpp
        Dialogs/Task/Manager/TaskListPanel.cpp
        Dialogs/Task/Manager/TaskManagerDialog.cpp
        Dialogs/Task/Manager/TaskMapButtonRenderer.cpp
        Dialogs/Task/Manager/TaskMiscPanel.cpp
        Dialogs/Task/Manager/TaskPropertiesPanel.cpp
        Dialogs/Task/MutateTaskPointDialog.cpp
        Dialogs/Task/OptionalStartsDialog.cpp
        Dialogs/Task/TargetDialog.cpp
        Dialogs/Task/TaskPointDialog.cpp
        Dialogs/Task/Widgets/CylinderZoneEditWidget.cpp
        Dialogs/Task/Widgets/KeyholeZoneEditWidget.cpp
        Dialogs/Task/Widgets/LineSectorZoneEditWidget.cpp
        Dialogs/Task/Widgets/ObservationZoneEditWidget.cpp
        Dialogs/Task/Widgets/SectorZoneEditWidget.cpp
        Dialogs/TextEntry.cpp
        Dialogs/TimeEntry.cpp
        Dialogs/TouchTextEntry.cpp
        Dialogs/Tracking/CloudEnableDialog.cpp
        Dialogs/Traffic/FlarmTrafficDetails.cpp
        Dialogs/Traffic/TeamCodeDialog.cpp
        Dialogs/Traffic/TrafficList.cpp
        Dialogs/Waypoint/dlgWaypointDetails.cpp
        Dialogs/Waypoint/dlgWaypointEdit.cpp
        Dialogs/Waypoint/Manager.cpp
        Dialogs/Waypoint/NearestWaypoint.cpp
        Dialogs/Waypoint/WaypointCommandsWidget.cpp
        Dialogs/Waypoint/WaypointInfoWidget.cpp
        Dialogs/Waypoint/WaypointList.cpp
        Dialogs/Weather/NOAADetails.cpp
        Dialogs/Weather/NOAAList.cpp
        Dialogs/Weather/PCMetDialog.cpp
        Dialogs/Weather/RASPDialog.cpp
        Dialogs/Weather/WeatherDialog.cpp
        Dialogs/WidgetDialog.cpp
)

set(Engine_SOURCES
        Engine/Airspace/AbstractAirspace.cpp
        Engine/Airspace/Airspace.cpp
        Engine/Airspace/AirspaceAircraftPerformance.cpp
        Engine/Airspace/AirspaceAltitude.cpp
        Engine/Airspace/AirspaceCircle.cpp
        Engine/Airspace/AirspaceIntersectionVisitor.cpp
        Engine/Airspace/AirspaceIntersectSort.cpp
        Engine/Airspace/AirspacePolygon.cpp
        Engine/Airspace/Airspaces.cpp
        Engine/Airspace/AirspaceSorter.cpp
        Engine/Airspace/AirspacesTerrain.cpp
        Engine/Airspace/AirspaceWarning.cpp
        Engine/Airspace/AirspaceWarningConfig.cpp
        Engine/Airspace/AirspaceWarningManager.cpp
        Engine/Airspace/Predicate/AirspacePredicate.cpp
        Engine/Airspace/Predicate/AirspacePredicateHeightRange.cpp
        Engine/Airspace/Predicate/OutsideAirspacePredicate.cpp
        Engine/Airspace/SoonestAirspace.cpp
        Engine/Contest/ContestManager.cpp
        Engine/Contest/Settings.cpp
        Engine/Contest/Solvers/AbstractContest.cpp
        Engine/Contest/Solvers/ContestDijkstra.cpp
        Engine/Contest/Solvers/Contests.cpp
        Engine/Contest/Solvers/DMStQuad.cpp
        Engine/Contest/Solvers/NetCoupe.cpp
        Engine/Contest/Solvers/OLCClassic.cpp
        Engine/Contest/Solvers/OLCFAI.cpp
        Engine/Contest/Solvers/OLCLeague.cpp
        Engine/Contest/Solvers/OLCPlus.cpp
        Engine/Contest/Solvers/OLCSISAT.cpp
        Engine/Contest/Solvers/OLCSprint.cpp
        Engine/Contest/Solvers/OLCTriangle.cpp
        Engine/Contest/Solvers/Retrospective.cpp
        Engine/Contest/Solvers/TraceManager.cpp
        Engine/Contest/Solvers/XContestFree.cpp
        Engine/Contest/Solvers/XContestTriangle.cpp
        Engine/GlideSolvers/GlidePolar.cpp
        Engine/GlideSolvers/GlideResult.cpp
        Engine/GlideSolvers/GlideSettings.cpp
        Engine/GlideSolvers/GlideState.cpp
        Engine/GlideSolvers/GlueGlideState.cpp
        Engine/GlideSolvers/InstantSpeed.cpp
        Engine/GlideSolvers/MacCready.cpp
        Engine/GlideSolvers/PolarCoefficients.cpp
        Engine/Navigation/Aircraft.cpp
        Engine/Navigation/TraceHistory.cpp
        Engine/Route/AirspaceRoute.cpp
        Engine/Route/Config.cpp
        Engine/Route/FlatTriangleFan.cpp
        Engine/Route/FlatTriangleFanTree.cpp
        Engine/Route/ReachFan.cpp
        Engine/Route/RouteLink.cpp
        Engine/Route/RoutePlanner.cpp
        Engine/Route/RoutePolar.cpp
        Engine/Route/RoutePolars.cpp
        Engine/Route/TerrainRoute.cpp
        Engine/Task/AbstractTask.cpp
        Engine/Task/Computer/DistanceStatComputer.cpp
        Engine/Task/Computer/ElementStatComputer.cpp
        Engine/Task/Computer/IncrementalSpeedComputer.cpp
        Engine/Task/Computer/TaskStatsComputer.cpp
        Engine/Task/Computer/TaskVarioComputer.cpp
        Engine/Task/Computer/WindowStatsComputer.cpp
        Engine/Task/Factory/AATTaskFactory.cpp
        Engine/Task/Factory/AbstractTaskFactory.cpp
        Engine/Task/Factory/Create.cpp
        Engine/Task/Factory/FAIGoalTaskFactory.cpp
        Engine/Task/Factory/FAIORTaskFactory.cpp
        Engine/Task/Factory/FAITaskFactory.cpp
        Engine/Task/Factory/FAITriangleTaskFactory.cpp
        Engine/Task/Factory/MatTaskFactory.cpp
        Engine/Task/Factory/MixedTaskFactory.cpp
        Engine/Task/Factory/RTTaskFactory.cpp
        Engine/Task/Factory/TouringTaskFactory.cpp
        Engine/Task/ObservationZones/AnnularSectorZone.cpp
        Engine/Task/ObservationZones/Boundary.cpp
        Engine/Task/ObservationZones/CylinderZone.cpp
        Engine/Task/ObservationZones/KeyholeZone.cpp
        Engine/Task/ObservationZones/LineSectorZone.cpp
        Engine/Task/ObservationZones/ObservationZoneClient.cpp
        Engine/Task/ObservationZones/ObservationZonePoint.cpp
        Engine/Task/ObservationZones/SectorZone.cpp
        Engine/Task/ObservationZones/SymmetricSectorZone.cpp
        Engine/Task/Ordered/AATIsoline.cpp
        Engine/Task/Ordered/AATIsolineSegment.cpp
        Engine/Task/Ordered/FinishConstraints.cpp
        Engine/Task/Ordered/OrderedTask.cpp
        Engine/Task/Ordered/Points/AATPoint.cpp
        Engine/Task/Ordered/Points/ASTPoint.cpp
        Engine/Task/Ordered/Points/FinishPoint.cpp
        Engine/Task/Ordered/Points/IntermediatePoint.cpp
        Engine/Task/Ordered/Points/OrderedTaskPoint.cpp
        Engine/Task/Ordered/Points/StartPoint.cpp
        Engine/Task/Ordered/Settings.cpp
        Engine/Task/Ordered/SmartTaskAdvance.cpp
        Engine/Task/Ordered/StartConstraints.cpp
        Engine/Task/Ordered/TaskAdvance.cpp
        Engine/Task/PathSolvers/IsolineCrossingFinder.cpp
        Engine/Task/PathSolvers/TaskDijkstra.cpp
        Engine/Task/PathSolvers/TaskDijkstraMax.cpp
        Engine/Task/PathSolvers/TaskDijkstraMin.cpp
        Engine/Task/Points/SampledTaskPoint.cpp
        Engine/Task/Points/ScoredTaskPoint.cpp
        Engine/Task/Points/TaskLeg.cpp
        Engine/Task/Points/TaskPoint.cpp
        Engine/Task/Shapes/FAITriangleArea.cpp
        Engine/Task/Shapes/FAITrianglePointValidator.cpp
        Engine/Task/Shapes/FAITriangleRules.cpp
        Engine/Task/Shapes/FAITriangleSettings.cpp
        Engine/Task/Shapes/FAITriangleTask.cpp
        Engine/Task/Solvers/TaskBestMc.cpp
        Engine/Task/Solvers/TaskCruiseEfficiency.cpp
        Engine/Task/Solvers/TaskEffectiveMacCready.cpp
        Engine/Task/Solvers/TaskGlideRequired.cpp
        Engine/Task/Solvers/TaskMacCready.cpp
        Engine/Task/Solvers/TaskMacCreadyRemaining.cpp
        Engine/Task/Solvers/TaskMacCreadyTotal.cpp
        Engine/Task/Solvers/TaskMacCreadyTravelled.cpp
        Engine/Task/Solvers/TaskMinTarget.cpp
        Engine/Task/Solvers/TaskOptTarget.cpp
        Engine/Task/Solvers/TaskSolution.cpp
        Engine/Task/Solvers/TaskSolveTravelled.cpp
        Engine/Task/Stats/CommonStats.cpp
        Engine/Task/Stats/ElementStat.cpp
        Engine/Task/Stats/StartStats.cpp
        Engine/Task/Stats/TaskStats.cpp
        Engine/Task/TaskBehaviour.cpp
        Engine/Task/TaskManager.cpp
        Engine/Task/Unordered/AbortTask.cpp
        Engine/Task/Unordered/AlternateTask.cpp
        Engine/Task/Unordered/GotoTask.cpp
        Engine/Task/Unordered/UnorderedTask.cpp
        Engine/Task/Unordered/UnorderedTaskPoint.cpp
        Engine/ThermalBand/ThermalBand.cpp
        Engine/ThermalBand/ThermalEncounterBand.cpp
        Engine/ThermalBand/ThermalEncounterCollection.cpp
        Engine/ThermalBand/ThermalSlice.cpp
        Engine/Trace/Point.cpp
        Engine/Trace/Trace.cpp
        Engine/Trace/Vector.cpp
        Engine/Util/AircraftStateFilter.cpp
        Engine/Util/Gradient.cpp
        Engine/Waypoint/Waypoint.cpp
        Engine/Waypoint/Waypoints.cpp
        Engine/Waypoint/WaypointVisitor.cpp
)

set(Event_SOURCES
        Event/DelayedNotify.cpp
        Event/Globals.cpp
        Event/Idle.cpp
        Event/Notify.cpp
        Event/Shared/Timer.cpp
        Event/Shared/TimerQueue.cpp
        Event/Windows/Loop.cpp
        Event/Windows/Queue.cpp
)

set(FLARM_SOURCES
        FLARM/Error.cpp
        FLARM/FlarmCalculations.cpp
        FLARM/FlarmComputer.cpp
        FLARM/FlarmDetails.cpp
        FLARM/FlarmId.cpp
        FLARM/FlarmNetDatabase.cpp
        FLARM/FlarmNetReader.cpp
        FLARM/FlarmNetRecord.cpp
        FLARM/Friends.cpp
        FLARM/Global.cpp
        FLARM/Glue.cpp
        FLARM/List.cpp
        FLARM/NameDatabase.cpp
        FLARM/NameFile.cpp
        FLARM/Traffic.cpp
        FLARM/TrafficDatabases.cpp
)

set(Form_SOURCES
        Form/Button.cpp
        Form/ButtonPanel.cpp
        Form/CharacterButton.cpp
        Form/CheckBox.cpp
        Form/Control.cpp
        Form/DataField/Angle.cpp
        Form/DataField/Base.cpp
        Form/DataField/Boolean.cpp
        Form/DataField/ComboList.cpp
        Form/DataField/Enum.cpp
        Form/DataField/File.cpp
        Form/DataField/Float.cpp
        Form/DataField/GeoPoint.cpp
        Form/DataField/Integer.cpp
        Form/DataField/Number.cpp
        Form/DataField/Password.cpp
        Form/DataField/Prefix.cpp
        Form/DataField/RoughTime.cpp
        Form/DataField/String.cpp
        Form/DataField/Time.cpp
        Form/DigitEntry.cpp
        Form/Draw.cpp
        Form/Edit.cpp
        Form/Form.cpp
        Form/Frame.cpp
        Form/GridView.cpp
        Form/HLine.cpp
        Form/List.cpp
        Form/Panel.cpp
        Form/ScrollBar.cpp
        Form/TabDisplay.cpp
        Form/TabMenuDisplay.cpp
)

set(Formatter_SOURCES
        Formatter/AirspaceFormatter.cpp
        Formatter/AirspaceUserUnitsFormatter.cpp
        Formatter/AngleFormatter.cpp
        Formatter/ByteSizeFormatter.cpp
        Formatter/GeoPointFormatter.cpp
        Formatter/GlideRatioFormatter.cpp
        Formatter/HexColor.cpp
        Formatter/IGCFilenameFormatter.cpp
        Formatter/LocalTimeFormatter.cpp
        Formatter/TimeFormatter.cpp
        Formatter/Units.cpp
        Formatter/UserGeoPointFormatter.cpp
        Formatter/UserUnits.cpp
)

set(Gauge_SOURCES
        Gauge/BigThermalAssistantWidget.cpp
        Gauge/BigThermalAssistantWindow.cpp
        Gauge/BigTrafficWidget.cpp
        Gauge/FlarmTrafficWindow.cpp
        Gauge/GaugeFLARM.cpp
        Gauge/GaugeThermalAssistant.cpp
        Gauge/GaugeVario.cpp
        Gauge/GlueGaugeVario.cpp
        Gauge/LogoView.cpp
        Gauge/TaskView.cpp
        Gauge/ThermalAssistantRenderer.cpp
        Gauge/ThermalAssistantWindow.cpp
        Gauge/TrafficSettings.cpp
        Gauge/VarioSettings.cpp
)

set(Geo_SOURCES
        Geo/Boost/RangeBox.cpp
        Geo/ConvexHull/GrahamScan.cpp
        Geo/ConvexHull/PolygonInterior.cpp
        Geo/Flat/FlatBoundingBox.cpp
        Geo/Flat/FlatEllipse.cpp
        Geo/Flat/FlatGeoPoint.cpp
        Geo/Flat/FlatLine.cpp
        Geo/Flat/FlatPoint.cpp
        Geo/Flat/FlatProjection.cpp
        Geo/Flat/FlatRay.cpp
        Geo/Flat/TaskProjection.cpp
        Geo/GeoBounds.cpp
        Geo/GeoClip.cpp
        Geo/GeoEllipse.cpp
        Geo/Geoid.cpp
        Geo/GeoPoint.cpp
        Geo/GeoVector.cpp
        Geo/Math.cpp # aug: von mir umgenannt
        Geo/Memento/DistanceMemento.cpp
        Geo/Memento/GeoVectorMemento.cpp
        Geo/Quadrilateral.cpp
        Geo/SearchPoint.cpp
        Geo/SearchPointVector.cpp
        Geo/SimplifiedMath.cpp
        Geo/UTM.cpp
)

set(Hardware_SOURCES
        Hardware/Battery.cpp
        Hardware/CPU.cpp
        Hardware/DisplayDPI.cpp
        Hardware/DisplayGlue.cpp
        Hardware/DisplaySize.cpp
        Hardware/RotateDisplay.cpp
        Hardware/Vibrator.cpp
)

set(IGC_SOURCES
        IGC/Generator.cpp
        IGC/IGCFix.cpp
        IGC/IGCParser.cpp
        IGC/IGCString.cpp
        IGC/IGCWriter.cpp
)

set(InfoBoxes_SOURCES
        InfoBoxes/Content/Airspace.cpp
        InfoBoxes/Content/Alternate.cpp
        InfoBoxes/Content/Altitude.cpp
        InfoBoxes/Content/Base.cpp
        InfoBoxes/Content/Contest.cpp
        InfoBoxes/Content/Direction.cpp
        InfoBoxes/Content/Factory.cpp
        InfoBoxes/Content/Glide.cpp
        InfoBoxes/Content/MacCready.cpp
        InfoBoxes/Content/Other.cpp
        InfoBoxes/Content/Places.cpp
        InfoBoxes/Content/Radio.cpp
        InfoBoxes/Content/Speed.cpp
        InfoBoxes/Content/Task.cpp
        InfoBoxes/Content/Team.cpp
        InfoBoxes/Content/Terrain.cpp
        InfoBoxes/Content/Thermal.cpp
        InfoBoxes/Content/Time.cpp
        InfoBoxes/Content/Trace.cpp
        InfoBoxes/Content/Weather.cpp
        InfoBoxes/Data.cpp
        InfoBoxes/Format.cpp
        InfoBoxes/InfoBoxLayout.cpp
        InfoBoxes/InfoBoxManager.cpp
        InfoBoxes/InfoBoxSettings.cpp
        InfoBoxes/InfoBoxWindow.cpp
        InfoBoxes/Panel/AltitudeInfo.cpp
        InfoBoxes/Panel/AltitudeSetup.cpp
        InfoBoxes/Panel/AltitudeSimulator.cpp
        InfoBoxes/Panel/ATCReference.cpp
        InfoBoxes/Panel/MacCreadyEdit.cpp
        InfoBoxes/Panel/MacCreadySetup.cpp
        InfoBoxes/Panel/RadioEdit.cpp
        InfoBoxes/Panel/WindEdit.cpp
        InfoBoxes/Units.cpp
)

set(Input_SOURCES
        Input/InputConfig.cpp
        Input/InputDefaults.cpp
        Input/InputEvents.cpp
        Input/InputEventsActions.cpp
        Input/InputEventsAirspace.cpp
        Input/InputEventsDevice.cpp
        Input/InputEventsLua.cpp
        Input/InputEventsMap.cpp
        Input/InputEventsPage.cpp
        Input/InputEventsSettings.cpp
        Input/InputEventsTask.cpp
        Input/InputEventsThermalAssistant.cpp
        Input/InputEventsTraffic.cpp
        Input/InputEventsVega.cpp
        Input/InputKeys.cpp
        Input/InputLookup.cpp
        Input/InputParser.cpp
        Input/InputQueue.cpp
        Input/TaskEventObserver.cpp
)

set(IO_SOURCES
        IO/Async/AsioThread.cpp
        IO/Async/GlobalAsioThread.cpp
        IO/BufferedOutputStream.cxx
        IO/BufferedReader.cxx
        IO/ConfiguredFile.cpp
        IO/ConvertLineReader.cpp
        IO/CSVLine.cpp
        IO/DataFile.cpp
        IO/FileCache.cpp
        IO/FileLineReader.cpp
        IO/FileOutputStream.cxx
        IO/FileReader.cxx
        IO/FileTransaction.cpp
        IO/GunzipReader.cxx
        IO/KeyValueFileReader.cpp
        IO/KeyValueFileWriter.cpp
        IO/MapFile.cpp
        IO/TextWriter.cpp
        IO/ZipArchive.cpp
        IO/ZipLineReader.cpp
        IO/ZipReader.cpp
        IO/ZlibError.cxx
)

set(Job_SOURCES
        Job/Async.cpp
        Job/Thread.cpp
)

set(Language_SOURCES
        Language/Language.cpp
        Language/LanguageGlue.cpp
        Language/MOFile.cpp
)

set(Logger_SOURCES
        Logger/ExternalLogger.cpp
        Logger/FlightLogger.cpp
        Logger/GlueFlightLogger.cpp
        Logger/GRecord.cpp
        Logger/IGCFileCleanup.cpp
        Logger/Logger.cpp
        Logger/LoggerEPE.cpp
        Logger/LoggerFRecord.cpp
        Logger/LoggerImpl.cpp
        Logger/MD5.cpp
        Logger/NMEALogger.cpp
        Logger/Settings.cpp
)

set(Look_SOURCES
        Look/AircraftLook.cpp
        Look/AirspaceLook.cpp
        Look/AutoFont.cpp
        Look/ButtonLook.cpp
        Look/ChartLook.cpp
        Look/CheckBoxLook.cpp
        Look/ClimbPercentLook.cpp
        Look/CrossSectionLook.cpp
        Look/DefaultFonts.cpp
        Look/DialogLook.cpp
        Look/FinalGlideBarLook.cpp
        Look/FlarmTrafficLook.cpp
        Look/FontDescription.cpp
        Look/GestureLook.cpp
        Look/GlobalFonts.cpp
        Look/HorizonLook.cpp
        Look/IconLook.cpp
        Look/InfoBoxLook.cpp
        Look/Look.cpp
        Look/MapLook.cpp
        Look/NOAALook.cpp
        Look/OverlayLook.cpp
        Look/TaskLook.cpp
        Look/TerminalLook.cpp
        Look/ThermalAssistantLook.cpp
        Look/ThermalBandLook.cpp
        Look/TopographyLook.cpp
        Look/TraceHistoryLook.cpp
        Look/TrafficLook.cpp
        Look/TrailLook.cpp
        Look/VarioBarLook.cpp
        Look/VarioLook.cpp
        Look/WaveLook.cpp
        Look/WaypointLook.cpp
        Look/WindArrowLook.cpp
)

set(Lua_SOURCES
        Lua/Airspace.cpp
        Lua/Associate.cpp
        Lua/Background.cpp
        Lua/Basic.cpp
        Lua/Blackboard.cpp
        Lua/Catch.cpp
        Lua/Dialogs.cpp
        Lua/Error.cxx
        Lua/Full.cpp
        Lua/Geo.cpp
        Lua/InputEvent.cpp
        Lua/Legacy.cpp
        Lua/Log.cpp
        Lua/Logger.cpp
        Lua/Map.cpp
        Lua/Persistent.cpp
        Lua/Ptr.cpp
        Lua/Replay.cpp
        Lua/RunFile.cxx
        Lua/Settings.cpp
        Lua/StartFile.cpp
        Lua/Task.cpp
        Lua/Timer.cpp
        Lua/Tracking.cpp
        Lua/Wind.cpp
)

set(MapWindow_SOURCES
        MapWindow/GlueMapWindow.cpp
        MapWindow/GlueMapWindowDisplayMode.cpp
        MapWindow/GlueMapWindowEvents.cpp
        MapWindow/GlueMapWindowItems.cpp
        MapWindow/GlueMapWindowOverlays.cpp
        MapWindow/Items/AirspaceBuilder.cpp
        MapWindow/Items/Builder.cpp
        MapWindow/Items/List.cpp
        MapWindow/Items/MapItem.cpp
        MapWindow/Items/OverlayMapItem.cpp
        MapWindow/Items/TrafficBuilder.cpp
        MapWindow/Items/WeatherBuilder.cpp
        MapWindow/MapCanvas.cpp
        MapWindow/MapWindow.cpp
        MapWindow/MapWindowBlackboard.cpp
        MapWindow/MapWindowContest.cpp
        MapWindow/MapWindowEvents.cpp
        MapWindow/MapWindowGlideRange.cpp
        MapWindow/MapWindowRender.cpp
        MapWindow/MapWindowSymbols.cpp
        MapWindow/MapWindowTask.cpp
        MapWindow/MapWindowThermal.cpp
        MapWindow/MapWindowTraffic.cpp
        MapWindow/MapWindowTrail.cpp
        MapWindow/MapWindowWaypoints.cpp
        MapWindow/StencilMapCanvas.cpp
        MapWindow/TargetMapWindow.cpp
        MapWindow/TargetMapWindowDrag.cpp
        MapWindow/TargetMapWindowEvents.cpp
)

set(Markers_SOURCES
        Markers/Markers.cpp
)

set(Math_SOURCES
        Math/Angle.cpp
        Math/ARange.cpp
        Math/ConvexFilter.cpp
        Math/DiffFilter.cpp
        Math/FastMath.cpp
        Math/FastRotation.cpp
        Math/FastTrig.cpp
        Math/Filter.cpp
        Math/Histogram.cpp
        Math/KalmanFilter1d.cpp
        Math/LeastSquares.cpp
        Math/Screen.cpp
        Math/SelfTimingKalmanFilter1d.cpp
        Math/SunEphemeris.cpp
        Math/XYDataStore.cpp
        Math/ZeroFinder.cpp
)

set(Menu_SOURCES
        Menu/ButtonLabel.cpp
        Menu/ExpandMacros.cpp
        Menu/MenuBar.cpp
        Menu/MenuData.cpp
        Menu/ShowMenuButton.cpp
)

set(Monitor_SOURCES
        Monitor/AirspaceWarningMonitor.cpp
        Monitor/AllMonitors.cpp
        Monitor/MatTaskMonitor.cpp
        Monitor/TaskAdvanceMonitor.cpp
        Monitor/TaskConstraintsMonitor.cpp
        Monitor/WindMonitor.cpp
)

set(Net_SOURCES
        Net/AllocatedSocketAddress.cxx
        Net/HTTP/DownloadManager.cpp
        Net/HTTP/FormData.cpp
        Net/HTTP/Init.cpp
        Net/HTTP/Multi.cpp
        Net/HTTP/Request.cpp
        Net/HTTP/Session.cpp
        Net/HTTP/ToBuffer.cpp
        Net/HTTP/ToFile.cpp
        Net/IPv4Address.cxx
        Net/IPv6Address.cxx
        Net/SocketAddress.cxx
        Net/SocketDescriptor.cxx
        Net/State.cpp
        Net/StaticSocketAddress.cxx
)

set(NMEA_SOURCES
        NMEA/Acceleration.cpp
        NMEA/Aircraft.cpp
        NMEA/Attitude.cpp
        NMEA/Checksum.cpp
        NMEA/CirclingInfo.cpp
        NMEA/ClimbHistory.cpp
        NMEA/ClimbInfo.cpp
        NMEA/Derived.cpp
        NMEA/ExternalSettings.cpp
        NMEA/FlyingState.cpp
        NMEA/GPSState.cpp
        NMEA/Info.cpp
        NMEA/InputLine.cpp
        NMEA/MoreData.cpp
        NMEA/SwitchState.cpp
        NMEA/ThermalLocator.cpp
        NMEA/VarioInfo.cpp
)

set(Operation_SOURCES
        Operation/MessageOperationEnvironment.cpp
        Operation/NoCancelOperationEnvironment.cpp
        Operation/Operation.cpp
        Operation/PopupOperationEnvironment.cpp
        Operation/ProxyOperationEnvironment.cpp
        Operation/ThreadedOperationEnvironment.cpp
        Operation/VerboseOperationEnvironment.cpp
)

set(OS_SOURCES
        OS/Clock.cpp
        OS/FileDescriptor.cxx
        OS/FileMapping.cpp
        OS/FileUtil.cpp
        OS/LogError.cpp
        OS/Path.cpp
        OS/PathName.cpp
        OS/Process.cpp
        OS/RunFile.cpp
        OS/SystemLoad.cpp
)

set(Plane_SOURCES
        Plane/PlaneFileGlue.cpp
        Plane/PlaneGlue.cpp
)

set(Polar_SOURCES
        Polar/Parser.cpp
        Polar/Polar.cpp
        Polar/PolarFileGlue.cpp
        Polar/PolarGlue.cpp
        Polar/PolarStore.cpp
        Polar/Shape.cpp
)

set(Profile_SOURCES
        Profile/AirspaceConfig.cpp
        Profile/ComputerProfile.cpp
        Profile/ContestProfile.cpp
        Profile/Current.cpp
        Profile/DeviceConfig.cpp
        Profile/File.cpp
        Profile/FlarmProfile.cpp
        Profile/GeoValue.cpp
        Profile/InfoBoxConfig.cpp
        Profile/Map.cpp
        Profile/MapProfile.cpp
        Profile/NumericValue.cpp
        Profile/PageProfile.cpp
        Profile/PathValue.cpp
        Profile/Profile.cpp
        Profile/ProfileKeys.cpp
        Profile/ProfileMap.cpp
        Profile/RouteProfile.cpp
        Profile/Screen.cpp
        Profile/Settings.cpp
        Profile/StringValue.cpp
        Profile/SystemProfile.cpp
        Profile/TaskProfile.cpp
        Profile/TerrainConfig.cpp
        Profile/TrackingProfile.cpp
        Profile/UIProfile.cpp
        Profile/UnitsConfig.cpp
        Profile/WeatherProfile.cpp
)

set(Projection_SOURCES
        Projection/ChartProjection.cpp
        Projection/CompareProjection.cpp
        Projection/MapWindowProjection.cpp
        Projection/Projection.cpp
        Projection/WindowProjection.cpp
)

set(Renderer_SOURCES
        Renderer/AircraftRenderer.cpp
        Renderer/AirspaceLabelList.cpp
        Renderer/AirspaceLabelRenderer.cpp
        Renderer/AirspaceListRenderer.cpp
        Renderer/AirspacePreviewRenderer.cpp
        Renderer/AirspaceRenderer.cpp
        Renderer/AirspaceRendererGL.cpp
        Renderer/AirspaceRendererOther.cpp
        Renderer/AirspaceRendererSettings.cpp
        Renderer/BackgroundRenderer.cpp
        Renderer/BarographRenderer.cpp
        Renderer/BestCruiseArrowRenderer.cpp
        Renderer/BitmapButtonRenderer.cpp
        Renderer/ButtonRenderer.cpp
        Renderer/ChartRenderer.cpp
        Renderer/ClimbChartRenderer.cpp
        Renderer/ClimbPercentRenderer.cpp
        Renderer/ColorButtonRenderer.cpp
        Renderer/CompassRenderer.cpp
        Renderer/CuRenderer.cpp
        Renderer/FAITriangleAreaRenderer.cpp
        Renderer/FinalGlideBarRenderer.cpp
        Renderer/FlightStatisticsRenderer.cpp
        Renderer/GeoBitmapRenderer.cpp
        Renderer/GlassRenderer.cpp
        Renderer/GlidePolarInfoRenderer.cpp
        Renderer/GlidePolarRenderer.cpp
        Renderer/GradientRenderer.cpp
        Renderer/HorizonRenderer.cpp
        Renderer/LabelBlock.cpp
        Renderer/MacCreadyRenderer.cpp
        Renderer/MapItemListRenderer.cpp
        Renderer/MapScaleRenderer.cpp
        Renderer/NextArrowRenderer.cpp
        Renderer/NOAAListRenderer.cpp
        Renderer/OZPreviewRenderer.cpp
        Renderer/OZRenderer.cpp
        Renderer/SymbolButtonRenderer.cpp
        Renderer/SymbolRenderer.cpp
        Renderer/TabRenderer.cpp
        Renderer/TaskLegRenderer.cpp
        Renderer/TaskPointRenderer.cpp
        Renderer/TaskProgressRenderer.cpp
        Renderer/TaskRenderer.cpp
        Renderer/TaskSpeedRenderer.cpp
        Renderer/TextButtonRenderer.cpp
        Renderer/TextInBox.cpp
        Renderer/TextRenderer.cpp
        Renderer/TextRowRenderer.cpp
        Renderer/ThermalBandRenderer.cpp
        Renderer/TraceHistoryRenderer.cpp
        Renderer/TrackLineRenderer.cpp
        Renderer/TrafficRenderer.cpp
        Renderer/TrailRenderer.cpp
        Renderer/TransparentRendererCache.cpp
        Renderer/TwoTextRowsRenderer.cpp
        Renderer/UnitSymbolRenderer.cpp
        Renderer/VarioBarRenderer.cpp
        Renderer/VarioHistogramRenderer.cpp
        Renderer/WaveRenderer.cpp
        Renderer/WaypointIconRenderer.cpp
        Renderer/WaypointLabelList.cpp
        Renderer/WaypointListRenderer.cpp
        Renderer/WaypointRenderer.cpp
        Renderer/WaypointRendererSettings.cpp
        Renderer/WindArrowRenderer.cpp
        Renderer/WindChartRenderer.cpp
)

set(Replay_SOURCES
        Replay/AircraftSim.cpp
        Replay/DemoReplay.cpp
        Replay/DemoReplayGlue.cpp
        Replay/IgcReplay.cpp
        Replay/NmeaReplay.cpp
        Replay/Replay.cpp
        Replay/TaskAutoPilot.cpp
)

set(Repository_SOURCES
        Repository/FileRepository.cpp
        Repository/Glue.cpp
        Repository/Parser.cpp
)

set(Screen_SOURCES
        Screen/BufferCanvas.cpp
        Screen/BufferWindow.cpp
        Screen/Canvas.cpp
        Screen/Color.cpp
        Screen/Debug.cpp
        Screen/DoubleBufferWindow.cpp
        Screen/Icon.cpp
        Screen/Layout.cpp
        Screen/ProgressBar.cpp
        Screen/Ramp.cpp
        Screen/SingleWindow.cpp
        Screen/SolidContainerWindow.cpp
        Screen/TerminalWindow.cpp
        Screen/Util.cpp
        Screen/Window.cpp
)
if (NOT ENABLE_OPENGL)  # USE_GDI
 list(APPEND Screen_SOURCES
        Screen/GDI/Bitmap.cpp
        Screen/GDI/Brush.cpp
        Screen/GDI/BufferCanvas.cpp
        Screen/GDI/Canvas.cpp
        Screen/GDI/ContainerWindow.cpp
        Screen/GDI/Font.cpp
        Screen/GDI/Init.cpp
        Screen/GDI/LargeTextWindow.cpp
        Screen/GDI/PaintCanvas.cpp
        Screen/GDI/PaintWindow.cpp
        Screen/GDI/Pen.cpp
        Screen/GDI/RawBitmap.cpp
        Screen/GDI/ResourceBitmap.cpp
        Screen/GDI/SingleWindow.cpp
        Screen/GDI/Timer.cpp
        Screen/GDI/TopWindow.cpp
        Screen/GDI/VirtualCanvas.cpp
        Screen/GDI/Window.cpp
        Screen/GDI/WindowCanvas.cpp
  )
elseif(ENABLE_OPENGL)
  list(APPEND Screen_SOURCES
        Screen/OpenGL/Bitmap.cpp
        Screen/OpenGL/Buffer.cpp
        Screen/OpenGL/BufferCanvas.cpp
        Screen/OpenGL/Canvas.cpp
        Screen/OpenGL/ConstantAlpha.cpp
        Screen/OpenGL/Dynamic.cpp
        Screen/OpenGL/Extension.cpp
        Screen/OpenGL/FBO.cpp
        Screen/OpenGL/Geo.cpp
        Screen/OpenGL/Globals.cpp
        Screen/OpenGL/Init.cpp
        Screen/OpenGL/RawBitmap.cpp
        Screen/OpenGL/Rotate.cpp
        Screen/OpenGL/Shaders.cpp
        Screen/OpenGL/Shapes.cpp
        Screen/OpenGL/SubCanvas.cpp
        Screen/OpenGL/Surface.cpp
        Screen/OpenGL/Texture.cpp
        Screen/OpenGL/TopCanvas.cpp
        Screen/OpenGL/Triangulate.cpp
        Screen/OpenGL/UncompressedImage.cpp
        Screen/OpenGL/VertexArray.cpp
  )

endif()

set(Task_SOURCES
        Task/DefaultTask.cpp
        Task/Deserialiser.cpp
        Task/FileProtectedTaskManager.cpp
        Task/LoadFile.cpp
        Task/MapTaskManager.cpp
        Task/ProtectedRoutePlanner.cpp
        Task/ProtectedTaskManager.cpp
        Task/RoutePlannerGlue.cpp
        Task/SaveFile.cpp
        Task/Serialiser.cpp
        Task/TaskFile.cpp
        Task/TaskFileIGC.cpp
        Task/TaskFileSeeYou.cpp
        Task/TaskFileXCSoar.cpp
        Task/TaskStore.cpp
        Task/TypeStrings.cpp
        Task/ValidationErrorStrings.cpp
)

set(TeamCode_SOURCES
        TeamCode/Settings.cpp
        TeamCode/TeamCode.cpp
)

set(Terrain_SOURCES
        Terrain/HeightMatrix.cpp
        Terrain/Intersection.cpp
        Terrain/Loader.cpp
        Terrain/RasterBuffer.cpp
        Terrain/RasterMap.cpp
        Terrain/RasterProjection.cpp
        Terrain/RasterRenderer.cpp
        Terrain/RasterTerrain.cpp
        Terrain/RasterTile.cpp
        Terrain/RasterTileCache.cpp
        Terrain/ScanLine.cpp
        Terrain/TerrainRenderer.cpp
        Terrain/TerrainSettings.cpp
        Terrain/Thread.cpp
        Terrain/WorldFile.cpp
        Terrain/ZzipStream.cpp
)

set(jasper_SOURCES
        jasper/base/jas_malloc.c
        jasper/base/jas_seq.c
        jasper/base/jas_stream.c
        jasper/base/jas_string.c
        jasper/base/jas_tvp.c
        jasper/jp2/jp2_cod.c
        jasper/jpc/jpc_bs.c
        jasper/jpc/jpc_cs.c
        jasper/jpc/jpc_dec.c
        jasper/jpc/jpc_math.c
        jasper/jpc/jpc_mqcod.c
        jasper/jpc/jpc_mqdec.c
        jasper/jpc/jpc_qmfb.c
        jasper/jpc/jpc_rtc.cpp
        jasper/jpc/jpc_t1cod.c
        jasper/jpc/jpc_t1dec.c
        jasper/jpc/jpc_t2cod.c
        jasper/jpc/jpc_t2dec.c
        jasper/jpc/jpc_tagtree.c
        jasper/jpc/jpc_tsfb.c
)
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
set(Thread_SOURCES
        Thread/Debug.cpp
        Thread/RecursivelySuspensibleThread.cpp
        Thread/StandbyThread.cpp
        Thread/SuspensibleThread.cpp
        Thread/Thread.cpp
        Thread/WorkerThread.cpp
)

set(Time_SOURCES
        Time/BrokenDate.cpp
        Time/BrokenDateTime.cpp
        Time/BrokenTime.cpp
        Time/DeltaTime.cpp
        Time/LocalTime.cpp
        Time/WrapClock.cpp
)

set(Topography_SOURCES
        Topography/CachedTopographyRenderer.cpp
#         Topography/shapelib/mapalloc.c
#         Topography/shapelib/mapbits.c
#         Topography/shapelib/mapprimitive.c
#         Topography/shapelib/mapsearch.c
#         Topography/shapelib/mapshape.c
#         Topography/shapelib/mapstring.c
#         Topography/shapelib/maptree.c
#         Topography/shapelib/mapxbase.c
        Topography/Thread.cpp
        Topography/TopographyFile.cpp
        Topography/TopographyFileRenderer.cpp
        Topography/TopographyGlue.cpp
        Topography/TopographyRenderer.cpp
        Topography/TopographyStore.cpp
        Topography/XShape.cpp
)

set (MapServer_SOURCES
   not used up to now!
        Topography/shapelib/mapalloc.c
        Topography/shapelib/mapbits.c
        Topography/shapelib/mapprimitive.c
        Topography/shapelib/mapsearch.c
        Topography/shapelib/mapshape.c
        Topography/shapelib/mapstring.c
        Topography/shapelib/maptree.c
        Topography/shapelib/mapxbase.c
)

set(Tracking_SOURCES
        Tracking/LiveTrack24.cpp
        Tracking/SkyLines/Assemble.cpp
        Tracking/SkyLines/Client.cpp
        Tracking/SkyLines/Glue.cpp
        Tracking/SkyLines/Key.cpp
        Tracking/TrackingGlue.cpp
)

set(UIUtil_SOURCES
        UIUtil/GestureManager.cpp
        UIUtil/KineticManager.cpp
        UIUtil/TrackingGestureManager.cpp
)

set(Units_SOURCES
        Units/Descriptor.cpp
        Units/Settings.cpp
        Units/System.cpp
        Units/Temperature.cpp
        Units/Units.cpp
        Units/UnitsGlue.cpp
        Units/UnitsStore.cpp
)

set(Util_SOURCES
        Util/AllocatedString.cxx
        Util/ASCII.cxx
        Util/Base64.cxx
        Util/ConvertString.cpp
        Util/CRC.cpp
        Util/EscapeBackslash.cpp
        Util/Exception.cxx
        Util/ExtractParameters.cpp
        Util/PrintException.cxx
        Util/StaticString.cxx
        Util/StringCompare.cxx
        Util/StringStrip.cxx
        Util/StringUtil.cpp
        Util/StringView.cxx
        Util/TruncateString.cpp
        Util/tstring.cpp
        Util/UTF8.cpp
        Util/WASCII.cxx
        Util/WStringCompare.cxx
        Util/WStringStrip.cxx
        Util/WStringUtil.cpp
)

set(Waypoint_SOURCES
        Waypoint/CupWriter.cpp
        Waypoint/Factory.cpp
        Waypoint/HomeGlue.cpp
        Waypoint/LastUsed.cpp
        Waypoint/SaveGlue.cpp
        Waypoint/WaypointDetailsReader.cpp
        Waypoint/WaypointFileType.cpp
        Waypoint/WaypointFilter.cpp
        Waypoint/WaypointGlue.cpp
        Waypoint/WaypointList.cpp
        Waypoint/WaypointListBuilder.cpp
        Waypoint/WaypointReader.cpp
        Waypoint/WaypointReaderBase.cpp
        Waypoint/WaypointReaderCompeGPS.cpp
        Waypoint/WaypointReaderFS.cpp
        Waypoint/WaypointReaderOzi.cpp
        Waypoint/WaypointReaderSeeYou.cpp
        Waypoint/WaypointReaderWinPilot.cpp
        Waypoint/WaypointReaderZander.cpp
)

set(Weather_SOURCES
        Weather/METARParser.cpp
        Weather/NOAADownloader.cpp
        Weather/NOAAFormatter.cpp
        Weather/NOAAGlue.cpp
        Weather/NOAAStore.cpp
        Weather/NOAAUpdater.cpp
        Weather/PCMet/Images.cpp
        Weather/PCMet/Overlays.cpp
        Weather/Rasp/Providers.cpp
        Weather/Rasp/RaspCache.cpp
        Weather/Rasp/RaspRenderer.cpp
        Weather/Rasp/RaspStore.cpp
        Weather/Rasp/RaspStyle.cpp
)

set(Widget_SOURCES
        Widget/ActionWidget.cpp
        Widget/ArrowPagerWidget.cpp
        Widget/ButtonPanelWidget.cpp
        Widget/ButtonWidget.cpp
        Widget/CallbackWidget.cpp
        Widget/ContainerWidget.cpp
        Widget/CreateWindowWidget.cpp
        Widget/DockWindow.cpp
        Widget/EditRowFormWidget.cpp
        Widget/KeyboardWidget.cpp
        Widget/LargeTextWidget.cpp
        Widget/ListWidget.cpp
        Widget/ManagedWidget.cpp
        Widget/OffsetButtonsWidget.cpp
        Widget/OverlappedWidget.cpp
        Widget/PagerWidget.cpp
        Widget/PanelWidget.cpp
        Widget/ProfileRowFormWidget.cpp
        Widget/QuestionWidget.cpp
        Widget/RowFormWidget.cpp
        Widget/SolidWidget.cpp
        Widget/TabWidget.cpp
        Widget/TextListWidget.cpp
        Widget/TextWidget.cpp
        Widget/TwoWidgets.cpp
        Widget/UnitRowFormWidget.cpp
        Widget/ViewImageWidget.cpp
        Widget/Widget.cpp
        Widget/WindowWidget.cpp
)

set(XML_SOURCES
        XML/DataNode.cpp
        XML/DataNodeXML.cpp
        XML/Node.cpp
        XML/Parser.cpp
        XML/Writer.cpp
)

set(zzip_SOURCES
        zzip/fetch.c
        zzip/file.c
        zzip/plugin.c
        zzip/stat.c
        zzip/zip.c
)






















































