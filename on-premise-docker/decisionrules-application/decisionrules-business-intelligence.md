# DecisionRules Business Intelligence

{% hint style="success" %}
Production Container
{% endhint %}

Download the latest DecisionRules business intelligence container that provides front-end applications with maintenance and regular updates.

## Container types

{% hint style="info" %}
Since version 1.15.0 the container runs with a non-root user
{% endhint %}

## How to start the DecisionRules Business Intelligence

The business intelligence app can only be started with the set env. variables that are necessary for operation.

### Method 1: Pulling and running the Docker container in the terminal

The business intelligence app can be started using the simple docker run command. If you don't have the container downloaded yet, you can pull it using the docker pull command.

```
//pull container
docker pull decisionrules/business-intelligence
//run container alone
docker run -d -p 82:82 -e BI_MONGO_DB_URI=YOUR_MONGO_URI decisionrules/business-intelligence
```

### Method 2: Creating your own docker-compose file

If you don't want to use too much terminal you can create your own docker-compose file. The file type is YAML.

```yaml
version: "1.0"

services:
    server:
        image: decisionrules/business-intelligence
        environment:
            - "BI_MONGO_DB_URI=YOUR_MONGO_URI"
        ports:
            - "8082:8082"
```

{% hint style="info" %}
Docker compose files are started with docker compose up command.
{% endhint %}

### Make Business Intelligence Work with Other Containers

* You need to set an environment variable called "BI\_API\_URL_=YOUR_\_URL" inside the Client Container
* If you use a **different database cluster** for your Business Intelligence App, then you need to set an environment variable called "BI\_MONGO\_DB\_URI_=YOUR_\_URI" inside the Server Container

{% hint style="success" %}
Business Intelligence App works with Client and Server version 1.10.0 and newer
{% endhint %}
