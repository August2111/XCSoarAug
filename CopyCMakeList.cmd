@echo off
cd /D %~dp0

REM xcopy src\Airspace\CmakeLists.txt src\Engine  /Y
REM src/Airspace
xcopy src\Airspace\CmakeLists.txt src\Atmosphere           /Y
xcopy src\Airspace\CmakeLists.txt src\Audio                /Y
xcopy src\Airspace\CmakeLists.txt src\Blackboard           /Y
xcopy src\Airspace\CmakeLists.txt src\Computer             /Y
xcopy src\Airspace\CmakeLists.txt src\CrossSection         /Y
xcopy src\Airspace\CmakeLists.txt src\Device               /Y
xcopy src\Airspace\CmakeLists.txt src\Dialogs              /Y
xcopy src\Airspace\CmakeLists.txt src\Engine               /Y
xcopy src\Airspace\CmakeLists.txt src\Event                /Y
xcopy src\Airspace\CmakeLists.txt src\FLARM                /Y
xcopy src\Airspace\CmakeLists.txt src\Form                 /Y
xcopy src\Airspace\CmakeLists.txt src\Formatter            /Y
xcopy src\Airspace\CmakeLists.txt src\Gauge                /Y
xcopy src\Airspace\CmakeLists.txt src\Geo                  /Y
xcopy src\Airspace\CmakeLists.txt src\Hardware             /Y
xcopy src\Airspace\CmakeLists.txt src\IGC                  /Y
xcopy src\Airspace\CmakeLists.txt src\InfoBoxes            /Y
xcopy src\Airspace\CmakeLists.txt src\Input                /Y
xcopy src\Airspace\CmakeLists.txt src\IO                   /Y
xcopy src\Airspace\CmakeLists.txt src\Job                  /Y
xcopy src\Airspace\CmakeLists.txt src\Language             /Y
xcopy src\Airspace\CmakeLists.txt src\Logger               /Y
xcopy src\Airspace\CmakeLists.txt src\Look                 /Y
xcopy src\Airspace\CmakeLists.txt src\Lua                  /Y
xcopy src\Airspace\CmakeLists.txt src\MapWindow            /Y
xcopy src\Airspace\CmakeLists.txt src\Markers              /Y
xcopy src\Airspace\CmakeLists.txt src\Math                 /Y
xcopy src\Airspace\CmakeLists.txt src\Menu                 /Y
xcopy src\Airspace\CmakeLists.txt src\Monitor              /Y
xcopy src\Airspace\CmakeLists.txt src\Net                  /Y
xcopy src\Airspace\CmakeLists.txt src\NMEA                 /Y
xcopy src\Airspace\CmakeLists.txt src\Operation            /Y
xcopy src\Airspace\CmakeLists.txt src\OS                   /Y
xcopy src\Airspace\CmakeLists.txt src\Plane                /Y
xcopy src\Airspace\CmakeLists.txt src\Polar                /Y
xcopy src\Airspace\CmakeLists.txt src\Profile              /Y
xcopy src\Airspace\CmakeLists.txt src\Projection           /Y
xcopy src\Airspace\CmakeLists.txt src\Renderer             /Y
xcopy src\Airspace\CmakeLists.txt src\Replay               /Y
xcopy src\Airspace\CmakeLists.txt src\Repository           /Y
xcopy src\Airspace\CmakeLists.txt src\Screen               /Y
xcopy src\Airspace\CmakeLists.txt src\Task                 /Y
xcopy src\Airspace\CmakeLists.txt src\TeamCode             /Y
xcopy src\Airspace\CmakeLists.txt src\Terrain              /Y
xcopy src\Airspace\CmakeLists.txt src\Thread               /Y
xcopy src\Airspace\CmakeLists.txt src\Time                 /Y
xcopy src\Airspace\CmakeLists.txt src\Topography           /Y
xcopy src\Airspace\CmakeLists.txt src\Tracking             /Y
xcopy src\Airspace\CmakeLists.txt src\UIUtil               /Y
xcopy src\Airspace\CmakeLists.txt src\Units                /Y
xcopy src\Airspace\CmakeLists.txt src\Util                 /Y
xcopy src\Airspace\CmakeLists.txt src\Waypoint             /Y
xcopy src\Airspace\CmakeLists.txt src\Weather              /Y
xcopy src\Airspace\CmakeLists.txt src\Widget               /Y
xcopy src\Airspace\CmakeLists.txt src\XML                  /Y

REM zzip ist extra!!!!!!!!!!!!!!!!!!!
REM xcopy src\Airspace\CmakeLists.txt src\zzip                 /Y

pause