// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import expect show *
import sensors
import sensors.providers

NAME ::= "toitware/sensors/examples/humidity"
MAJOR ::= 1
MINOR ::= 0

class HumiditySensor implements providers.HumiditySensor:
  is-closed/bool := false

  humidity-read -> float:
    return 499.0

  close -> none:
    is-closed = true

install:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: HumiditySensor
      --close=:: it.close
      --handlers=[providers.HumidityHandler]
  provider.install
  return provider

main:
  // Spawn a new process that is independent of this one. No memory
  // is shared between the two processes.
  // Typically, the provider is in a different container and doesn't share
  // code with the client side.
  spawn::
    provider := install
    sleep --ms=1000
    provider.uninstall
  yield  // Give the spawned process time to run.
  client := sensors.HumidityService
  print client.read
  client.close
