// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as api

abstract class TemperatureService
    extends services.ServiceDefinition:
  constructor name/string --major/int --minor/int --patch/int=0:
    super name
        --major=major
        --minor=minor
        --patch=patch
    provides
        api.TemperatureService.UUID
        api.TemperatureService.MAJOR
        api.TemperatureService.MINOR

  handle pid/int client/int index/int arguments/any -> any:
    if index == api.TemperatureService.READ_INDEX:
      return read
    unreachable

  abstract read -> float
