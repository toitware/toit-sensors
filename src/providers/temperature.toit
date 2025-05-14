// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..temperature as api

interface TemperatureSensor:
  temperature-read -> float

abstract class TemperatureProvider extends services.ServiceProvider implements services.ServiceHandler:
  constructor name/string --major/int --minor/int --patch/int=0 --tags=null:
    super name --major=major --minor=minor --patch=patch --tags=tags
    provides api.SELECTOR --handler=this

  constructor name/string --open/Lambda --close/Lambda --major/int --minor/int --patch/int=0 --tags=null:
    return TemperatureProvider_ name --open=open --close=close --major=major --minor=minor --patch=patch --tags=tags

  abstract temperature-read -> float

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX:
      return temperature-read
    unreachable

class TemperatureProvider_ extends TemperatureProvider:
  sensor_/TemperatureSensor? := null
  open_/Lambda
  close_/Lambda
  count_/int := 0

  constructor name/string --open/Lambda --close/Lambda --major/int --minor/int --patch/int=0 --tags=null:
    open_ = open
    close_ = close
    super name --major=major --minor=minor --patch=patch --tags=tags

  on-opened client/int -> none:
    super client
    if count_ == 0:
      sensor_ = open_.call
    count_++

  on-closed client/int -> none:
    count_--
    if count_ == 0:
      close_.call sensor_
      sensor_ = null

  temperature-read -> float:
    return sensor_.temperature-read
