// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as api

class TemperatureService extends services.ServiceClient implements api.TemperatureService:
  static SELECTOR ::= api.TemperatureService.SELECTOR
  constructor selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  read -> float:
    return invoke_ api.TemperatureService.READ_INDEX null
