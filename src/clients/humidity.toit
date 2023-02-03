// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..humidity as api

class HumidityService extends services.ServiceClient implements api.HumidityService:
  static SELECTOR ::= api.HumidityService.SELECTOR
  constructor selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  read -> float:
    return invoke_ api.HumidityService.READ_INDEX null
