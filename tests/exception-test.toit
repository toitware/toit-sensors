// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors.temperature
import sensors.providers

NAME ::= "toitware/sensors/test/exception"
MAJOR ::= 1
MINOR ::= 0

EXCEPTION ::= "exception in temperature-read"

class TemperatureSensor implements providers.TemperatureSensor-v1:
  is-closed/bool := false

  temperature-read -> float?:
    throw EXCEPTION

  close -> none:
    is-closed = true

main:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: TemperatureSensor
      --close=:: it.close
      --handlers=[providers.TemperatureHandler-v1]
  provider.install
  client := temperature.v1
  expect-throw EXCEPTION: client.read
  client.close
  provider.uninstall
