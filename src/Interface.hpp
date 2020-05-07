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

#ifndef XCSOAR_INTERFACE_HPP
#define XCSOAR_INTERFACE_HPP

#include "Blackboard/InterfaceBlackboard.hpp"
// #ifdef  AUGUST  // TODO(aug): was habe ich hier gemacht (und warum)?
// #include "Thread/Debug.hpp"

#include "Util/Compiler.h"
// #else
// class InterfaceBlackboard;
//
// #endif  // AUGUST

struct UIState;
class MainWindow;

/** 
 * Class to hold data/methods accessible by all interface subsystems
 */
namespace CommonInterface {
  namespace Private {
    extern UIState ui_state;
    extern InterfaceBlackboard blackboard;

    /**
     * True if movement was detected on a real GPS.
     */
    extern bool movement_detected;
  }

  // window.. make this protected TODO so have to subclass to get access
  extern MainWindow *main_window;

  static inline bool MovementDetected() {
    return Private::movement_detected;
  }

#ifdef _MSC_VER
#   define MY_ASSERT(expression) ((void)0)
#else  // _MSC_VER
#   define MY_ASSERT(expression) ((void)0)
// #   define MY_ASSERT assert
#endif  // _MSC_VER

  // TODO: make this protected
  /**
   * Returns InterfaceBlackboard.Basic (NMEA_INFO) (read-only)
   * @return InterfaceBlackboard.Basic
   */
  gcc_const
  static inline const MoreData &Basic() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.Basic();
  }

  /**
   * Returns InterfaceBlackboard.Calculated (DERIVED_INFO) (read-only)
   * @return InterfaceBlackboard.Calculated
   */
  gcc_const
  static inline const DerivedInfo &Calculated() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.Calculated();
  }

  gcc_const
  static inline const SystemSettings &GetSystemSettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.GetSystemSettings();
  }

  gcc_const
  static inline SystemSettings &SetSystemSettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.SetSystemSettings();
  }

  /**
   * Returns the InterfaceBlackboard.ComputerSettings (read-only)
   * @return The InterfaceBlackboard.ComputerSettings
   */
  gcc_const
  static inline const ComputerSettings& GetComputerSettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.GetComputerSettings();
  }

  /**
   * Returns the InterfaceBlackboard.ComputerSettings (read-write)
   * @return The InterfaceBlackboard.ComputerSettings
   */
  gcc_const
  static inline ComputerSettings &SetComputerSettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.SetComputerSettings();
  }

  gcc_const
  static inline const UISettings &GetUISettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.GetUISettings();
  }

  /**
   * Returns the InterfaceBlackboard.MapSettings (read-only)
   * @return The InterfaceBlackboard.MapSettings
   */
  gcc_const
  static inline const MapSettings& GetMapSettings() {
    MY_ASSERT(InMainThread());

    return GetUISettings().map;
  }

  gcc_const
  static inline const FullBlackboard &Full() {
    MY_ASSERT(InMainThread());

    return Private::blackboard;
  }

  gcc_const
  static inline LiveBlackboard &GetLiveBlackboard() {
    MY_ASSERT(InMainThread());

    return Private::blackboard;
  }

  gcc_const
  static inline UISettings &SetUISettings() {
    MY_ASSERT(InMainThread());

    return Private::blackboard.SetUISettings();
  }

  gcc_const
  static inline const DisplaySettings& GetDisplaySettings() {
    MY_ASSERT(InMainThread());

    return GetUISettings().display;
  }

  /**
   * Returns the InterfaceBlackboard.MapSettings (read-write)
   * @return The InterfaceBlackboard.MapSettings
   */
  gcc_const
  static inline MapSettings &SetMapSettings() {
    MY_ASSERT(InMainThread());

    return SetUISettings().map;
  }

  static inline const UIState &GetUIState() {
    MY_ASSERT(InMainThread());

    return Private::ui_state;
  }

  static inline UIState &SetUIState() {
    MY_ASSERT(InMainThread());

    return Private::ui_state;
  }

  static inline void ReadBlackboardBasic(const MoreData &nmea_info) {
    MY_ASSERT(InMainThread());

    Private::blackboard.ReadBlackboardBasic(nmea_info);
  }

  static inline void ReadBlackboardCalculated(const DerivedInfo &derived_info) {
    MY_ASSERT(InMainThread());

    Private::blackboard.ReadBlackboardCalculated(derived_info);
  }

  static inline void ReadCommonStats(const CommonStats &common_stats) {
    MY_ASSERT(InMainThread());

    Private::blackboard.ReadCommonStats(common_stats);
  }

  static inline void AddListener(BlackboardListener &listener) {
    MY_ASSERT(InMainThread());

    Private::blackboard.AddListener(listener);
  }

  static inline void RemoveListener(BlackboardListener &listener) {
    MY_ASSERT(InMainThread());

    Private::blackboard.RemoveListener(listener);
  }

  static inline void BroadcastGPSUpdate() {
    MY_ASSERT(InMainThread());

    Private::blackboard.BroadcastGPSUpdate();
  }

  static inline void BroadcastCalculatedUpdate() {
    MY_ASSERT(InMainThread());

    Private::blackboard.BroadcastCalculatedUpdate();
  }

  static inline void BroadcastComputerSettingsUpdate() {
    MY_ASSERT(InMainThread());

    Private::blackboard.BroadcastComputerSettingsUpdate();
  }

  static inline void BroadcastUISettingsUpdate() {
    MY_ASSERT(InMainThread());

    Private::blackboard.BroadcastUISettingsUpdate();
  }
};

#endif
