// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..humidity as client
import ..apis.humidity as api

class HumidityService-v1 extends services.ServiceClient implements client.HumidityService-v1:
  static SELECTOR ::= api.SELECTOR-v1
  constructor selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  read -> float:
    return invoke_ api.READ-INDEX-v1 null
