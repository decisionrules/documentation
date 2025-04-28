# DecisionRules Client

{% hint style="success" %}
Production Container
{% endhint %}

Download the latest DecisionRules client container that provides front-end applications with maintenance and regular updates.

## Container types

{% hint style="info" %}
Since version 1.15.0 it is possible to choose whether the container will run with root user or non-root user.
{% endhint %}

* **Standard** (root user) container listen default on **port 80.**
* **Rootless** (non-root user) container are tagged with the suffix -rootless. Container listen default on **port 4000.**

## How to start the DecisionRules Client

The server can only be started with the set env. variables that are necessary for operation.

### Method 1: Pulling and running the Docker container in the terminal

The client can be started using the simple docker run command. If you don't have the container downloaded yet, you can pull it using the docker pull command.

```
//pull container
docker pull decisionrules/client
//run container alone
docker run -d -p 80:80 -e API_URL=YOUR_API_URL decisionrules/client
```

### Method 2: Creating your own docker-compose file

If you don't want to use too much terminal you can create your own docker-compose file. The file type is YAML.

```yaml
version: "1.0"

services:
    server:
        image: decisionrules/client
        environment:
            - "API_URL=YOUR_API_URL"
        ports:
            - "80:80"
```

{% hint style="info" %}
Docker compose files are started with docker compose up command.
{% endhint %}
