// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors.pressure
import sensors.providers

NAME ::= "toitware/sensors/test/pressure"
MAJOR ::= 1
MINOR ::= 0

class PressureSensor implements providers.PressureSensor-v1:
  pressure-read -> float?:
    return 499.0

  close -> none:
    // Do nothing.

main:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: PressureSensor
      --close=:: it.close
      --handlers=[providers.PressureHandler-v1]
  provider.install
  client := pressure.v1
  expect-equals 499.0 client.read
  client.close
  provider.uninstall
