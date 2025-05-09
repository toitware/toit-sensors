# Generic sensor services
This package provides a set of generic sensor services that can be used to abstract
the underlying sensor implementation. Drivers implement these services, so that
their functionality can be accessed through Toit's RPC mechanism.

## Clients
Clients import this sensor package and then call the service's `client` method to
get a client object that implements that interface (assuming a provider is installed).

```toit
import sensors.temperature

main:
  // Some sensors might have multiple versions of the same service.
  // Each version has a getter to create the corresponding client.
  client := temperature.v1
  print client.read
```


## Providers
Drivers provide the corresponding providers. They implement
sensor-specific interfaces (like `TemperatureSensor-v1`). Each interface is
versioned, so that the package can evolve in the future.

Drivers can implement multiple interfaces. For example, the `BME280` driver implements
the `TemperatureSensor` and `HumiditySensor` interfaces.

### Example
The following example demonstrates how to implement a provider for the
`TemperatureSensor-v1` interface.

```toit
import sensors.providers

class TemperatureSensor implements providers.TemperatureSensor-v1:
  // API functions are always prefixed with the sensor's category, so that
  // drivers can implement multiple interfaces without name clashes.
  temperature-read -> float:
    return 25.0

  close:
    // Do nothing in this example.

install:
  provider := providers.Provider "toit.io/sensors/temperature"
      --major=1
      --minor=0
      --open=:: TemperatureSensor  // Create a new instance.
      --close=:: it.close
      --handlers=[providers.TemperatureHandler-v1]
  handler.install
```
