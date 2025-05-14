// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import sensors.providers

NAME ::= "toit.io/sensors/examples/humidity"
MAJOR ::= 1
MINOR ::= 0

class HumiditySensor implements providers.HumiditySensor-v1:
  humidity-read -> float:
    return 499.0

  close -> none:
    // Do nothing in this example.

install:
  provider := providers.Provider NAME
      --major=MAJOR
      --minor=MINOR
      --open=:: HumiditySensor
      --close=:: it.close
      --handlers=[providers.HumidityHandler-v1]
  provider.install
  return provider
