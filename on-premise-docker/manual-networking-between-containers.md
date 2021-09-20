# Manual networking between containers

If you don't want to use a docker-compose file for whatever reason you can create networking between containers manually.

{% hint style="warning" %}
This can be achieved only on the same network!
{% endhint %}

### How to setup multi-container app

What containers will we need:

1. Server App
2. Client App
3. Redis
4. MongoDB

### Setup

First of all, we need to create a docker network because containers, by default, don't see other containers thus they cannot communicate with each other. We will use a simple command `docker network create`

{% hint style="danger" %}
```Note: If you are using PowerShell on Windows you need to use `` for multi-line command!```
{% endhint %}

```text
// creating docker network space
docker network create <network_name>

// if you want to remove network
docker network remove <network_name>
```

In the second step, we need to run all mandatory containers mentioned above. We will do it with the help of `docker run` . In this command, we will set ports and env variables as well.

```text
// create mongoDB docker container
docker run -dp 27017:27017 --network decisionrules mongo
```

```text
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
docker run -d -p 8080:8080 -p 8081:8081 --network decisionrules \
-e WORKERS_NUMBER=1 \
-e REDIS_URL=redis://host.docker.internal:6379 \
-e SOLVER_REDIS_URL=redis://host.docker.internal:6379 \
-e MONGO_DB_URI=mongodb://host.docker.internal:27017 \
-e CLIENT_URL=http://localhost:80/#/ \
-e LICENSE_KEY=YOUR_LICENSE_KEY \
-v license:/assets/lic/ decisionrules/server
```

{% hint style="warning" %}
Your env properties configuration may vary. For all possibilities go [here](containers-environmental-variables.md)
{% endhint %}

```text
// creating decisionrules client container
docker run -dp 80:80 --network decisionrules \
-e API_URL=http://localhost:8080 decisionrules/client
```

{% hint style="success" %}
**Hurray! It is done. Now you can go to localhost:80 a DecisionRules should be up and running.**
{% endhint %}

