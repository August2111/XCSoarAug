## Aufgaben
* Bereinigen der char-Array-Deklarationen, ab jetzt mit   std::vector<char> buffer(buflen);... und Zugriff  statt buffer mit &buffer[0]
* Drei externe Projekte sind noch zu sehr mit XCSoar verwoben, so dass sie nicht eigenständig compiliert werden können (xml, mapserver und ?zzip?)
* msvc lässt den Resourcen-Import der PNG-Dateien nicht zu!!!!
* mingw kann noch nicht UNICODE
* ANDROID!!!!!
* KOBO!
* Linux
* Übersetzung der externen 3rd Party-Pojekte nur bei richtiger Änderung (nicht immer)
* Abgleich XCSoarAug mit XCSoar, um fehlerhafte Implementierungen von mir wieder zu beseitigen...
* Merge mit dem neuesten XCSoar-Stand von Kellermann!

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
