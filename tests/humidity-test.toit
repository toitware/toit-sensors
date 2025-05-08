// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/test/humidity"
MAJOR ::= 1
MINOR ::= 0

class HumiditySensor implements providers.HumiditySensor:
  is-closed/bool := false

  humidity-read -> float:
    return 499.0

  close -> none:
    is-closed = true

main:
  sensor/HumiditySensor? := null
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=::
        sensor = HumiditySensor
        sensor
      --close=::
        it.close
        sensor = null
      --handlers=[providers.HumidityHandler]
  provider.install
  expect-null sensor
  client := sensors.HumidityService
  expect-not-null sensor
  expect-not sensor.is-closed
  expect-equals 499.0 client.read
  tmp := sensor
  client.close
  expect-null sensor
  expect tmp.is-closed
  client = sensors.HumidityService
  expect-not-null sensor
  expect-not sensor.is-closed
  expect-equals 499.0 client.read
  tmp = sensor
  client.close
  expect-null sensor
  expect tmp.is-closed
  provider.uninstall
