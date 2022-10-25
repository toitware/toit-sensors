// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as api

class TemperatureService
    extends services.ServiceClient
    implements api.TemperatureService:
  constructor --open/bool=true:
    super --open=open

  open -> TemperatureService?:
    client := open_
        api.TemperatureService.UUID
        api.TemperatureService.MAJOR
        api.TemperatureService.MINOR
    return client and this

  read -> float:
    return invoke_
        api.TemperatureService.READ_INDEX
        null
