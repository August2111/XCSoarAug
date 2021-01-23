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

#ifndef XCSOAR_FILE_TO_WEGLIDE_HPP
#define XCSOAR_FILE_TO_WEGLIDE_HPP

#include "Language/Language.hpp"
#include "LocalPath.hpp"
#include "net/http/Init.hpp"
#include "net/http/Session.hpp"
#include "net/http/ToBuffer.hpp"
#include "Job/Runner.hpp"
#include "util/StringUtil.hpp"
// #include "system/ConvertPathName.hpp"

#include <curl/curl.h>

class FileToWeGlide {

private:
  CURL *curl;
  CURLcode res;

  struct curl_httppost *formpost;
  struct curl_httppost *lastptr;
  struct curl_slist *headerlist;

  unsigned pilot_id = 0;
  char pilot_dob[16];
  unsigned aircraft_type_id = 0;
  char IGC_file_location[256];
  char send_to_URL[256];

  void elimchar(char *p, char c);
  bool json_tok(char *data, size_t n, char *userp, int level, char *token);

public:
  FileToWeGlide() {
    curl = nullptr;
    formpost = nullptr;
    lastptr = nullptr;
    headerlist = nullptr;

    // curl_global_init(CURL_GLOBAL_ALL);
    curl_global_init(CURL_GLOBAL_WIN32);
    headerlist = curl_slist_append(headerlist, "Content-Type: multipart/form-data");
  }

  ~FileToWeGlide() {
    // curl_global_cleanup();
    curl_easy_cleanup(curl);
    curl_formfree(formpost);
    curl_slist_free_all(headerlist);
  }

  bool SetWeGlideUploadParam(const unsigned pid, const char *dob, const unsigned type) {
    if ((pid == 0) || (type == 0)) return false;
    pilot_id = pid;
    CopyString(pilot_dob,dob,sizeof(pilot_dob)-1);
    aircraft_type_id = type;
    return true;
    }

  bool SetWeGlideUploadFile(const char* file) {
    // aug CopyString(IGC_file_location,(const char *)NarrowPathName(file),sizeof(IGC_file_location)-1);
    CopyString(IGC_file_location,file,sizeof(IGC_file_location)-1);
    return true;
    }

  bool SetWeGlideUploadURL(const char *url) {
    CopyString(send_to_URL,url,sizeof(send_to_URL)-1);
    return true;
    }

  bool DoUploadToWeGlide(char *err_msg, size_t size_err, char *msg, size_t size_msg);
};

#endif
