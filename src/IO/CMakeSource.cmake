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

        IO/LogFile.cpp  # aug!
)
if(UNIX)
  list(APPEND IO_SOURCES
        IO/Async/SignalListener.cpp
  )
endif()

