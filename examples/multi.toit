// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import sensors.humidity
import sensors.providers
import sensors.temperature

/**
This example demonstrates how a sensor can provide multiple services
  at the same time. It implements a temperature and humidity sensor.
*/

NAME ::= "toit.io/sensors/example/temperature-humidity"
MAJOR ::= 1
MINOR ::= 0

class TemperatureHumiditySensor implements providers.HumiditySensor-v1 providers.TemperatureSensor-v1:
  humidity-read -> float:
    return 499.0

  temperature-read -> float:
    return 42.0

install -> providers.Provider:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: TemperatureHumiditySensor
      --close=:: it.close
      --handlers=[
        providers.HumidityHandler-v1,
        providers.TemperatureHandler-v1
      ]
  provider.install
  return provider

main:
  // Spawn a new process that is independent of this one. No memory
  // is shared between the two processes.
  // Typically, the provider is in a different container and doesn't share
  // code with the client side.
  spawn::
    provider := install
        // Stop the spawned process after 1 second.
    sleep --ms=1000
    provider.uninstall

  // Give the spawned process time to run.
  yield
  client-humidity := humidity.v1
  client-temperature := temperature.v1
  print "Humidity: $client-humidity.read"
  print "Temperature: $client-temperature.read"
  client-humidity.close
  client-temperature.close
