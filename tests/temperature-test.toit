// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/test/temperature"
MAJOR ::= 1
MINOR ::= 0

class TemperatureProvider extends providers.TemperatureProvider:
  constructor:
    super NAME --major=MAJOR --minor=MINOR

  temperature-read -> float:
    return 42.0

class TemperatureSensor implements providers.TemperatureSensor:
  temperature-read -> float:
    return 499.0

main:
  provider1 := TemperatureProvider
  provider1.install
  client := sensors.TemperatureService.client
  expect-equals 42.0 client.read
  client.close
  provider1.uninstall

  provider2 := providers.TemperatureProvider NAME
      --sensor=TemperatureSensor
      --major=MAJOR
      --minor=MINOR
  provider2.install
  client = sensors.TemperatureService.client
  expect-equals 499.0 client.read
  client.close
  provider2.uninstall
