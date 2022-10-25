// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import .clients.temperature as clients

interface TemperatureService:
  static UUID/string ::= "81d183f5-6e73-403e-a3cc-9baf13b391d4"
  static MAJOR/int ::= 1
  static MINOR/int ::= 0

  read -> float
  static READ_INDEX ::= 0

  static client -> TemperatureService:
    return clients.TemperatureService
