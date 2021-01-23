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
#include "UIGlobals.hpp"
#include "util/StringUtil.hpp"

static size_t
collect_message(char *data, size_t n, size_t l, char *userp)
{
  size_t cnt = n*l;
  if (cnt > 500) cnt = 500;
  CopyString(userp,data,cnt);
  *(userp+cnt) = 0;
  // json_tok(data,n*l,userp,1,"name");
  return n*l;
}

bool
FileToWeGlide::DoUploadToWeGlide(char *err, size_t size_err, char *msg, size_t size_msg) {
  /* Fill in the user ID, date of birth, glider ID */
  char user_id[16];
  char aircraft_id[16];
  sprintf(user_id,"%d",pilot_id);
  sprintf(aircraft_id,"%d",aircraft_type_id);

  curl_formadd(&formpost,
	       &lastptr,
	       CURLFORM_COPYNAME, "user_id",
	       CURLFORM_COPYCONTENTS, user_id,
	       CURLFORM_END);

  curl_formadd(&formpost,
	       &lastptr,
	       CURLFORM_COPYNAME, "date_of_birth",
	       CURLFORM_COPYCONTENTS, pilot_dob,
	       CURLFORM_END);

  curl_formadd(&formpost,
	       &lastptr,
	       CURLFORM_COPYNAME, "aircraft_id",
	       CURLFORM_COPYCONTENTS, aircraft_id,
	       CURLFORM_END);

  /* Fill in the file upload field */
  curl_formadd(&formpost,
	       &lastptr,
	       CURLFORM_COPYNAME, "file",
	       CURLFORM_FILE, IGC_file_location,
	       CURLFORM_CONTENTTYPE, "application/octet-stream",
	       CURLFORM_END);

  curl = curl_easy_init();
  if (!curl) return false;

  curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, collect_message);
  curl_easy_setopt(curl, CURLOPT_WRITEDATA, msg);

  curl_easy_setopt(curl, CURLOPT_URL, send_to_URL);
  curl_easy_setopt(curl, CURLOPT_HTTPPOST, formpost);
  /* Perform the request, res will get the return code */
  res = curl_easy_perform(curl);
  /* Check for errors */
  if(res != CURLE_OK) {
    CopyString(err,curl_easy_strerror(res),size_err-1);
    return false;
    }
  *err = 0;
  return true;
}
