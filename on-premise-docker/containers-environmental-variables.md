# Containers environmental variables

### How to set env variables

All variables can be set either in the docker-compose configuration file or directly as a command-line parameter before running the containers.

### Server env variables

| Variable name | Description | Mandatory | Example value |
| :--- | :--- | :--- | :--- |
| SHOWCASE | Turn on or off showcase mode | No | true/false |
| WORKERS\_NUMBER | Sets number of workers \(threads\) of application | No | 1 |
| REDIS\_URL | Redis URL | Yes | redis\(s\)://host.docker.internal:6379 |
| SOLVER\_REDIS\_URL | Redis URL for solver | Yes | redis\(s\)://host.docker.internal:6379 |
| MONGO\_DB\_URI | Mongo URL | Yes | mongodb\(+srv\)://host.docker.internal:27017 |
| CLIENT\_URL | Url on which client container is accessible | Yes | http://localhost:80/**\#/ \(\#/ is mandatory\)** |
| LICENSE\_KEY | License key string | Yes | YOUR LICENSE KEY |
| SAML\_ENTRY\_POINT | URL for your identity provider login page | No | https://devX.okta.com/app/name/HASH/sso/saml |
| SAML\_ISSUER | Issuer string to supply to IdP | No | okta.com/HASH\_STRING |

### Client env variables

| Variable name | Description | Mandatory | Example value |
| :--- | :--- | :--- | :--- |
| API\_URL | Url on which backend API is accessible | Yes | http://localhost:8080 |


