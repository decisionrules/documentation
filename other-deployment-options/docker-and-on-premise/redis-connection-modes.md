---
description: >-
  This document explains the three modes of connection available for connecting
  to Redis, controlled via the REDIS_MODE environment variable. The modes allow
  flexibility in connecting to single-instance
---

# Redis Connection Modes

## Overview

* `REDIS_MODE`: Defines the mode in which the application will connect to Redis.
* `READER_REDIS_URL` (optional): Specifies the connection URL for Redis reader instances, only applicable in NORMAL mode.

### Connection Modes

1. NORMAL Mode
2. NORMAL Mode with Reader Instances
3. CLUSTER Mode

#### 1. NORMAL Mode (Default)

In NORMAL mode, the application connects to a single Redis instance for both read and write operations.

* Environment Variables:
  * `REDIS_MODE`: Set to NORMAL to enable this mode.
  * `REDIS_URL`: Connection URL to the main Redis instance. This URL is used for all operations.
* Use Case:
  * Ideal for applications that don't require high availability for read operations or cannot be distributed across multiple Redis instances.

2\. NORMAL Mode with Reader Instances

In NORMAL mode with reader instances, the application connects to the main Redis instance for write operations while distributing read operations across dedicated reader instances specified by READER\_REDIS\_URL. This setup helps offload read operations from the main Redis instance, which can improve scalability and performance.

* Environment Variables:
  * `REDIS_MODE`: Set to NORMAL to enable this mode.
  * `REDIS_URL`: URL of the main Redis instance used for write operations.
  * `READER_REDIS_URL`: URL of the Redis reader instance(s) for read operations.
* Use Case:
  * Suitable for applications that need to balance the load by separating read and write operations across different Redis instances.

#### 3. CLUSTER Mode

In CLUSTER mode, the application connects to a Redis cluster, which is a distributed setup with multiple nodes. Each node in the cluster contains a subset of the data, allowing for high availability and scalability across nodes.

* Environment Variables:
  * `REDIS_MODE`: Set to CLUSTER to enable this mode.
  * `REDIS_URL`: URL for Redis configuration endpoind in the cluster. This allows the application to connect to any node within the Redis cluster, which then handles data distribution across all nodes in the setup.
* Use Case:
  * Recommended for applications that need high availability and scalability, with data distributed across multiple Redis nodes. This mode supports automatic failover and load balancing across nodes within the cluster.

## Example Configuration

Here's an example of environment variable settings for each mode:

### NORMAL Mode

`REDIS_MODE=NORMAL`

`REDIS_URL=redis://localhost:6379`

### NORMAL\_READER Mode

`REDIS_MODE=NORMAL`

`REDIS_URL=redis://write-instance:6379`

`READER_REDIS_URL=redis://reader-instance:6379`

### CLUSTER Mode:

`REDIS_MODE=CLUSTER`

`REDIS_CLUSTER_URL=redis://cluster-node-1:6379`

## Summary

The `REDIS_MODE` environment variable configures the mode of connection to Redis:

* **NORMAL:** Connects to a single Redis instance for all operations.
* **NORMAL with Reader Instances:** Connects to a single Redis instance for writes and distributes reads across one or more reader instances.
* **CLUSTER:** Connects to a Redis cluster, distributing data across multiple nodes for high availability and scalability.

Each mode offers distinct advantages depending on the application's needs for performance, scalability, and high availability.

\
