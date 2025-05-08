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

  constructor name/string --sensor/TemperatureSensor --major/int --minor/int --patch/int=0 --tags=null:
    return TemperatureProvider_ name --sensor=sensor --major=major --minor=minor --patch=patch --tags=tags

  abstract temperature-read -> float

  handle index/int arguments/any --gid/int --client/int -> any:
    if index == api.READ-INDEX:
      return temperature-read
    unreachable

class TemperatureProvider_ extends TemperatureProvider:
  sensor/TemperatureSensor
  constructor name/string --.sensor --major/int --minor/int --patch/int=0 --tags=null:
    super name --major=major --minor=minor --patch=patch --tags=tags

  temperature-read -> float:
    return sensor.temperature-read
