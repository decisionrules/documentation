---
description: >-
  You can find here how to set up the Redis on Azure for working with
  DecisionRules.
---

# Redis / Azure Cache for Redis

## Creating Redis

### Basics

* **Resource group:** same as used for DecisionRules WebApp
* **DNS name:** any
* **Location:** same as used for DecisionRules WebApp
* **Cache type:** minimal 1 GB

### Networking

* **Connectivity method:** any

### Advanced

* **Non-TLS port:** any
* **Redis version:** 6

## Setting Redis

### Settings -> Advanced settings

* **Maxmemory policy:** allkeys-lru / allkeys-lfu

## Connecting string for Environmental Variables

### SSL

#### Format

`rediss://:<access_key>@<hostname>:<port>`

#### Example

`rediss://:asdsadsadsadsa@test-redis.redis.cache.windows.net:6380`

#### Where to find an access\_key

* Settings -> Access keys -> Primary / Secondary

#### Where to find a hostname

* Settings -> Properties -> Host name

#### Where to find a port

* Settings -> Properties -> SSL Port

### Non-SSL

#### Format

`redis://:<access_key>@<hostname>:<port>`

#### Example

`redis://:asdsadsadsadsa@test-redis.redis.cache.windows.net:6379`

#### Where to find an access\_key

* Settings -> Access keys -> Primary / Secondary

#### Where to find a hostname

* Settings -> Properties -> Host name

#### Where to find a port

* Settings -> Properties -> Non-SSL Port





