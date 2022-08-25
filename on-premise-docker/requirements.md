# Minimal Requirements

## DecisionRules Minimal Requirements

### Software requirements

| Software       | OS                                |
| -------------- | --------------------------------- |
| Docker Desktop | Windows 8.1/10/11 (WSL 2 enabled) |
|                | macOS                             |
| Docker engine  | Linux                             |

### Minimum hardware requirements of containers

Ideal secure production minimum setup for server is 1GB total for the OS including up to 2x300MB for two workers/threads. For single thread is best secure production option **0,7GB including 300MB for 1 worker**.

| Container                 | Min. RAM mem.                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| MongoDB                   | 190MB                                                                                                                     |
| Redis                     | [Official Redis requirements](https://docs.redis.com/latest/rs/administering/designing-production/hardware-requirements/) |
| Client App                | 100MB                                                                                                                     |
| Server App                | 300MB per worker thread + 400MB for OS                                                                                    |
| Business Intelligence App | 300MB per worker thread + 400MB for OS                                                                                    |
