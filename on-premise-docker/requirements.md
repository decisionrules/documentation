# Requirements

### Software requirements

| Software       | OS                          |
| -------------- | --------------------------- |
| Docker Desktop | Windows 8.1 (WSL 2 enabled) |
|                | Windows 10 (WSL 2 enabled)  |
|                | macOS                       |
| Docker engine  | Linux                       |

### Minimum hardware requirements of containers

Ideal secure production minimum setup is 1GB total for the OS including up to 2x300MB for two workers/threads. For single thread is best secure production option **0,7GB including 300MB for 1 worker**.

| Container  | Min. RAM mem.                       |
| ---------- | ----------------------------------- |
| mongoDB    | 190MB                               |
| redis      | 8MB                                 |
| Client App | 9MB (not including OS)              |
| Server App | 300MB per thread (not including OS) |
