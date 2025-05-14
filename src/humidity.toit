// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import .clients.humidity as clients

/**
Opens a new client for the humidity service.
Requires that a HumidityProvider is installed.
*/
v1 -> HumidityService-v1: return (clients.HumidityService-v1).open as any

/**
A service that provides humidity readings.
*/
interface HumidityService-v1:
  /**
  Reads the humidity in percentage.
  */
  read -> float

  /**
  Closes the service.
  */
  close -> none
