## Aufgaben
* Bereinigen der char-Array-Deklarationen, ab jetzt mit   std::vector<char> buffer(buflen);... und Zugriff  statt buffer mit &buffer[0]
* Drei externe Projekte sind noch zu sehr mit XCSoar verwoben, so dass sie nicht eigenständig compiliert werden können (xml, mapserver und ?zzip?)
* msvc lässt den Resourcen-Import der PNG-Dateien nicht zu!!!!
* ANDROID!!!!!
* KOBO!
* Linux
* Übersetzung der externen 3rd Party-Pojekte nur bei richtiger Änderung (nicht mehr immer)
* Abgleich XCSoarAug mit XCSoar, um fehlerhafte Implementierungen von mir wieder zu beseitigen...
* Merge mit dem neuesten XCSoar-Stand von Kellermann!
* VS2019-Compilat hat noch keinen Ton!
* RC-Resourcen-Mechanismen zwischen MinGW und MSVC abgleichen!

## Hauptaufgaben
**Diese Aufgaben betreffen die generellen Planungen, was ich mit XCSoarAug vorhabe!**
* Integration Wetterdaten
* Integration GliderTracker
* Integration Luftraum-Daten (PL, CZ,...)

Erledigt:
---------
* ~~'mingw kann noch nicht UNICODE'~~

|System___|SubSystem_____|OS____|
|---------|--------------|------|
| vs2019  |              | win  |
| mgw73   |              | win  |
| mgw82   |              | win  |
| clang   |              | win  |
| clang10 |              | win  |
| android | x86          | and  |
| android | x86_64       | and  |
| android | armeable_v7b | and  |
| android | arm64_v8b    | and  |
| kobo    | ?            | kobo |
| gcc     | ?            | unix |

## 24.05.2020
* VM-Flaps5-Ubuntu 1804: Umschalten des Hypernate Befehls:
  * ``bcdedit /set hypervisorlaunchtype off`` - und **Reboot**    Danach ist aber Docker nicht mehr lauffähig,, da mus wieder auf 'on' geschalten werden (und reboot!)
  * ``git clone git://github.com/XCSoar/XCSoar XCSoar_7.0_15''
  * ``git clone https://github.com/August2111/XCSoar.git XCSoarAug''
  * ``make TARGET=UNIX``   on XCSoar_7.0_15
     * fatal error: glm/fwd.hpp: No such file or directory
     * sudo apt-get install libglm-dev
     * Danach komplettes Build!
     * Log-Output: 
  * ``make TARGET=PC``   on XCSoar_7.0_15
     * make: i686-w64-mingw32-g++: Command not found
     * sudo apt-get install gcc-mingw-w64  - das gin nicht!?!
     * ``sudo apt-get install mingw-w64``!!!!  **DAS WAR GANZ WICHTIG!** Danach konnte ich die Windows-Builds auf Ubuntu Crosscompilieren!
     * Natürlich kann man auch die mingw-Sourcen herunterladen und compilieren, oder das deb-File istallieren bzw das *-tar.gz-File auspacken und einrichten, aber am einfachsten ging es für mich über apt-get...
  * ``make TARGET=CUBIE``   on XCSoar_7.0_15
     * Es fehlte das g++ für arm... 
     * ``sudo apt-get install g++-arm-linux-gnueabihf``
* AUGUST01 (Ubuntu 1604): Das '``sudo apt-get install mingw-w64``' habe ich hier auch gleich ausprobiert und TARGET=WIN64 gestartet: Das lief auch erst einmal problemlos an!


## 23.05.2020
* AUGUST01 (Ubuntu 1604): Compiliert habe ich im Ordner XCSoar, danach habe ich ihn umgenannt in XCSour_6_8_14b ( ohne 'b' gabs schon)
## 22.05.2020
* AUGUST01 (Ubuntu 1604): Compiliert habe ich im Ordner XCSoar, danach habe ich ihn umgenannt in XCSour_6_8_14b ( ohne 'b' gabs schon)
  * Nach einigem Hin- und her ließ sich die Unix-Version  - mit Tag v6.8.14 - builden, auch hier habe ich eine CompileListUnix angelegt
  * ANDROID Build ging nicht, weil Android SDK 15b fehlte
  * WIN64 bzw. PC-Build ging nicht, weil er irgendwie keinen Boost-Zugriff bekam - wie vorher auch des Unix-Build, das aber nach einem 'sudo apt-get install libboost-dev' dann doch ging, bei WIN64 fehlte es trotzdem...!
    * bei 'src/Engine/Trace/Trace.cpp' findet er 'boost/intrusive/list.hpp' nicht

## 20.05.2020
* Versuch, XCSoarAug auf PCDERAD0633 (Ubuntu 1604) mit CMake zu kompilieren, gescheitert an TCHAR
  * tchar.h ist ein Windows-Header-File, was ich wahrscheinlich nur über die Source-Zusammenstellung für das WIN-Programm mir 'eingefangen' habe, Linux/Unix hat wahrscheinlich eine andere Source-CPP-Liste...
  * Aber vorher war ein weiter Weg:
    - Boost wird über das CMake als 'Required Component' gesucht, auch wenn es als externes Project eingebunden wird, scheitert es quasi **vor** dem Build!
    - Deshalb erst einmal die Boost manuell erstellt - in dem erwarteten 'cmake'-Ordner
    - git clone --recursive "https://github.com/boostorg/boost.git" boost  , '--recursive' ist wichtig, sonst fehlt der größte Teil!
    - git tag --list
    - git checkout boost-1.73.0
    - ./bootstrap.sh
    - ./b2- Befehl. kopiert aus 3rd_party/boost.cmake (laufen lassen und aus dem Terminal mit den richtigen Optionen kopiert)
    - Achtung: Die CMake-Option Boost_DIR stand noch auf dem falschen Verzeichnis -> das muss natürlich stimmen!
    - Der 'mapserver' hat noch ein paar Abhängigkeiten zu verschiedenen Headern: Util.Compiler.h und ein paar zzip/*.h, das habe ich mal kurzfristig gelöst, indem ich diese Dateien in den MapServer-Source-Folder entsprechend zur Verfügung gestellt habe ;-(
    - Danach gingen alle 3rd-Party Tools durch - und fing an die 
* Versuch, XCSoar auf PCDERAD0633 (Ubuntu 1604) mit Makefile zu kompilieren, gescheitert an 'Missing Targets for MapFile.hpp' (HPP?) 
  * Zuerst 'git pull' und 'git checkout v6.8.14'  (die (in-)offiziell releasede XCSoar Version (auf Download-Seite ist das noch die 6.8.13, mein Android holte aber schon die 6.8.14 ...)
  * Warum das MapFile.hpp als Target auftaucht
* Versuch, XCSoar auf PCDERAD0633 (Ubuntu 1604) mit Makefile zu kompilieren, gescheitert an 'Missing Targets for MapFile.hpp' (HPP?) 
  *

## 19.05.2020
* Versuch, auf AUGUST01 mit CMake zu kompilieren gescheitert an ???


## 15.05.2020
* FLAPS5 MinGW
    * läuft prinzipiell
* FLAPS5 VS2019
    * zurück auf Resource-PNG: Aispace-Anzeige wieder ohne Deko
    * kein Audio-Ton?

## 14.05.2020
- Aufgabe ~~'mingw kann noch nicht UNICODE'~~ erledigt!
* PC0633 Ubuntu1804 
    * CMake jetzt installiert (manuell übersetzt) auf 3.17.2 + SSL (klappte jetzt)
    * Mit -G "Unix Makefile" kam ich aber nicht weit, bereits beim CMake blieb er hängen mit '???'
* PC0781 MinGW
    * ist durchcompiliert und läuft jetzt ordentlich mit UNICODE!!!
    * die fälschlichen CR habe ich entfernt (störten im LogFile mit asserts)
    * leider war es nicht möglich, die Bitmap abzuspeichern!
* PC0781 VS2019
    * **läuft** und ist debugfähig
    * begonnen, wieder mit den PNG zu experimentieren
    * Das Szenario: Bitmap (z.B. 'airspace0.bmp') wird durch ein externes Tool in ein PNG umgewandelt - und die dann per Resource geladen
    * Das ist für die Transparenz, kann aber m.E. auch direkt geladen werden - und innnerhalb der Bitmap wird die Transparenz definiert!
  FLAPS5 MinGW
    * Gleiches Problem wie beim PC0781: Bitmap lässt sich über das Programm nicht speichern (aus Vergleichsgründen mit VS2019)


## 13.05.2020
* PC0781 MinGW ist durchcompiliert, aber mit den Defines für Unicode gibt es beim Start eine Assert-Exception(NullPtr), Versuch noch einmal ohne UNICODE... das geht, aber natürlich mit verhunzten Deutschtexten
* PC0781 VS2019 funktionierte richtig, allerdings ohne de.mo (fehlt hier noch, auch das Konvertierungs-Tool ist ja nicht da) und ohne PNG-Resourcen (Luftraumdarstellung)
* PC0633 Ubuntu1804 bekamich mit Ninja gar nicht zum Laufen, mit Generator 'Unix Makefiles' stoppte es wegen CMake 3.13 statt cmake 3.15
* PC0633 Ubuntu1804 begonnen, cmake 3.17.2 zu bauen und zu installieren! Da fehlte erst einmal OpenSSL, das kann man entweder bauen oder in cmake disablen,  ich baue die Version 1.0.2o ;-)
* PC0633 Ubuntu1804 cmake ließ sich trotzdem nicht richtig bauen, obwohl eigentlich deinstalliert, war immer noch die 3.13 am Start - und nicht die 3.17.2, die sich aber auch nicht richtig bauen ließ ;-(

## 12.05.2020
* auf dem PC0781 hatte ich schon aufgeräumt (Beseitigung der alten und überflüssigene Dateien im Root-Verzeichnis - hier klappt es aber irgend wie nicht...
* Flaps5-msvc: Einschalten des Defines '_UNICODE' im VS-Compile
  * Nach einigen Problemen beim Übersetzen (Der Compiler hatte offensichtlich nicht alle Dateien mitgenommen (?)) und deswegen einigen neuen 'char buffer[size]' Deklarationen kame jetzt richtige UTF-8 Datensätze am Display an! HURRA!
  * Damit nächste Hürde genommen: UTF-8 sollte ab jetzt gehen
* Flaps5-clang10: std:c++11, 14, 17 probiert, aber es kam immer der Fehler mit dem __attribute__ nach ca. 350-400 der 1241(?) cpp-Dateien..., komme damit momentan nicht weiter
* Flaps5-mingw/gcc: 

## 08.05.2020
#### Flaps5:
* *msvc*: Umwandlung der Binary-(Language-)Dateien in einen C-Block geändert: Nicht mehr den ASM-Block vom GCC (der bei VS nicht funktioniert), sondern das Tool '???', welches einzelne Bytes in binar dargestellte Zahlen umwandelt
  * Nachteil sind die größeren (temporären) Dateien, möglicherweise auch die Compile-Zeit
  * Vorteil: von allen Compilern verwendbar, klare Struktur, einheitliche Syntax!


## 21.03.2020
Path-Variable
* PATH=$(PATH);D:\Projects\3rd_Party\curl\curl-7.64.1\build\Win64\VC16\DLL Release;D:\link_libs\zlib\zlib-1.2.11\bin


* *kursiv*: 
