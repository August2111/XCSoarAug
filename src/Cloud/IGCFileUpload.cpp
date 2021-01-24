/*
  Copyright_License {

  XCSoar Glide Computer - http://www.xcsoar.org/
  Copyright (C) 2000-2016 The XCSoar Project
  A detailed list of copyright holders can be found in the file "AUTHORS".

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}
*/

#include "Cloud/IGCFileUpload.hpp"
#include "Cloud/FileToWeGlide.hpp"
#include "LocalPath.hpp"
#include "Interface.hpp"
#include "Computer/Settings.hpp"
#include "LogFile.hpp"
#include "Dialogs/Message.hpp"
#include "Language/Language.hpp"
#include "net/http/Init.hpp"
#include "net/http/Session.hpp"
#include "net/http/ToBuffer.hpp"
#include "Dialogs/JobDialog.hpp"
#include "Dialogs/Error.hpp"
#include "UIGlobals.hpp"
#include "util/StringUtil.hpp"
#include "util/StringCompare.hxx"
#include "util/ConvertString.hpp"
#include "util/StaticString.hxx"
// aug #include "system/ConvertPathName.hpp"

#include <type_traits>

void
IGCFileUpload::elimchar(char *p, char c)
{
  char *dest = p;

  while (*p != '\0') {
    if (*p != c) *dest++ = *p;
    p++;
  }
  *dest = '\0';
  return;
}


bool
IGCFileUpload::json_tok(char *data, size_t n, char *userp, int level, const char *token)
// this is quick and dirty!!  may not work at all.
{
  int at_level = 0;
  char look_for[100];
  char *startp, *endp, *p;

  /***
  strcpy(look_for,"\"");
  strcat(look_for,token);
  strcat(look_for,"\":");
  ***/
  CopyString(
    CopyString(
      CopyString(look_for,"\"",sizeof(look_for)),
      token,sizeof(look_for)),
    "\":",sizeof(look_for));

  *userp = '\0';
  while(n > 0) {
    if (*data == '{') at_level += 1;
    else if (*data == '}') at_level -= 1;
    if (at_level == level) {
      p = strstr(data,look_for);
      if (p != NULL) {
        startp = p + strlen(look_for);
        endp = strpbrk(startp+1,"\",");
        if (endp != NULL) {
          *endp = '\0';
          elimchar(startp,'"');
          strcpy(userp,startp);
          return true;
        }
      }
    }
    data++;
    n--;
  }
  return false;
}

void
IGCFileUpload::Set_pilot_name(const char *name)
{
  CopyString(IGCFileUpload::pilot_name,name,sizeof(IGCFileUpload::pilot_name));
}

void
IGCFileUpload::Set_aircraft_type(const char *type)
{
  CopyString(IGCFileUpload::aircraft_type,type,sizeof(IGCFileUpload::aircraft_type));
}

bool
IGCFileUpload::GetWeGlidePilotName(const unsigned pilot_id,
      Net::Session &session, JobRunner &runner)
{
    char buffer[4096];
    // static const char default_URL[] = "https://api.weglide.org/v1/";

  IGCFileUpload::Set_pilot_name();
  if (pilot_id == 0) { // no pilot
    return false;
  }

  NarrowString<1024> query_URL;
  query_URL.Format("%wsuser/%d",default_URL,pilot_id);
//  sprintf(buffer, "%ws", query_URL);

  // Request lookup pilot or aircraft name
  Net::DownloadToBufferJob job(session,query_URL,buffer,sizeof(buffer)-1);
  if (!runner.Run(job))
    return false;

  buffer[job.GetLength()] = 0;
  return IGCFileUpload::json_tok(buffer,sizeof(buffer),IGCFileUpload::pilot_name,1,"name");
}

bool
IGCFileUpload::GetWeGlideAircraftType(const unsigned aircraft_type_id,
      Net::Session &session, JobRunner &runner)
{
    char buffer[4096];
    // static const char default_URL[] = "https://api.weglide.org/v1/";

  IGCFileUpload::Set_aircraft_type();
  if (aircraft_type_id == 0) { // no type ID
    return false;
  }

  NarrowString<1024> query_URL;
  query_URL.Format("%wsaircraft/%d",default_URL,aircraft_type_id);
//  char path[256];
//  sprintf(buffer, "%ws", query_URL);

  // Request lookup pilot or aircraft name
  Net::DownloadToBufferJob job(session,query_URL,buffer,sizeof(buffer)-1);
  if (!runner.Run(job))
    return false;

  buffer[job.GetLength()] = 0;
  return IGCFileUpload::json_tok(buffer,sizeof(buffer),IGCFileUpload::aircraft_type,1,"name");
}

bool
// augIGCFileUpload::Upload2WeGlide(Path path, const unsigned aircraft_type_id,
IGCFileUpload::Upload2WeGlide(const wchar_t* _path, const unsigned aircraft_type_id,
      const unsigned pilot_id, const char *pilot_dob) {
    
    char path[256];
    sprintf(path, "%ws", _path);
  FileToWeGlide PostFile;
//  if (path.IsNull()) return false;
  if (!path || !strlen(path)) return false;

  bool rv = PostFile.SetWeGlideUploadParam(pilot_id,pilot_dob,aircraft_type_id);
  if (rv) rv = PostFile.SetWeGlideUploadURL("https://api.weglide.org/v1/igcfile");
  if (rv) rv = PostFile.SetWeGlideUploadFile(path);
  if (rv) rv = PostFile.DoUploadToWeGlide(err_msg,sizeof(err_msg),message_buf,sizeof(message_buf));

  return rv;
}

bool
valid_DoB(const TCHAR *dob_str) // TODO: improve validation yyyy-mm-dd
{
  size_t l = StringLength(dob_str);
  if ((l >= 8) && (l <= 10)) return true;
  return false;
}

void
IGCFileUpload::PostIGCFile(const wchar_t* _path)
{
  const ComputerSettings &settings_computer = CommonInterface::GetComputerSettings();
  const Plane &plane = settings_computer.plane;
  const LoggerSettings &logger = settings_computer.logger;
  StaticString<256> msg;


  msg.Format(_T("WeGlide Upload %s for %s, TypeID %d, PilotID %d, DoB %s"),
#if _AUG_MSC
  _path,
#else
      (const char *)NarrowPathName(_path),
#endif
    plane.registration.c_str(),
    plane.weglide_aircraft_type,
    logger.weglide_pilot_id,
    logger.weglide_pilot_dob.c_str());

  // LogFormat("%s",(const char *)msg.c_str());
  LogFormat(msg);

  /* do we have all we need to approach WeGlide */
  if ((logger.weglide_pilot_id == 0)
    || !valid_DoB(logger.weglide_pilot_dob.c_str())
    || (plane.weglide_aircraft_type == 0))
      return;

  DialogJobRunner runner(UIGlobals::GetMainWindow(), UIGlobals::GetDialogLook(),
      _("Download from WeGlide"), true);

  try {
    Net::Session session;

    char buffer[0x4000];
//    Net::DownloadToBufferJob job(session, "https://api.weglide.org/v1/user/511", buffer, sizeof(buffer) - 1);
//    if (!runner.Run(job))
//    {
//        LogFormat("buffer = %s", buffer);
//        return;
//    }
//    LogFormat("buffer = %s", buffer);

    /** Look up Pilot and Aircraft **/
//    IGCFileUpload::GetWeGlidePilotName(logger.weglide_pilot_id,session,runner);
//    IGCFileUpload::GetWeGlideAircraftType(plane.weglide_aircraft_type,session,runner);
  } catch (...) {
    ShowError(std::current_exception(), _T("WeGlide Upload"));
    LogFormat(_("WeGlide Upload: No network available"));
    return;
  }

  memcpy(IGCFileUpload::pilot_name,L"Uwe",8);
  memcpy(IGCFileUpload::aircraft_type , L"JS1",8);
  msg.Format(_T("Pilot: %s (%d)\nAircraft: %s (%d)"),
      IGCFileUpload::pilot_name, logger.weglide_pilot_id,
      IGCFileUpload::aircraft_type, plane.weglide_aircraft_type);
  if (ShowMessageBox(msg,
    _("Upload flight to WeGlide"), MB_YESNO | MB_ICONQUESTION) != IDYES) {
      LogFormat(_T("Abort Upload flight %s"),
#if _AUG_MSC
          _path);
#else
          (const char*)NarrowPathName(_path));
#endif
    } else {
      if (IGCFileUpload::Upload2WeGlide(_path, plane.weglide_aircraft_type,
	      logger.weglide_pilot_id,(const char *)logger.weglide_pilot_dob.c_str())) {
	char flt_msg[100];
	if (json_tok(message_buf,strlen(message_buf),flt_msg,1,"detail"))
	  CopyString(message_buf,flt_msg,sizeof(message_buf));
	if (json_tok(message_buf,strlen(message_buf),flt_msg,1,"id"))
	  CopyString(CopyString(message_buf,"Flight ID ",sizeof(message_buf)),
	    flt_msg,sizeof(message_buf));

    //wchar_t* net_message();
    wchar_t s[256];
    // wsprintf(s, L"%s", message_buf);
    mbstowcs(s, message_buf, strlen(message_buf)+1);
	msg.Format(_T("Success! %s"), s);
    LogFormat(msg);
        ShowMessageBox(msg,_("Upload flight to WeGlide"), MB_OK | MB_ICONINFORMATION);
      } else {
	msg.Format(_T("Error! %s",err_msg));
    LogFormat(msg);
    ShowMessageBox(msg,_("Upload flight to WeGlide"), MB_OK | MB_ICONINFORMATION);
      }
    }
}
