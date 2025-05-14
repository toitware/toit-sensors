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
  is-closed/bool := false

  close -> none:
    is-closed = true

  humidity-read -> float:
    return 499.0

  temperature-read -> float:
    return 42.0

main:
  sensor/TemperatureHumiditySensor? := null
  count := 0
  open := ::
    if not sensor: sensor = TemperatureHumiditySensor
    count++
    sensor
  close := ::
    count--
    if count == 0:
      sensor.close
      sensor = null
  provider-temperature := providers.TemperatureProvider NAME
      --major=MAJOR
      --minor=MINOR
      --open=open
      --close=close
  provider-humidity := providers.HumidityProvider NAME
      --major=MAJOR
      --minor=MINOR
      --open=open
      --close=close
  provider-temperature.install
  provider-humidity.install
  client-humidity := sensors.HumidityService
  expect-equals 499.0 client-humidity.read
  client-temperature := sensors.TemperatureService
  expect-equals 42.0 client-temperature.read
  client-humidity.close
  expect-not sensor.is-closed
  tmp-sensor := sensor
  expect-equals 42.0 client-temperature.read
  client-temperature.close
  expect-null sensor
  expect tmp-sensor.is-closed
  provider-humidity.uninstall
  provider-temperature.uninstall
