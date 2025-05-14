// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors.temperature
import sensors.providers

NAME ::= "toitware/sensors/test/temperature"
MAJOR ::= 1
MINOR ::= 0

class TemperatureSensor implements providers.TemperatureSensor-v1:
  is-closed/bool := false
  should-return-null/bool := false

  temperature-read -> float?:
    if should-return-null: return null
    return 499.0

  close -> none:
    is-closed = true

main:
  sensor/TemperatureSensor? := null
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=::
        sensor = TemperatureSensor
        sensor
      --close=::
        it.close
        sensor = null
      --handlers=[providers.TemperatureHandler-v1]
  provider.install
  expect-null sensor
  client := temperature.v1
  expect-not-null sensor
  expect-not sensor.is-closed
  expect-equals 499.0 client.read
  tmp := sensor
  client.close
  expect-null sensor
  expect tmp.is-closed
  client = temperature.v1
  expect-not-null sensor
  expect-not sensor.is-closed
  expect-equals 499.0 client.read
  sensor.should-return-null = true
  expect-null client.read
  tmp = sensor
  client.close
  expect-null sensor
  expect tmp.is-closed
  provider.uninstall
