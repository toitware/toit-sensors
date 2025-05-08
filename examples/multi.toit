// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import sensors
import sensors.providers

/**
This example demonstrates how a sensor can provide multiple services
  at the same time. It implements a temperature and humidity sensor
*/

NAME ::= "toitware/sensors/example/temperature-humidity"
MAJOR ::= 1
MINOR ::= 0

class TemperatureHumiditySensor implements providers.HumiditySensor providers.TemperatureSensor:
  humidity-read -> float:
    return 499.0

  temperature-read -> float:
    return 42.0

start-provider:
  sensor/TemperatureHumiditySensor? := null
  count := 0
  open := ::
    if not sensor: sensor = TemperatureHumiditySensor
    count++
    sensor
  close := ::
    count--
    if count == 0:
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

  // Stop the spawned process after 1 second.
  sleep --ms=1000
  provider-humidity.uninstall
  provider-temperature.uninstall

main:
  // Spawn a new process that is independent of this one. No memory
  // is shared between the two processes.
  // Typically, the provider is in a different container and doesn't share
  // code with the client side.
  spawn:: start-provider
  // Give the spawned process time to run.
  yield
  client-humidity := sensors.HumidityService
  client-temperature := sensors.TemperatureService
  print "Humidity: $client-humidity.read"
  print "Temperature: $client-temperature.read"
  client-humidity.close
  client-temperature.close
