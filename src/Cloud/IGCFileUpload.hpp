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

#ifndef XCSOAR_IGC_FILE_UPLOAD_HPP
#define XCSOAR_IGC_FILE_UPLOAD_HPP

#include "Language/Language.hpp"
#include "LocalPath.hpp"
#include "net/http/Init.hpp"
#include "net/http/Session.hpp"
#include "net/http/ToBuffer.hpp"
#include "Job/Runner.hpp"

// aug +
// typedef char* Path;
// aug -

class IGCFileUpload {
public:
enum Platform {
  None = 0,
  WeGlide
};

typedef Platform CompPlatform;

private:
  Platform platform = None;
  char pilot_name[100];
  char aircraft_type[100];
  char err_msg[200];
  char message_buf[500];

  void elimchar(char *p, char c);
  bool json_tok(char *data, size_t n, char *userp, int level, const char *token);

public:
  const TCHAR *default_URL;

  IGCFileUpload(CompPlatform pf) {
  platform = pf;
  Set_pilot_name();
  Set_aircraft_type();
//  if (pf == WeGlide) default_URL = _("https://api.weglide.org/v1/");
  if (pf == WeGlide) default_URL = _("http://api.weglide.org/v1/");
  else default_URL = nullptr;
  }

  ~IGCFileUpload() {
  platform = None;
  }

// aug  void PostIGCFile(Path path);
  void PostIGCFile(const wchar_t* path);
  bool GetWeGlidePilotName(const unsigned pilot_id,
      Net::Session &session, JobRunner &runner);
  void Set_pilot_name(const char *name = "-- Undefined --");
  bool GetWeGlideAircraftType(const unsigned aircraft_type_id,
      Net::Session &session, JobRunner &runner);
  void Set_aircraft_type(const char *type = "-- Undefined --");
  // aug bool Upload2WeGlide(Path path,const unsigned aircraft_type_id,
  bool Upload2WeGlide(const wchar_t* path,const unsigned aircraft_type_id,
      const unsigned pilot_id, const char *pilot_dob);
};

bool valid_DoB(const TCHAR *dob_str);

#endif
