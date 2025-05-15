// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import .handler-base_
import ..apis.pressure as api

interface PressureSensor-v1:
  pressure-read -> float?

class PressureHandler-v1 extends Handler_:
  selector -> services.ServiceSelector: return api.SELECTOR-v1

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX-v1:
      return (sensor_ as PressureSensor-v1).pressure-read
    unreachable
