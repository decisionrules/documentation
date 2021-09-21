# Client App

{% hint style="success" %}
Production Container
{% endhint %}

Download the latest DecisionRules client container that provides front-end applications with maintenance and regular updates.

## How to start Server App

The server can only be started with the set env. variables that are necessary for operation.

### Method 1: Pulling and running the Docker container in the terminal

The client can be started using the simple docker run command. If you don't have the container downloaded yet, you can pull it using the docker pull command.

```text
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

