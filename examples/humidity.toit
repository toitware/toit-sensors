// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/examples/humidity"
MAJOR ::= 1
MINOR ::= 0

class HumidityProvider extends providers.HumidityProvider:
  // A ref-count of the number of clients that are using this provider.
  count_/int := 0
  // For this example we simulate a sensor by using a simple float.
  // In a real implementation this would a sensor object that communicates with
  // the hardware.
  sensor_/float? := null

  constructor:
    super NAME --major=MAJOR --minor=MINOR

  humidity-read -> float:
    return 42.0

  on-opened client/int -> none:
    super client
    if count_++ == 0:
      // This is the first client to open the provider.
      // We need to start the sensor.
      sensor_ = 42.0

  on-closed client/int -> none:
    super client
    count_--
    if count_ == 0:
      // This is the last client to close the provider.
      // We need to stop the sensor.
      sensor_ = null

main:
  // Spawn a new process that is independent of this one. No memory
  // is shared between the two processes.
  // Typically, the provider is in a different container and doesn't share
  // code with the client side.
  spawn::
    provider1 := HumidityProvider
    provider1.install
    sleep --ms=1000
    provider1.uninstall
  yield  // Give the spawned process time to run.
  client := sensors.HumidityService
  print client.read
  client.close
