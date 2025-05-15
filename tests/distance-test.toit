// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *
import sensors.distance
import sensors.providers

NAME ::= "toitware/sensors/test/distance"
MAJOR ::= 1
MINOR ::= 0

class DistanceSensor implements providers.DistanceSensor-v1:
  distance-read -> int:
    return 499

  close -> none:
    // Do nothing.

main:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: DistanceSensor
      --close=:: it.close
      --handlers=[providers.DistanceHandler-v1]
  provider.install
  client := distance.v1
  expect-equals 499 client.read
  client.close
  provider.uninstall
