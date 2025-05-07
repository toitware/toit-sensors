# Generic sensor services
This package provides a set of generic sensor services that can be used to abstract
the underlying sensor implementation. Drivers implement these services, so that
their functionality can be accessed through Toit's RPC mechanism.

## Clients
Clients import this sensor package and then call the service's `client` method to
get a client object that implements that interface (assuming a provider is installed).

```toit
import sensors

main:
  client := sensors.TemperatureService
  print client.read
```


## Providers
Drivers implement the corresponding `Provider` classes. They can either
subclass the abstract classes (like `TemperatureProvider`) or implement
sensor-specific interfaces (like `TemperatureSensor`). The latter
approach allows drivers to provide more than one service. For example, the
BME280 driver implements both the `TemperatureSensor` and
`HumiditySensor` interfaces.

For simplicity, in the following example, we extend the `TemperatureProvider` class.
We also omit the lifetime management. See the [examples](examples) for
more complete examples.

```toit
import sensors.providers

class TemperatureProvider implements providers.TemperatureProvider:
  temperature-read -> float:
    return 25.0

install:
  provider := TemperatureProvider
  handler := TemperatureServiceHandler provider
  handler.install
```

Typically, providers are in a `provider` library (`provider.toit`) which is
located in the `src` directory of the driver's package.
