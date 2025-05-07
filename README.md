# Generic sensor services

This package provides a set of generic sensor services that can be used to abstract
the underlying sensor implementation. Drivers implement these services, so that
their functionality can be accessed through Toit's RPC mechanism.

## Clients

Clients import this sensor package and then call the service's `client` method to
get a client object that implements that interface (assuming a driver is installed).

```toit
import sensors

main:
  client := TemperatureInterface.client
  print client.read
```


## Providers

Drivers provide services by implementing the provider's interfaces. For
example, the `TemperatureProvider` interfaces has a `temperature-read` method.

The provider implementations of this package take such implementations and
expose them as RPC services:

```toit
import sensors.providers

class TemperatureProvider implements providers.TemperatureProvider:
  temperature->read -> float:
    // Implementation of the temperature reading
    return 25.0

install:
  provider := TemperatureProvider
  handler := TemperatureServiceHandler provider
  handler.install
```

Typically, this library is called `provider` and lives in the `src` directory of
the driver's package.
