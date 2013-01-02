/*
Copyright_License {

  XCSoar Glide Computer - http://www.xcsoar.org/
  Copyright (C) 2000-2013 The XCSoar Project
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

#include "LogComputer.hpp"
#include "NMEA/MoreData.hpp"
#include "NMEA/Derived.hpp"
#include "Logger/Settings.hpp"
#include "Logger/Logger.hpp"

LogComputer::LogComputer()
  :log_clock(fixed(5)),
   logger(NULL) {}

void
LogComputer::Reset()
{
  last_location = GeoPoint::Invalid();
  fast_log_num = 0;
}

void
LogComputer::StartTask(const NMEAInfo &basic)
{
  if (logger != NULL)
    logger->LogStartEvent(basic);
}

bool
LogComputer::Run(const MoreData &basic, const DerivedInfo &calculated,
                 const LoggerSettings &settings_logger)
{
  /// @todo consider putting this sanity check inside Parser
  if (basic.location_available && last_location.IsValid() &&
      basic.location.Distance(last_location) > fixed(200))
    // prevent bad fixes from being logged or added to OLC store
    return false;

  last_location = basic.location_available
    ? basic.location : GeoPoint::Invalid();

  // log points more often in circling mode
  if (calculated.circling)
    log_clock.SetDT(fixed(settings_logger.time_step_circling));
  else
    log_clock.SetDT(fixed(settings_logger.time_step_cruise));

  if (fast_log_num) {
    log_clock.SetDT(fixed(1));
    fast_log_num--;
  }

  if (log_clock.CheckAdvance(basic.time) && logger != NULL)
      logger->LogPoint(basic);

  return true;
}
