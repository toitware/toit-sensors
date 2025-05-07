// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..humidity as api

interface HumidityProvider:
  humidity-read -> float

class TemperatureServiceHandler implements services.ServiceHandler:
  provider/HumidityProvider
  constructor .provider:

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.HumidityService.READ-INDEX:
      return provider.humidity-read
    unreachable
