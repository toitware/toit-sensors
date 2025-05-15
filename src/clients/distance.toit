// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..distance as client
import ..apis.distance as api

class DistanceService-v1 extends services.ServiceClient implements client.DistanceService-v1:
  static SELECTOR ::= api.SELECTOR-v1
  constructor selector/services.ServiceSelector=SELECTOR:
    assert: selector.matches SELECTOR
    super selector

  read -> int?:
    return invoke_ api.READ-INDEX-v1 null
