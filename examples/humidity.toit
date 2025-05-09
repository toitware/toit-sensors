// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the examples/LICENSE file.

import .humidity-client as client
import .humidity-provider

/**
An example that groups a humidity provider and client.
Frequently the provider and client don't run in the same container, and aren't written
  by the same team.
*/

main:
  // Spawn a new process that is independent of this one. No memory
  // is shared between the two processes.
  // Typically, the provider is in a different container and doesn't share
  // code with the client side.
  spawn::
    provider := install
    sleep --ms=1000
    provider.uninstall

  yield  // Give the spawned process time to run.
  client.main
