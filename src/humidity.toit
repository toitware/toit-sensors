// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

import .clients.humidity as clients

SELECTOR ::= services.ServiceSelector
    --uuid="6e8ad988-ea25-4e65-bca3-3e3ee1762b85"
    --major=1
    --minor=0

READ-INDEX ::= 0

interface HumidityService:
  constructor:
    return (clients.HumidityService).open as any

  read -> float
  close -> none
