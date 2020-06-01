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
if(UNIX)
  list(APPEND OS_SOURCES
        OS/EventPipe.cpp
  )
endif()

