// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import system.services
import ..humidity as api

interface HumiditySensor:
  humidity-read -> float

abstract class HumidityProvider extends services.ServiceProvider implements services.ServiceHandler:
  constructor name/string --major/int --minor/int --patch/int=0 --tags=null:
    super name --major=major --minor=minor --patch=patch --tags=tags
    provides api.SELECTOR --handler=this

  constructor name/string --open/Lambda --close/Lambda --major/int --minor/int --patch/int=0 --tags=null:
    return HumidityProvider_ name --open=open --close=close --major=major --minor=minor --patch=patch --tags=tags

  abstract humidity-read -> float

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX:
      return humidity-read
    unreachable

class HumidityProvider_ extends HumidityProvider:
  sensor_/HumiditySensor? := null
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
  humidity-read -> float:
    return sensor_.humidity-read
