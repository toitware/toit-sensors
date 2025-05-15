// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services

import .distance
import .handler-base_
import .humidity
import .pressure
import .temperature

export *

class Provider extends services.ServiceProvider:
  handlers_/List
  count_/int := 0
  open_/Lambda
  close_/Lambda

  constructor name/string
      --major/int
      --minor/int
      --patch/int=0
      --tags=null
      --open/Lambda
      --close/Lambda
      --handlers/List:
    handlers_ = handlers
    open_ = open
    close_ = close
    super name --major=major --minor=minor --patch=patch --tags=tags
    handlers.do: | handler/Handler_ |
      provides handler.selector --handler=handler

  on-opened client/int -> none:
    super client
    if count_ == 0:
      sensor := open_.call
      handlers_.do: | handler/Handler_ |
        handler.sensor_ = sensor
    count_++

  on-closed client/int -> none:
    count_--
    if count_ == 0:
      sensor := null
      handlers_.do: | handler/Handler_ |
        sensor = handler.sensor_
        handler.sensor_ = null
      close_.call sensor
