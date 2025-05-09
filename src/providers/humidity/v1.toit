// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..handler-base_
import ...humidity.v1 as api

interface HumiditySensor:
  humidity-read -> float

class HumidityHandler extends Handler_:
  selector -> services.ServiceSelector: return api.SELECTOR

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX:
      return (sensor_ as HumiditySensor).humidity-read
    unreachable
