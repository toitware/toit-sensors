// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as api

interface TemperatureProvider:
  temperature-read -> float

class TemperatureServiceHandler implements services.ServiceHandler:
  provider/TemperatureProvider
  constructor .provider:

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.TemperatureService.READ-INDEX:
      return provider.temperature-read
    unreachable
