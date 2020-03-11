#include "Startup.hpp"
#include "LocalPath.hpp"
#include "Version.hpp"
#include "LogFile.hpp"
#include "CommandLine.hpp"
#include "MainWindow.hpp"
#include "Interface.hpp"
#include "Look/GlobalFonts.hpp"
#include "Screen/Init.hpp"
#include "Net/HTTP/Init.hpp"
#include "UtilsSystem.hpp"
#include "ResourceLoader.hpp"
#include "Language/Language.hpp"
#include "Language/LanguageGlue.hpp"
#include "Simulator.hpp"
#include "Audio/GlobalPCMMixer.hpp"
#include "Audio/GlobalPCMResourcePlayer.hpp"
#include "Audio/GlobalVolumeController.hpp"
#include "OS/Args.hpp"
#include "IO/Async/GlobalAsioThread.hpp"


// bool __cdecl Startup(void) { return false; }
// void __cdecl Shutdown(void) { return ; }
// bool __cdecl InitialiseDataPath(void) { return 0; }
// void __cdecl DeinitialiseDataPath(void) { return ; }
// void __cdecl LogFormat(char const*, ...)  noexcept { return ; }
void __cdecl CommandLine::Parse(class Args&) { return ; }
int __cdecl TopWindow::RunEventLoop(void) { return 0; }
void __cdecl Fonts::Deinitialize(void) { return ; }
// public: 
__cdecl ScreenGlobalInit::ScreenGlobalInit(void) { return ; }
// public: 
__cdecl ScreenGlobalInit::~ScreenGlobalInit(void) { return ; }
void
Net::Initialise() {
//  curl_global_init(CURL_GLOBAL_WIN32);
}

void
Net::Deinitialise() {
//  curl_global_cleanup();
}

void __cdecl StartupLogFreeRamAndStorage(void) { return; }
void __cdecl AllowLanguage(void) { return ; }
void __cdecl DisallowLanguage(void) { return ; }
void __cdecl InitLanguage(void) { return ; }
void __cdecl InitialiseAsioThread(void) { return ; }
void __cdecl DeinitialiseAsioThread(void) { return ; }
// char const* const XCSoar_ProductToken = "12345";
class MainWindow* CommonInterface::main_window = nullptr; 

void LogFormat(const char* fmt, ...) noexcept {
  printf(fmt);
}