# Containers environmental variables

### How to set env variables

All variables can be set either in the docker-compose configuration file or directly as a command-line parameter before running the containers.

### Server env variables

| Variable name | Description |
| :--- | :--- |
| SHOWCASE | Turn on or off showcase mode |
| WORKERS\_NUMBER | Sets number of workers \(threads\) of application |
| REDIS\_URL | Redis URL |
| SOLVER\_REDIS\_URL | Redis URL for solver |
| MONGO\_DB\_URI | Mongo URL |
| CLIENT\_URL | Url on which client container is accessible |
| LICENSE\_KEY | License key string |
| SAML\_ENTRY\_POINT | Identity provider entry point |
| SAML\_ISSUER | Issuer string to supply to IdP |

### Client env variables

| Variable name | Description |
| :--- | :--- |
| API\_URL | Url on which backend API is accessible |

Sample config file that is actually usable for showcase

```javascript
version: "3.7"

services:
  server:
    image: decisionrules/server:v4
    environment:
      - "SHOWCASE=true"
      - "WORKERS_NUMBER=1"
      - "REDIS_URL=redis://host.docker.internal:6379"
      - "SOLVER_REDIS_URL=redis://host.docker.internal:6379"
      - "MONGO_DB_URI=mongodb://host.docker.internal:27017"
      - "CLIENT_URL=http://localhost:80/#/"
      - "LICENSE_KEY="
      - "SAML_ENTRY_POINT="
      - "SAML_ISSUER="
    ports:
      - "8080:8080"
      - "8081:8081"
    links:
      - mongoDb
      - redis
    volumes:
      - license:/assets/lic/:rw

  client:
    image: decisionrules/client:v4
    environment:
      - "API_URL=http://localhost:8080"
    ports:
    - "80:80"

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

