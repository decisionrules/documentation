# Server App

{% hint style="success" %}
Production Container
{% endhint %}

Download the latest [DecisionRules server container](https://hub.docker.com/r/decisionrules/server) that provides all the backend functionalities with maintenance and regular updates. The server requires [Redis Cache](https://redis.io/) and [MongoDB](https://www.mongodb.com/).

## How to start Server App

The server can only be started with the set of env. variables that are necessary for operation.

### Method 1: Pulling and running the Docker container in the terminal

The server can be started using a simple `docker run` command. If you don't have the container downloaded yet, you can pull it using the docker pull command.

```text
//pull container
docker pull decisionrules/server
//run container alone
docker run -d -p 8080:8080 -p 8081:8081
-e SHOWCASE=false
-e WORKERS_NUMBER=1
-e REDIS_URL=YOUR_REDIS_URL
-e SOLVER_REDIS_URL=YOUR_REDIS_SOLVER_URL
-e MONGO_DB_URI=YOUR_MONGODB_URL
-e CLIENT_URL=http://localhost:80/#/
-e LICENSE_KEY=YOUR_LICENSE_KEY
-v license:/assets/lic/ decisionrules/server
```

{% hint style="info" %}
Some env. variables can be omitted. For full list of env. variables see [here](containers-environmental-variables.md).
{% endhint %}

### Method 2: Creating your own docker-compose file

If you don't want to use too much terminal you can create your own docker-compose file. The file type is YAML.

```yaml
version: "1.0"

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
        volumes:
            - license:/assets/lic/:rw
volumes:
    license:
        driver: local
```

{% hint style="info" %}
Docker compose files are started with `docker compose up` command.
{% endhint %}
