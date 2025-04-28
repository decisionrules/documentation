# Minimal Requirements

## DecisionRules Minimal Requirements

### Software Requirements

| Software       | OS                                |
| -------------- | --------------------------------- |
| Docker Desktop | Windows 8.1/10/11 (WSL 2 enabled) |
|                | macOS                             |
| Docker engine  | Linux                             |

### Hardware Requirements

The minimum required server memory is 1GB in total for the OS and a single worker.

| Container                 | Minimum memory size                                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| MongoDB                   | 190MB                                                                                                                     |
| Redis                     | [Official Redis requirements](https://docs.redis.com/latest/rs/administering/designing-production/hardware-requirements/) |
| Client App                | 100MB                                                                                                                     |
| Server App                | 1GB per worker thread                                                                                                     |
| Business Intelligence App | 700MB per worker thread                                                                                                   |
