// Copyright (C) 2022 Kasper Lund.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

import .clients.humidity as clients

interface HumidityService:
  static SELECTOR ::= services.ServiceSelector
      --uuid="6e8ad988-ea25-4e65-bca3-3e3ee1762b85"
      --major=1
      --minor=0

  read -> float
  static READ_INDEX ::= 0

  static client -> HumidityService:
    return (clients.HumidityService).open as any
