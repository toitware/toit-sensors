// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/test/humidity"
MAJOR ::= 1
MINOR ::= 0

class HumidityProvider extends providers.HumidityProvider:
  constructor:
    super NAME --major=MAJOR --minor=MINOR

  humidity-read -> float:
    return 42.0

class HumiditySensor implements providers.HumiditySensor:
  humidity-read -> float:
    return 499.0

main:
  provider1 := HumidityProvider
  provider1.install
  client := sensors.HumidityService
  expect-equals 42.0 client.read
  client.close
  provider1.uninstall

  provider2 := providers.HumidityProvider NAME
      --sensor=(HumiditySensor)
      --major=MAJOR
      --minor=MINOR
  provider2.install
  client = sensors.HumidityService
  expect-equals 499.0 client.read
  client.close
  provider2.uninstall
