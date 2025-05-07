// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

import .clients.temperature as clients

interface TemperatureService:
  static SELECTOR ::= services.ServiceSelector
      --uuid="81d183f5-6e73-403e-a3cc-9baf13b391d4"
      --major=1
      --minor=0

  read -> float
  static READ_INDEX ::= 0

  static client -> TemperatureService:
    return (clients.TemperatureService).open as any
