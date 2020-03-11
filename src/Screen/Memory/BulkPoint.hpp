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

#ifndef XCSOAR_SCREEN_OPENGL_BULK_POINT_HPP
#define XCSOAR_SCREEN_OPENGL_BULK_POINT_HPP

#include "Screen/Point.hpp"

/**
 * A point structure to be used in arrays.
 */
struct BulkPixelPoint : PixelPoint {
  BulkPixelPoint() = default;

#ifdef AUG_MSC
  constexpr BulkPixelPoint(int x, int y = 0)
    :PixelPoint(static_cast<double>(x), 
      static_cast<double>(y)) {
  }

  BulkPixelPoint operator=(const PixelPoint& p) {
    // BulkPixelPoint p2(p.x, p.y);
    return BulkPixelPoint(p.x, p.y); // { static_cast<double>(p.x), static_cast<double>(p.y) };
  }
#else  // AUG_MSC
  template<typename... Args>
  constexpr BulkPixubleelPoint(Args&&... args)
    :PixelPoint(args...) {}
#endif  // AUG_MSC
};

#endif
