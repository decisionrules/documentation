# Decisionrules/server

## **decisionrules/server**

This is the backend application of DecisionRules.

You can find an image of the docker container on [https://hub.docker.com/repository/docker/decisionrules/server](https://hub.docker.com/repository/docker/decisionrules/server)  


To download the latest version of the application you can use docker pull decisionrules/server:latest

### **Environment variables**

The application has mandatory environment variables.

It has to specify these environments: 

* WORKERS\_NUMBER: Number of clusters in one instance
* REDIS\_URL: Connection URL to your Redis
* SOLVER\_REDIS\_URL: Connection URL to your Redis. It can be the same as REDIS\_URL.
* MONGO\_DB\_URI: Connection url to your MongoDB
* CLIENT\_URL: Url to decisionrules/client.
* LICENSE\_KEY: Your License Key

#### WORKER\_NUMBERS

1 worker is usually 1 thread or core of the CPU. With this env variable, you can specify to run the application on more cores/threads of the CPU.

Standardly variable is set to 1.

#### REDIS\_URL, SOLVER\_REDIS\_URL

These variables specify a connection url to your Redis server. There are 2 options of url:

* Url started with redis:// - non-TLS connection with Redis server
* Url started with rediss:// - TLS connection with Redis server 

Example url: redis\[s\]://user:password@host:port

 redis://host.docker.internal:6379

#### Mongo\_DB\_URI

This variable specifies a connection URL to your MongoDB.

Example url: mongodb://host.docker.internal:27017

#### Client Url

This variable specifies the URL to your server with decisionrules/client container. The URL must end with /\#/.

Example URL: [http://localhost:4001/\#/](http://localhost:4001/#/)  


