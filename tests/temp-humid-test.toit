// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/test/temperature-humidity"
MAJOR ::= 1
MINOR ::= 0

class TemperatureHumiditySensor implements providers.HumiditySensor providers.TemperatureSensor:
  humidity-read -> float:
    return 499.0

  temperature-read -> float:
    return 42.0

main:
  sensor := TemperatureHumiditySensor
  provider-temperature := providers.TemperatureProvider NAME
      --sensor=sensor
      --major=MAJOR
      --minor=MINOR
  provider-temperature.install
  provider-humidity := providers.HumidityProvider NAME
      --sensor=sensor
      --major=MAJOR
      --minor=MINOR
  provider-humidity.install
  client-humidity := sensors.HumidityService
  expect-equals 499.0 client-humidity.read
  client-temperature := sensors.TemperatureService
  expect-equals 42.0 client-temperature.read
  client-humidity.close
  client-temperature.close
  provider-humidity.uninstall
  provider-temperature.uninstall
