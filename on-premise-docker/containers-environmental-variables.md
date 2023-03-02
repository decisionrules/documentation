# Environment Variables

## DecisionRules Environment Variables

All variables can be set either in the docker-compose configuration file or directly as a command-line parameter before running the containers.

### Server environment variables

| Variable name      | Description                                 | Mandatory                         | Version                                                    | Example value                                      |
| ------------------ | ------------------------------------------- | --------------------------------- | ---------------------------------------------------------- | -------------------------------------------------- |
| REDIS\_URL         | Redis URL                                   | Yes                               |                                                            | redis(s)://host.docker.internal:6379               |
| SOLVER\_REDIS\_URL | Redis URL for solver                        | Yes                               | Not needed from version 1.6.0, will use REDIS\_URL instead | redis(s)://host.docker.internal:6379               |
| MONGO\_DB\_URI     | Mongo URL                                   | Yes                               |                                                            | mongodb(+srv)://host.docker.internal:27017         |
| CLIENT\_URL        | Url on which client container is accessible | Yes                               |                                                            | http://localhost:80/**# (# is mandatory)**         |
| LICENSE\_KEY       | License key string                          | Yes                               |                                                            | YOUR LICENSE KEY                                   |
| DB\_TYPE           | Specify MongoDB type                        | If you use CosmosDB or DocumentDB | Available from 1.8.2                                       | <p>MONGODB (default)<br>COSMOSDB<br>DOCUMENTDB</p> |

### License Key Validation

Your server must have access to host [https://license.decisionrules.io/](https://license.decisionrules.io/). You won't be able to start the container without the connectivity to the license server.

### Optional server environment variables

| Variable name           | Description                                                                                                                   | Mandatory | Version               | Example value                                |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------- | --------- | --------------------- | -------------------------------------------- |
| SHOWCASE                | Turn on or off showcase mode                                                                                                  | No        |                       | true/false                                   |
| WORKERS\_NUMBER         | Sets number of workers (threads) of application                                                                               | No        |                       | 1                                            |
| BI\_MONGO\_DB\_URI      | If you have a separate database cluster for Business Intelligence App                                                         | No        | From version 1.10.0   | mongodb(+srv)://host.docker.internal:27018   |
| SAML\_ENTRY\_POINT      | URL for your identity provider login page                                                                                     | No        |                       | https://devX.okta.com/app/name/HASH/sso/saml |
| SAML\_ISSUER            | Issuer string to supply to IdP                                                                                                | No        |                       | okta.com/HASH\_STRING                        |
| SAML\_CERT              | Public certificate of provider. In RAW format as single line withou BEGIN CERTIFICATE and END CERTIFICATE                     | No        |                       | MIIC8DCCAdigAwIBAgIQap4GhMRA26tJGFD.....     |
| SAML\_CALLBACK\_URL     | Callback URL where provider send response                                                                                     | No        |                       | https://api.decisionrules.io/saml/callback   |
| RF\_TIMEOUT             | Time in milliseconds after which the process of solving a **rule flow** is stopped                                            | No        |                       | 10000                                        |
| SR\_TIMEOUT             | Time in milliseconds after which the process of solving a **scripting rule** is stopped                                       | No        |                       | 10000                                        |
| RF\_NODE\_LIMIT         | Integer of desired rule flow nodes, default value is 30                                                                       | No        |                       | 30                                           |
| SWAGGER\_HOST           | Host of the server application which will use swagger                                                                         | No        |                       | api.decisionrules.io                         |
| WHITELIST               | List of allowed domains from which it is possible to register or log in. You can setup multiple domains separated with comma. | No        |                       | mydomain.com, yourdomain.io                  |
| ALLOWLIST               | Cultural-neutral synonym for WHITELIST.                                                                                       | No        |                       | mydomain.com, yourdomain.io                  |
| TELEMETRY               | It turn on/off telemetry, which measures endpoint execution duration (for example: Solver API)                                | No        | Available from 1.8.1  | On = 1, off = 0                              |
| EXAPI\__MAX_\_CNT\_LEN  | Defined maximal response content length in bytes                                                                              | No        |                       | 3000                                         |
| EXAPI\__MAX_\_BODY\_LEN | Defined maximal body size for request in bytes                                                                                | No        |                       | 10000                                        |
| EXAPI\__MAX_\_REDIRECTS | Defines maximal redirects that called url can perform                                                                         | No        |                       | 5                                            |
| EXAPI\__TIMEOUT_        | Defines API connection timeout in miliseconds                                                                                 | No        |                       | 2000                                         |
| DT\_HTTP\_CALL\_LIMIT   | Defined limit for http function that can be defined in DT or DTR                                                              | No        | Available from 1.12.0 | 100                                          |
| LOGGER\_TYPE            | <p>Select log output format/logger type<br><br>STRING is default value if not evn variable is set</p>                         | No        |                       | <p>Possible options: <br>STRING<br>JSON</p>  |
| LOGGER\_TIMESTAMP\_UTC  | <p>Select log timestamp format<br>If true: YYYY-MM-DDTHH:mm:ss.SSSZ<br>if false: YYYY-MM-DDTHH:mm:ss.SSS(+-)HH:mm</p>         | No        | Available from 1.14.2 | true/false                                   |
| REDIS\_PING\_INTERVAL   | Duration (in milliseconds) for which the server pings the Redis server.                                                       | No        | Available from 1.14.3 | 300000                                       |

### Client environment variables

| Variable name | Description                                          | Mandatory                                                        | Version             | Example value         |
| ------------- | ---------------------------------------------------- | ---------------------------------------------------------------- | ------------------- | --------------------- |
| API\_URL      | Url on which backend API is accessible               | Yes                                                              |                     | http://localhost:8080 |
| BI\_API\_URL  | Url on which Business Intelligence API is accessible | No, but the features related to Business Intelligence won't work | From version 1.10.0 | http://localhost:8082 |
| NGINX\_PORT   | Custom port on which the container will run          | No                                                               | From version 1.9.3  | 80                    |

### Audit environment variables

| Variable name          | Description                                                                                                           | Mandatory | Example value                                      |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------- | --------- | -------------------------------------------------- |
| BI\_MONGO\_DB\_URI     | Mongo URL of Business Intelligence App                                                                                | Yes       | mongodb(+srv)://host.docker.internal:27017         |
| MONGO\_DB\_URI         | In case you have a separate database cluster for Server App                                                           | No        | mongodb(+srv)://host.docker.internal:27018         |
| WORKERS\_NUMBER        | Sets number of workers (threads) of application                                                                       | No        | 1                                                  |
| DB\_TYPE               | If you use CosmosDB or DocumentDB                                                                                     | No        | <p>MONGODB (default)<br>COSMOSDB<br>DOCUMENTDB</p> |
| LOGGER\_TYPE           | <p>Select log output format/logger type<br><br>STRING is default value if not evn variable is set</p>                 | No        | <p>Possible options: <br>STRING<br>JSON</p>        |
| LOGGER\_TIMESTAMP\_UTC | <p>Select log timestamp format<br>If true: YYYY-MM-DDTHH:mm:ss.SSSZ<br>if false: YYYY-MM-DDTHH:mm:ss.SSS(+-)HH:mm</p> | No        | true/false                                         |

### Kafka env variables

| Variable name                        | Description                                                                               | Mandatory                          | Example value                                   |
| ------------------------------------ | ----------------------------------------------------------------------------------------- | ---------------------------------- | ----------------------------------------------- |
| KAFKA\_ENABLED                       | Turn Kafka on/off                                                                         | Yes (Kafka is disabled by default) | 1/0                                             |
| KAFKA\__CLUSTER\_CLIENTID_           | A logical identifier of an application.                                                   | Yes                                | "my-app"                                        |
| KAFKA\__CLUSTER\_BROKERS_            | Broker definition                                                                         | Yes                                | "my-broker:9092, my-broker2:9092"               |
| KAFKA\__CLUSTER\_SSL_                | SSL on/off                                                                                | Yes                                | "true"                                          |
| KAFKA\__CLUSTER\_SASL\_MECHANISM_    | Definition of Kafka SASL mechanism.                                                       | Yes                                | "plain"                                         |
| KAFKA\__CLUSTER\_SASL\_USERNAME_     | SASL username                                                                             | No                                 | "my-username"                                   |
| KAFKA\__CLUSTER\_SASL\_PASSWORD_     | SASL password                                                                             | No                                 | "top-secret-password"                           |
| KAFKA\__CLUSTER\_SASL\_AUTHID_       | SASL access key for aws mechanism                                                         | No                                 | "KEYKEYKEY"                                     |
| KAFKA\__CLUSTER\_SASL\_ACCKEYID_     | SASL secret access key for aws mechanism                                                  | No                                 | "KEYKEYKEY"                                     |
| KAFKA\__CLUSTER\_SASL\_SECRETKEY_    | SASL session token for aws mechanism                                                      | No                                 | "TOKENTOKEN"                                    |
| KAFKA\__CLUSTER\_SASL\_SESSIONTOKEN_ | SASL authorization identity for aws mechanism                                             | No                                 | "SESSIONTOKEN"                                  |
| KAFKA\__GROUP\_TOPIC\_1_             | Definition of kafka topic, use numbers 1,2,...,N where N is INT for multiple TOPIC GROUPS | Yes                                | "my-group, my-request-topic, my-response-topic" |

