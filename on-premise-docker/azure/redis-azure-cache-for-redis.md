---
description: >-
  You can find here how to set up the Redis on Azure for working with
  DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Redis / Azure Cache for Redis

## How to connect DecisionRules to Azure Redis Cache for Redis&#x20;

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

{% hint style="info" %}
Some types of Azure Cache for Redis tend to shut themselves down after a period of inactivity. To prevent this, we recommend setting the REDIS\_PING\_INTERVAL optional Environment Variable.
{% endhint %}



