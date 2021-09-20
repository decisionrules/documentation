# Server App

{% hint style="success" %}
Production Container
{% endhint %}

Download the latest DecisionRules server container that provides all the backend functionalities with maintenance and regular updates. The server requires [Redis Cache](https://redis.io/) and [MongoDB](https://www.mongodb.com/).

All environmental variables can be found [here](containers-environmental-variables.md).

### How to setup Server App container

First of all, you need to pull the container from the [docker hub](https://hub.docker.com/r/decisionrules/server). For pulling the container use this command:

```text
docker pull decisionrules/server
```

After pulling the container you want to run it. You can run containers with `docker run`command. You will also need to set up environmental variables and the networking of other containers. Server App alone doesn't do much.

{% hint style="danger" %}
**If you want use DecisionRules as a multi-container app \(recommended\). You can read how to set up networking between containers is described** [**here**](manual-networking-between-containers.md)**.**
{% endhint %}

**How to pass environmental variables to the container?**

You can simply past env variables to the container before with `-e` parameter in the command line.

Example:

```text
docker pull decisionrules/server
docker run decisionrules/server -e WORKERS_NUMBER=1 -e SHOWCASE=false
```

Or you can use the env file. The file can look like this:

```text
WORKERS_NUMBER=1
SHOWCASE=false
```

Example:

```text
docker run decisionrules/server --env-file my_env_file.txt
```

