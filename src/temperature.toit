// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

import .clients.temperature as clients

/**
Opens a new client for the temperature service.

Requires that a TemperatureProvider is installed.
*/
v1 -> TemperatureService-v1: return (clients.TemperatureService).open as any

/**
A service that provides temperature readings.
*/
interface TemperatureService-v1:
  /**
  Reads the temperature in Celsius.

  Returns null if the value is not available. Typically, this means that the
    temperature is out of range.

  Use the following formula to convert from Celsius to Fahrenheit:
  ```
  fahrenheit := (celsius * (9.0 / 5.0)) + 32.0
  ```
  */
  read -> float?

  /**
  Closes the service.
  */
  close -> none
