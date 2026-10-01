# Azure Red Hat OpenShift

## Requirements

* [MongoDB database (or CosmosDB)](microsoft-azure-setup/database-azure-cosmosdb.md)
* [Redis cache](microsoft-azure-setup/cache-azure-cache-for-redis.md)
* OpenShift Cluster

## **Deploy DecisionRules to Openshift Cluster**

* Before setting up DecisionRules on Openshift it is important to set up the MongoDB database and Redis Cache. Without these requirements, DecisionRules won't start successfully.
* For deploying Decision Rules you need to login into the OpenShift console.
* After you are logged in, select developer perspective.
* Go to Project and click on create a Project.
* After the Project is created and selected go to +Add.

### Deploy DecisionRules server

Choose Container images.

#### Image

* Image name from the external registry: docker.io/decisionrules/server(:version)

#### Resources

* Deployment

#### Advanced options

* Target port: 8080

#### Health checks

**Readiness probe**

* Type: HTTP GET
* Path: /health-check
* Port: 8080
* Failure threshold: 3
* Success threshold: 1
* Initial delay: 30
* Period: 30
* Timeout: 5

**Liveness probe**

* Type: HTTP GET
* Path: /health-check
* Port: 8080
* Failure threshold: 3
* Success threshold: 1
* Initial delay: 30
* Period: 30
* Timeout: 5

**Startup probe**

* Type: HTTP GET
* Path: /health-check
* Port: 8080
* Failure threshold: 3
* Success threshold: 1
* Initial delay: 30
* Period: 30
* Timeout: 5

#### Deployment (Environmental variables)

List of [all environmental variables](https://docs.decisionrules.io/doc/on-premise-docker/containers-environmental-variables#server-environment-variables).

* REDIS\_URL: Redis Cache connection string ([more information here](https://docs.decisionrules.io/doc/on-premise-docker/microsoft-azure-setup/redis-azure-cache-for-redis#connecting-string-for-environmental-variables))
* MONGO\_DB\_URI: MongoDB connection string ([more information here](https://docs.decisionrules.io/doc/on-premise-docker/microsoft-azure-setup/database-azure-cosmos-db#connecting-string-for-environmental-variables))
* LICENSE\_KEY: Your license key
* DB\_TYPE: COSMOSDB (in case you’re using Cosmos DB otherwise do not use this environment variable)

Click on Create.

### **Deploy DecisionRules client**

Choose Container images.

#### Image

* Image name from the external registry: docker.io/decisionrules/client(:version)

#### Resources

* Deployment

#### Advanced options

* Target port: 8080

#### Deployment (Environmental variables)

List of [all environmental variables](https://docs.decisionrules.io/doc/on-premise-docker/containers-environmental-variables#client-env-variables).

* API\_URL: URL of created DecisionRules server deployment
* NGINX\_PORT: 8080

Click on Create.

### Modify DecisionRules server Deployment

After DecisionRules server deployment and DecisionRules client deployment is deployed, it is necessary to modify DecisionRules server deployment for the best experience.

You need to add a **CLIENT\_URL** environment variable. The value is the URL of created DecisionRules client deployment with **#**. For example: https://app.decisionrules.i&#x6F;**/#**

## **Scaling**

Openshift supports horizontal cluster scaling using 2 metrics. Either by using the CPU or RAM usage of the containers. The following parameters need to be set for scaling to work properly.

* Resource limit
* HorizontalPodAutoscaler

### Resource limit

For server 1.27.0, select an initial profile according to the workload:

| Workload                 | CPU request / limit | Memory request / limit | Initial `WORKERS_NUMBER` |
| ------------------------ | ------------------- | ---------------------- | ------------------------ |
| V1 only                  | `1000m` / `1000m`   | `2Gi` / `2Gi`          | `1`                      |
| V2 (Aero) or mixed V1/V2 | `4000m` / `4000m`   | `8Gi` / `8Gi`          | `1`                      |

`WORKERS_NUMBER` controls Node.js processes; Aero uses multiple CPUs independently. See [server sizing](../../../decisionrules-applications/server-app.md#minimal-requirements) for scaling and resource reserve.

### HorizontalPodAutoscaler

#### Name

Custom name of metrics.

#### Minimum Pods

It depends on the needs. The recommended value is a minimum of 2.

#### Maximum Pods

It depends on the needs and the expected maximum performance.

#### CPU Utilization

Value: 60%

#### Memory Utilization

Value: 0%

### Info

The default value when the cluster checks if the pods exceed the set parameters is 15s.

The cluster will add more pods if needed until the maximum number of pods defined in HorizontalPodAutoscaler is filled.

When resources (pods) are no longer needed, they are automatically deleted according to usage up to the Minimum Pods value set in HorizontalPodAutoscaler. This ensures that unused pods are not running unnecessarily.
