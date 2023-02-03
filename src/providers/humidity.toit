// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..humidity as api

interface HumidityProvider:
  humidity_read -> float

class TemperatureServiceHandler implements services.ServiceHandler:
  provider/HumidityProvider
  constructor .provider:

  handle pid/int client/int index/int arguments/any -> any:
    if index == api.HumidityService.READ_INDEX:
      return provider.humidity_read
    unreachable
