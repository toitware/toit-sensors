// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import .clients.pressure as clients

/**
Opens a new client for the pressure service.
Requires that a PressureProvider is installed.
*/
v1 -> PressureService-v1: return (clients.PressureService-v1).open as any

/**
A service that provides pressure readings.
*/
interface PressureService-v1:
  /**
  Reads the pressure in Pascal

  Returns null if the pressure could not be read or is out of range.
  */
  read -> float?

  /**
  Closes the service.
  */
  close -> none
