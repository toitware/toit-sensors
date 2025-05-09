// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors.humidity
import sensors.providers
import sensors.temperature

NAME ::= "toitware/sensors/test/temperature-humidity"
MAJOR ::= 1
MINOR ::= 0

class TemperatureHumiditySensor implements providers.HumiditySensor-v1 providers.TemperatureSensor-v1:
  is-closed/bool := false

  close -> none:
    is-closed = true

  humidity-read -> float:
    return 499.0

  temperature-read -> float:
    return 42.0

main:
  sensor/TemperatureHumiditySensor? := null
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=::
        sensor = TemperatureHumiditySensor
        sensor
      --close=::
        it.close
        sensor = null
      --handlers=[
        providers.HumidityHandler-v1,
        providers.TemperatureHandler-v1
      ]
  provider.install
  expect-null sensor
  client-humidity := humidity.v1
  expect-not-null sensor
  expect-equals 499.0 client-humidity.read
  client-temperature := temperature.v1
  expect-equals 42.0 client-temperature.read
  client-humidity.close
  expect-not sensor.is-closed
  tmp-sensor := sensor
  expect-equals 42.0 client-temperature.read
  client-temperature.close
  expect-null sensor
  expect tmp-sensor.is-closed
  provider.uninstall
