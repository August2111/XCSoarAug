/*
Copyright_License {

  XCSoar Glide Computer - http://www.xcsoar.org/
  Copyright (C) 2000-2011 The XCSoar Project
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

#include "InfoBoxes/Content/Altitude.hpp"
#include "InfoBoxes/Panel/AltitudeInfo.hpp"
#include "InfoBoxes/Panel/AltitudeSimulator.hpp"
#include "InfoBoxes/Panel/AltitudeSetup.hpp"
#include "InfoBoxes/InfoBoxWindow.hpp"
#include "InfoBoxes/InfoBoxManager.hpp"
#include "Units/UnitsFormatter.hpp"
#include "Units/Units.hpp"
#include "Interface.hpp"
#include "Components.hpp"
#include "Engine/Waypoint/Waypoint.hpp"
#include "Engine/Waypoint/Waypoints.hpp"

#include "DeviceBlackboard.hpp"
#include "Components.hpp"
#include "Simulator.hpp"
#include "Protection.hpp"

#include "Util/Macros.hpp"

#include <tchar.h>
#include <stdio.h>

/*
 * Subpart callback function pointers
 */

static gcc_constexpr_data
InfoBoxContentAltitude::PanelContent Panels[] = {
  InfoBoxContentAltitude::PanelContent (
    N_("Simulator"),
    LoadAltitudeSimulatorPanel),

  InfoBoxContentAltitude::PanelContent (
    N_("Info"),
    LoadAltitudeInfoPanel,
    NULL,
    AltitudeInfoPreShow),

  InfoBoxContentAltitude::PanelContent (
    N_("Setup"),
    LoadAltitudeSetupPanel)
};

static gcc_constexpr_data
InfoBoxContentAltitude::DialogContent dlgContent = {
  ARRAY_SIZE(Panels), &Panels[0],
};

const InfoBoxContentAltitude::DialogContent *
InfoBoxContentAltitude::GetDialogContent() {
  return &dlgContent;
}

void
InfoBoxContentAltitudeGPS::Update(InfoBoxWindow &infobox)
{
  const NMEAInfo &basic = CommonInterface::Basic();
  TCHAR sTmp[32];

  if (!basic.gps_altitude_available) {
    infobox.SetInvalid();
    return;
  }

  // Set Value
  Units::FormatUserAltitude(basic.gps_altitude, sTmp,
                            ARRAY_SIZE(sTmp), false);
  infobox.SetValue(sTmp);

  // Set Comment
  Units::FormatAlternateUserAltitude(basic.gps_altitude, sTmp,
                                     ARRAY_SIZE(sTmp));
  infobox.SetComment(sTmp);

  // Set Unit
  infobox.SetValueUnit(Units::current.altitude_unit);
}

static void
ChangeAltitude(const fixed step)
{
  const NMEAInfo &basic = CommonInterface::Basic();

  device_blackboard->SetAltitude(basic.gps_altitude +
                                 (fixed)Units::ToSysAltitude(step));
}

bool
InfoBoxContentAltitudeGPS::HandleKey(const InfoBoxKeyCodes keycode)
{
  const NMEAInfo &basic = CommonInterface::Basic();

  if (!is_simulator())
    return false;
  if (!basic.gps.simulator)
    return false;

  const Angle a5 = Angle::Degrees(fixed(5));

  switch (keycode) {
  case ibkUp:
    ChangeAltitude(fixed(+100));
    return true;

  case ibkDown:
    ChangeAltitude(fixed(-100));
    return true;

  case ibkLeft:
    device_blackboard->SetTrack(
        basic.track - a5);
    return true;

  case ibkRight:
    device_blackboard->SetTrack(
        basic.track + a5);
    return true;

  case ibkEnter:
    break;
  }

  return false;
}

void
InfoBoxContentAltitudeAGL::Update(InfoBoxWindow &infobox)
{
  const DerivedInfo &calculated = CommonInterface::Calculated();
  TCHAR sTmp[32];

  if (!calculated.altitude_agl_valid) {
    infobox.SetInvalid();
    return;
  }

  // Set Value
  Units::FormatUserAltitude(calculated.altitude_agl, sTmp,
                            ARRAY_SIZE(sTmp), false);
  infobox.SetValue(sTmp);

  // Set Comment
  Units::FormatAlternateUserAltitude(calculated.altitude_agl, sTmp,
                                     ARRAY_SIZE(sTmp));
  infobox.SetComment(sTmp);

  // Set Unit
  infobox.SetValueUnit(Units::current.altitude_unit);

  // Set Color (red/black)
  infobox.SetColor(calculated.altitude_agl <
      XCSoarInterface::SettingsComputer().task.route_planner.safety_height_terrain ? 1 : 0);
}

void
InfoBoxContentAltitudeBaro::Update(InfoBoxWindow &infobox)
{
  const NMEAInfo &basic = CommonInterface::Basic();
  TCHAR sTmp[32];

  if (!basic.baro_altitude_available) {
    infobox.SetInvalid();

    if (basic.pressure_altitude_available)
      infobox.SetComment(_("no QNH"));

    return;
  }

  // Set Value
  Units::FormatUserAltitude(basic.baro_altitude, sTmp,
                            ARRAY_SIZE(sTmp), false);
  infobox.SetValue(sTmp);

  // Set Comment
  Units::FormatAlternateUserAltitude(basic.baro_altitude, sTmp,
                                     ARRAY_SIZE(sTmp));
  infobox.SetComment(sTmp);

  // Set Unit
  infobox.SetValueUnit(Units::current.altitude_unit);
}

void
InfoBoxContentAltitudeQFE::Update(InfoBoxWindow &infobox)
{
  const NMEAInfo &basic = CommonInterface::Basic();
  TCHAR sTmp[32];

  if (!basic.gps_altitude_available) {
    infobox.SetInvalid();
    return;
  }

  fixed Value = basic.gps_altitude;

  const Waypoint *home_waypoint = way_points.GetHome();
  if (home_waypoint)
    Value -= home_waypoint->altitude;

  // Set Value
  Units::FormatUserAltitude(Value, sTmp,
                            ARRAY_SIZE(sTmp), false);
  infobox.SetValue(sTmp);

  // Set Comment
  Units::FormatAlternateUserAltitude(Value, sTmp,
                                     ARRAY_SIZE(sTmp));
  infobox.SetComment(sTmp);

  // Set Unit
  infobox.SetValueUnit(Units::current.altitude_unit);
}

void
InfoBoxContentFlightLevel::Update(InfoBoxWindow &infobox)
{
  const NMEAInfo &basic = CommonInterface::Basic();
  const SETTINGS_COMPUTER &settings_computer =
    CommonInterface::SettingsComputer();
  TCHAR sTmp[32];

  if (basic.pressure_altitude_available) {
    fixed Altitude = Units::ToUserUnit(basic.pressure_altitude, unFeet);

    // Title color black
    infobox.SetColorTop(0);

    // Set Value
    _stprintf(sTmp, _T("%03d"), iround(Altitude/100));
    infobox.SetValue(sTmp);

    // Set Comment
    _stprintf(sTmp, _T("%dft"), iround(Altitude));
    infobox.SetComment(sTmp);

  } else if (basic.gps_altitude_available &&
             settings_computer.pressure_available) {
    // Take gps altitude as baro altitude. This is inaccurate but still fits our needs.
    const AtmosphericPressure &qnh = settings_computer.pressure;
    fixed Altitude = Units::ToUserUnit(qnh.QNHAltitudeToPressureAltitude(basic.gps_altitude), unFeet);

    // Title color red
    infobox.SetColorTop(1);

    // Set Value
    _stprintf(sTmp, _T("%03d"), iround(Altitude/100));
    infobox.SetValue(sTmp);

    // Set Comment
    _stprintf(sTmp, _T("%dft"), iround(Altitude));
    infobox.SetComment(sTmp);

  } else if ((basic.baro_altitude_available || basic.gps_altitude_available) &&
             !settings_computer.pressure_available) {
    infobox.SetInvalid();
    infobox.SetComment(_("no QNH"));
  } else {
    infobox.SetInvalid();
  }
}

void
InfoBoxContentTerrainHeight::Update(InfoBoxWindow &infobox)
{
  const DerivedInfo &calculated = CommonInterface::Calculated();
  TCHAR sTmp[32];

  if (!calculated.terrain_valid){
    infobox.SetInvalid();
    return;
  }

  // Set Value
  Units::FormatUserAltitude(calculated.terrain_altitude, sTmp,
                            ARRAY_SIZE(sTmp), false);
  infobox.SetValue(sTmp);

  // Set Comment
  Units::FormatAlternateUserAltitude(calculated.terrain_altitude, sTmp,
                                     ARRAY_SIZE(sTmp));
  infobox.SetComment(sTmp);

  // Set Unit
  infobox.SetValueUnit(Units::current.altitude_unit);
}

