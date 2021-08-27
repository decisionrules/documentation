# Containers environmental variables

### **Server variables**

The application has mandatory environment variables. ****It has to specify these environments:

* WORKERS\_NUMBER: Number of clusters in one instance
* REDIS\_URL: Connection URL to your Redis
* SOLVER\_REDIS\_URL: Connection URL to your Redis. It can be the same as REDIS\_URL.
* MONGO\_DB\_URI: Connection url to your MongoDB
* CLIENT\_URL: Url to decisionrules/client.
* LICENSE\_KEY: Your License Key

#### **WORKER\_NUMBERS**

1 worker is usually 1 thread or core of the CPU. With this environmental variable, you can specify to run the application on more cores/threads of the CPU.

Standardly the variable is set to 1.

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

### **Client variables.**

The application has mandatory environment variables. ****It has to specify these environments: 

*  API\_URL: Url to decisionrules backend.

#### API\_URL

This variable specifies the URL to your server with decisionrules/server container.

Example URL: [http://localhost:8080](http://localhost:8080)

