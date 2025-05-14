// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

abstract class Handler_ implements services.ServiceHandler:
  sensor_/any := null

  abstract selector -> services.ServiceSelector
  abstract handle index/int arguments/any --gid/int --client/int -> any
