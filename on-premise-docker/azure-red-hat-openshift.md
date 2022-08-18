# Azure Red Hat OpenShift

## Requirements&#x20;

* [MongoDB database (or CosmosDB)](azure/database-azure-cosmos-db.md)
* [Redis cache](azure/redis-azure-cache-for-redis.md)
* OpenShift Cluster

## **Deploy DecisionRules to Openshift Cluster**

* Before setting up DecisionRules on Openshift it is important to set up the MongoDB database and Redis Cache. Without these requirements, DecisionRules won't start successfully.&#x20;
* For deploying Decision Rules you need to login into the OpenShift console.&#x20;
* After you are logged in, select developer perspective.&#x20;
* Go to Project and click on create a Project.&#x20;
* After the Project is created and selected go to +Add.

### Deploy DecisionRules server

Choose Container images.

#### Image

* Image name from the external registry: docker.io/decisionrules/server(:version)

#### Resources&#x20;

* Deployment

#### Advanced options

* Target port: 8080&#x20;

#### Health checks&#x20;

**Readiness probe**&#x20;

* Type: HTTP GET
* Path: /health-check&#x20;
* Port: 8080&#x20;
* Failure threshold: 3&#x20;
* Success threshold: 1&#x20;
* Initial delay: 30&#x20;
* Period: 30&#x20;
* Timeout: 5



**Liveness probe**&#x20;

* Type: HTTP GET
* Path: /health-check&#x20;
* Port: 8080&#x20;
* Failure threshold: 3&#x20;
* Success threshold: 1&#x20;
* Initial delay: 30&#x20;
* Period: 30&#x20;
* Timeout: 5



**Startup probe**

* Type: HTTP GET
* Path: /health-check&#x20;
* Port: 8080&#x20;
* Failure threshold: 3&#x20;
* Success threshold: 1&#x20;
* Initial delay: 30&#x20;
* Period: 30&#x20;
* Timeout: 5

#### Deployment (Environmental variables)

List of [all environmental variables](https://docs.decisionrules.io/doc/on-premise-docker/containers-environmental-variables#server-environment-variables).

* REDIS\_URL: Redis Cache connection string ([more information here](https://docs.decisionrules.io/doc/on-premise-docker/microsoft-azure-setup/redis-azure-cache-for-redis#connecting-string-for-environmental-variables))&#x20;
* MONGO\_DB\_URI: MongoDB connection string ([more information here](https://docs.decisionrules.io/doc/on-premise-docker/microsoft-azure-setup/database-azure-cosmos-db#connecting-string-for-environmental-variables))&#x20;
* LICENSE\_KEY: Your license key&#x20;
*   DB\_TYPE: COSMOSDB (in case you’re using Cosmos DB otherwise do not use this environment variable)



Click on Create.

### **Deploy DecisionRules client**

Choose Container images.

#### Image&#x20;

* Image name from the external registry: docker.io/decisionrules/client(:version)&#x20;

#### Resources&#x20;

* Deployment&#x20;

#### Advanced options&#x20;

* Target port: 8080&#x20;

#### Deployment (Environmental variables)&#x20;

List of [all environmental variables](https://docs.decisionrules.io/doc/on-premise-docker/containers-environmental-variables#client-env-variables).

* API\_URL: URL of created DecisionRules server deployment&#x20;
* NGINX\_PORT: 8080

Click on Create.

### Modify DecisionRules server Deployment

After DecisionRules server deployment and DecisionRules client deployment is deployed, it is necessary to modify DecisionRules server deployment for the best experience.&#x20;

You need to add a **CLIENT\_URL** environment variable. The value is the URL of created DecisionRules client deployment with **#**. For example: https://app.decisionrules.io**/#**

