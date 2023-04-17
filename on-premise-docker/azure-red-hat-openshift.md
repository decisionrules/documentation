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

## **Scaling**

Openshift supports horizontal cluster scaling using 2 metrics. Either by using the CPU or RAM usage of the containers. The following parameters need to be set for scaling to work properly.

* Resource limit&#x20;
* HorizontalPodAutoscaler&#x20;

### Resource limit&#x20;

#### CPU&#x20;

Request: same as **WORKERS\_NUMBER** environmental variable (**cores**)&#x20;

Limit: same as **WORKERS\_NUMBER** environmental variable (**cores**)&#x20;

#### Memory&#x20;

Request: **WORKERS\_NUMBER** \* _300 + 400 (**Mi**)_&#x20;

_Limit: **WORKERS\_NUMBER** \*_ 300 + 1000 (**Mi**)

### HorizontalPodAutoscaler&#x20;

#### Name&#x20;

Custom name of metrics.&#x20;

#### Minimum Pods&#x20;

It depends on the needs. The recommended value is a minimum of 2.&#x20;

#### Maximum Pods&#x20;

It depends on the needs and the expected maximum performance.&#x20;

#### CPU Utilization&#x20;

Value: 60%&#x20;

#### Memory Utilization&#x20;

Value: 0%&#x20;

### Info&#x20;

The default value when the cluster checks if the pods exceed the set parameters is 15s.&#x20;

The cluster will add more pods if needed until the maximum number of pods defined in HorizontalPodAutoscaler is filled.&#x20;

When resources (pods) are no longer needed, they are automatically deleted according to usage up to the Minimum Pods value set in HorizontalPodAutoscaler. This ensures that unused pods are not running unnecessarily.
