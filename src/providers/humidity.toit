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

  constructor name/string --sensor/HumiditySensor --major/int --minor/int --patch/int=0 --tags=null:
    return HumidityProvider_ name --sensor=sensor --major=major --minor=minor --patch=patch --tags=tags

  abstract humidity-read -> float

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX:
      return humidity-read
    unreachable

class HumidityProvider_ extends HumidityProvider:
  sensor/HumiditySensor
  constructor name/string --.sensor --major/int --minor/int --patch/int=0 --tags=null:
    super name --major=major --minor=minor --patch=patch --tags=tags

  humidity-read -> float:
    return sensor.humidity-read


