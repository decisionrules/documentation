# Showcase + Business Intelligence

## How to start the DecisionRules showcase app

First of all, you need to download the docker-compose file.

You can download docker-compose file with curl as shown below.

```bash
curl -L https://decisionrules.io/showcase-with-business-intelligence/docker-compose.yml --output docker-compose.yaml
```

## Generate DecisionRules License Key

Please use [DecisionRules License Key Generator](https://www.decisionrules.io/on-premise#license). The generator will send your trial license key to your email.

### Method 1: Validating license key on validation page

After you obtain the license key you can open the terminal and navigate yourself to the folder where you downloaded the docker-compose file as shown in the step above.

Then run:

```
docker compose up
```

Docker will find a docker-compose file by itself and pull all mandatory containers and create all volumes defined in config. By default, you don't need to change anything.

After that, you will see something like this in terminal

![Indication that license validation server is running](../../../.gitbook/assets/showcase_start.png)

Now if you go to `localhost:80` you will be redirected to the validation page where you can enter your license key and after that, you can register a new account to local mongoDB database.

{% hint style="danger" %}
If you turn your containers off and want to start them again you need to use `docker-compose up --no-recreate` command.
{% endhint %}

![Validation Site](<../../../.gitbook/assets/image (149) (1).png>)

{% hint style="success" %}
**After registration, you are ready to use DecisionRules for 30 days as you like.**
{% endhint %}

{% hint style="info" %}
Right after the successful validation the showcase is turned off and the DecisionRules server is started.
{% endhint %}

After that license key is stored in docker volume so there is no need to enter the license key again at the next start of the container (in case of containers recreation you will be prompted again with the validation process).

### Method 2: Adding license key to compose file

If you don't want or can't use our validation page you can enter the license key directly into the configuration file.

The license key belongs to the`LICENSE_KEY`variable in your docker-compose file and save. It should look like this.

```
version: "3.7"

services:
  server:
    image: decisionrules/server
    environment:
      - "SHOWCASE=true"
      - "WORKERS_NUMBER=1"
      - "REDIS_URL=redis://host.docker.internal:6379"
      - "MONGO_DB_URI=mongodb://host.docker.internal:27017"
      - "CLIENT_URL=http://localhost:80/#"
      - "LICENSE_KEY=YOUR_LICENSE_KEY_HERE"
    ports:
      - "8080:8080"
      - "8081:8081"
    links:
      - mongoDb
      - redis
    volumes:
      - license:/assets/lic/:rw

  client:
    image: decisionrules/client
    environment:
      - "API_URL=http://localhost:8080"
      - "BI_API_URL=http://localhost:8082"
    ports:
    - "80:80"
    
  business-intelligence:
    image: decisionrules/business-intelligence
    environment:
      - "BI_MONGO_DB_URI=mongodb://host.docker.internal:27017"
    ports:
    - "8082:8082"
    links:
    -  mongoDb
    
  mongoDb:
    image: mongo
    ports:
      - "27017:27017"

  redis:
    image: redis
    ports:
      - "6379:6379"
volumes:
  license:
    driver: local
```

After that, run command below in the folder containing the docker-compose file that you edited.

```
docker compose up
```

After decisionrules/server comes alive and connects to local Redis and mongoDB, you should see something very similar to this:

![](../../../.gitbook/assets/console_server.png)

After this, you can enter `localhost:80` and you will be redirected to the login page of the DecisionRules login screen.

{% hint style="success" %}
**After registration, you are ready to use DecisionRules for 30 days as you like.**
{% endhint %}
