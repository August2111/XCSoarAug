set(Event_SOURCES
        Event/DelayedNotify.cpp
        Event/Globals.cpp
        Event/Idle.cpp
        Event/Notify.cpp
)
if(UNIX)
  list(APPEND Event_SOURCES
          Event/Poll/Timer.cpp
          Event/Poll/Loop.cpp
          Event/Poll/Queue.cpp
          Event/Poll/X11Queue.cpp
  )
elseif(WIN32)
  list(APPEND Event_SOURCES
          Event/Shared/Timer.cpp
          Event/Shared/TimerQueue.cpp
          Event/Windows/Loop.cpp
          Event/Windows/Queue.cpp
  )
endif()

