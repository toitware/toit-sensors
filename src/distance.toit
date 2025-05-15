// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import .clients.distance as clients

/**
Opens a new client for the distance service.
Requires that a DistanceProvider is installed.
*/
v1 -> DistanceService-v1: return (clients.DistanceService-v1).open as any

/**
A service that provides distance readings.
*/
interface DistanceService-v1:
  /**
  Reads the distance in millimeters.

  Returns null if the distance could not be read or is out of range.
  */
  read -> int?

  /**
  Closes the service.
  */
  close -> none
