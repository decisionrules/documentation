# Environmental Variables

## DecisionRules Environment Variables in On-Premise deployment

All variables can be set either in the docker-compose configuration file or directly as a command-line parameter before running the containers.

### Server env variables

| Variable name       | Description                                                                                                                   | Mandatory | Example value                                                                                                                   |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------- |
| SHOWCASE            | Turn on or off showcase mode                                                                                                  | No        | true/false                                                                                                                      |
| WORKERS\_NUMBER     | Sets number of workers (threads) of application                                                                               | No        | 1                                                                                                                               |
| REDIS\_URL          | Redis URL                                                                                                                     | Yes       | redis(s)://host.docker.internal:6379                                                                                            |
| SOLVER\_REDIS\_URL  | Redis URL for solver                                                                                                          | Yes       | redis(s)://host.docker.internal:6379                                                                                            |
| MONGO\_DB\_URI      | Mongo URL                                                                                                                     | Yes       | mongodb(+srv)://host.docker.internal:27017                                                                                      |
| CLIENT\_URL         | Url on which client container is accessible                                                                                   | Yes       | http://localhost:80/**# (# is mandatory)**                                                                                      |
| LICENSE\_KEY        | License key string                                                                                                            | Yes       | YOUR LICENSE KEY                                                                                                                |
| SAML\_ENTRY\_POINT  | URL for your identity provider login page                                                                                     | No        | https://devX.okta.com/app/name/HASH/sso/saml                                                                                    |
| SAML\_ISSUER        | Issuer string to supply to IdP                                                                                                | No        | okta.com/HASH\_STRING                                                                                                           |
| SAML\_CERT          | Public certificate of provider. In RAW format as single line withou BEGIN CERTIFICATE and END CERTIFICATE                     | No        | MIIC8DCCAdigAwIBAgIQap4GhMRA26tJGFD3fdTuNjANBgkqhkiG9w0BAQsFADA0MTIwMAYDVQQDEylNaWNyb3NvZnQgQXp1cmUgRmVkZXJhdGVkIFNTTyBD....... |
| SAML\_CALLBACK\_URL | Callback URL where provider send response                                                                                     | No        | https://api.decisionrules.io/saml/callback                                                                                      |
| RF\_TIMEOUT         | Time in milliseconds after which the process of solving a **rule flow** is stopped                                            | No        | 10000                                                                                                                           |
| SR\_TIMEOUT         | Time in milliseconds after which the process of solving a **scripting rule** is stopped                                       | No        | 10000                                                                                                                           |
| RF\_NODE\_LIMIT     | Integer of desired rule flow nodes, default value is 30                                                                       | No        | 30                                                                                                                              |
| SWAGGER\_HOST       | Host of the server application which will use swagger                                                                         | No        | api.decisionrules.io                                                                                                            |
| WHITELIST           | List of allowed domains from which it is possible to register or log in. You can setup multiple domains separated with comma. | No        | mydomain.com, yourdomain.io                                                                                                     |
| ALLOWLIST           | Cultural-neutral synonym for WHITELIST.                                                                                       | No        | mydomain.com, yourdomain.io                                                                                                     |
| TELEMETRY           | It turn on/off telemetry, which measures endpoint execution duration (for example: Solver API)                                | No        | <p>On = 1<br>Off = 0</p>                                                                                                        |
|                     |                                                                                                                               |           |                                                                                                                                 |

### Client env variables

| Variable name | Description                            | Mandatory | Example value         |
| ------------- | -------------------------------------- | --------- | --------------------- |
| API\_URL      | Url on which backend API is accessible | Yes       | http://localhost:8080 |
