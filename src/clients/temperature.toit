// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as client
import ..apis.temperature as api

class TemperatureService extends services.ServiceClient implements client.TemperatureService-v1:
  static SELECTOR ::= api.SELECTOR-v1
  constructor selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  read -> float:
    return invoke_ api.READ-INDEX-v1 null
