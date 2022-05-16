# Networking Between Containers in Docker

If you don't want to use a docker-compose file for whatever reason you can create networking between containers manually.

{% hint style="info" %}
This can be achieved only on the same network!
{% endhint %}

## How to set networking for DecisionRules in docker

## How to setup multi-container app

What containers will we need:

1. Server App
2. Client App
3. Redis
4. MongoDB

### Method 1: Setup with terminal

First of all, we need to create a docker network because containers, by default, don't see other containers thus they cannot communicate with each other. We will use a simple command `docker network create`

{% hint style="danger" %}
`Note: If you are using PowerShell on Windows you need to use `` for multi-line command!`
{% endhint %}

```
// creating docker network space
docker network create <network_name>

// if you want to remove network
docker network remove <network_name>
```

In the second step, we need to run all mandatory containers mentioned above. We will do it with the help of `docker run` . In this command, we will set ports and env variables as well.

```
// create mongoDB docker container
docker run -dp 27017:27017 --network decisionrules mongo
```

```
// create redis docker container
docker run -dp 6379:6379 --network decisionrules redis
```

{% hint style="success" %}
If the command is successful it prints containers id
{% endhint %}

{% hint style="info" %}
`-d` flags that can be interpreted as`-d -p`which is a detached mode with exposed ports. Detached mode means that the container runs in the background and grimly does its work.
{% endhint %}

```bash
// creating decisionrules server container
docker run -d -p 8080:8080 -p 8081:8081 
--network decisionrules
-e SHOWCASE=false
-e WORKERS_NUMBER=1
-e REDIS_URL=YOUR_REDIS_URL
-e SOLVER_REDIS_URL=YOUR_REDIS_SOLVER_URL
-e MONGO_DB_URI=YOUR_MONGODB_URL
-e CLIENT_URL=YOUR_CLIENT_URL
-e LICENSE_KEY=YOUR_LICENSE_KEY
-v license:/assets/lic/ decisionrules/server
```

{% hint style="warning" %}
Your env properties configuration may vary. For all possibilities go [here](containers-environmental-variables.md)
{% endhint %}

```
// creating decisionrules client container
docker run -dp 80:80 --network decisionrules -e API_URL=YOUR_CLIENT_URL decisionrules/client
```

{% hint style="success" %}
**Hurray! It is done. Now you can go to localhost:80 a DecisionRules should be up and running.**
{% endhint %}

### **Method 2: Setup with docker-compose file**

**You can use docker-compose for a very easy setup.**

```yaml
version: "3.7"

services:
  server:
    image: decisionrules/server
    environment:
      - "SHOWCASE=false"
      - "REDIS_URL=YOUR_REDIS_URL"
      - "SOLVER_REDIS_URL=YOUR_REDIS_SOLVER_URL"
      - "MONGO_DB_URI=YOUR_MONGO_URI"
      - "CLIENT_URL=YOUR_CLIENT_URL"
      - "LICENSE_KEY=YOUR_LICENSE_KEY"
    ports:
      - "8080:8080"
      - "8081:8081"
    links:
      - mongoDb
      - redis
  client:
    image: decisionrules/client
    environment:
      - "API_URL=YOUR_API_URL"
    ports:
    - "80:80"

  mongoDb:
    image: mongo
    ports:
      - "27017:27017"

  redis:
    image: redis
    ports:
      - "6379:6379"
```

{% hint style="info" %}
Run docker-compose with `docker compose up` command
{% endhint %}
