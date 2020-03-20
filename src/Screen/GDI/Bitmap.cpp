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

#include "Screen/Bitmap.hpp"
#include "Screen/Debug.hpp"
#include "OS/Path.hpp"

#include <assert.h>

#ifdef _AUG   // "hat bereits einen Funktionsrumpf"
// Bitmap::Bitmap() {
// 
// }

Bitmap::Bitmap(Bitmap&& src)
#   ifdef USE_MEMORY_CANVAS
#       ifdef AUG_MSC
{
  // TODO!!!!!!!!!!!!!!! bitmap gibt es nicht!
}
#       else
  :bitmap(src.bitmap) {
  src.bitmap = nullptr;
}
#       endif
// #endif
#   else
{
  // TODO!!!!!!!!!!!!!!! bitmap gibt es nicht!
}
#   endif
#endif

bool
Bitmap::LoadFile(Path path)
{
  return false;
}

void
Bitmap::Reset()
{
#ifdef USE_MEMORY_CANVAS
  {
#ifdef AUG_MSC
    // TODO!!!!!!!!!!!!!!! bitmap gibt es nicht!
#endif

#else
#ifndef NDEBUG
    bool success =
#endif
      ::DeleteObject(bitmap);
    assert(success);

    bitmap = nullptr;
    if (bitmap != nullptr) {
      assert(IsScreenInitialized());
#endif
  }
}

// #ifndef AUG_MSC  // "hat bereits einen Funktionsrumpf"
PixelSize
Bitmap::GetSize() const
{
  assert(IsDefined());

  BITMAP bm;
#ifndef AUG_MSC
  ::GetObject(bitmap, sizeof(bm), &bm);
#endif
  const PixelSize size = { bm.bmWidth, bm.bmHeight };
  return size;
}
// #endif
