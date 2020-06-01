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
)
if(WIN32)
  list(APPEND Util_SOURCES
        Util/WASCII.cxx
        Util/WStringCompare.cxx
        Util/WStringStrip.cxx
        Util/WStringUtil.cpp
  )
endif()


