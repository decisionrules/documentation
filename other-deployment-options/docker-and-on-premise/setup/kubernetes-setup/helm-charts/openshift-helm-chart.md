---
description: >-
  Helm chart for deploying DecisionRules to Red Hat OpenShift. What it deploys,
  what you need to provision separately, and how to configure it.
---

# OpenShift Helm Chart

The `decisionrules-ocp` chart deploys DecisionRules to Red Hat OpenShift, for example self-managed OpenShift Container Platform, Azure Red Hat OpenShift (ARO) or Red Hat OpenShift Service on AWS (ROSA). The application is exposed through OpenShift Routes with edge TLS termination. All credentials are read from Kubernetes Secrets that you create yourself, so nothing sensitive is stored in values files or in the Helm release.

|                 |                                                                                                                                                     |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Chart name      | `decisionrules-ocp`                                                                                                                                 |
| Helm repository | `https://decisionrules.github.io/helm-charts/decisionrules-ocp/`                                                                                    |
| Artifact Hub    | [decisionrules-ocp](https://artifacthub.io/packages/helm/decisionrules-ocp/decisionrules-ocp)                                                       |
| Images          | `decisionrules/client` (rootless variant), `decisionrules/server`, `decisionrules/ai-engine`, `decisionrules/business-intelligence` from Docker Hub |

## What you need to provision separately

The chart deploys only the DecisionRules application. Prepare the following before you install it:

| Requirement                                               | Required            | Notes                                                                                                                                                                                                                                                                                                                                                                                             |
| --------------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OpenShift cluster and a project (namespace)               | Yes                 | The Secrets below must exist in the project before installation.                                                                                                                                                                                                                                                                                                                                  |
| MongoDB                                                   | Yes                 | Two databases: the main database (`MONGO_DB_URI`) and the Business Intelligence (audit) database (`BI_MONGO_DB_URI`). They can live on the same MongoDB cluster. For MongoDB Atlas, see [MongoDB Atlas Network Peering](../../mongodb-atlas-network-peering.md). See [Database - Azure CosmosDB](../../microsoft-azure-setup/database-azure-cosmosdb.md) if you use Cosmos DB instead of MongoDB. |
| Redis                                                     | Yes                 | Used by the server (`REDIS_URL`). See [Redis Connection Modes](../../../redis-connection-modes.md).                                                                                                                                                                                                                                                                                               |
| DecisionRules license key                                 | Yes                 | `LICENSE_KEY`                                                                                                                                                                                                                                                                                                                                                                                     |
| Kubernetes Secret with connection strings and license key | Yes                 | See [Secrets](openshift-helm-chart.md#secrets).                                                                                                                                                                                                                                                                                                                                                   |
| Secret with the AI provider key (`AIA_SECRET`)            | Only with AI Engine | The AI Engine is enabled by default. See [AI Engine providers and models](../../../ai-engine-providers-and-models.md).                                                                                                                                                                                                                                                                            |
| Hostnames for the client and the API                      | Recommended         | Needed to build the application URLs. See [Application URLs](openshift-helm-chart.md#application-urls).                                                                                                                                                                                                                                                                                           |
| Outbound proxy and a ConfigMap with its CA certificate    | Optional            | Only when outbound traffic must go through a proxy.                                                                                                                                                                                                                                                                                                                                               |
| Outbound access to the license and distribution servers   | Yes                 | See [Prerequisites](../../../prerequisites.md), or use an [Offline License](../../../offline-license.md).                                                                                                                                                                                                                                                                                         |

The chart does not create MongoDB, Redis, Secrets, ConfigMaps or persistent volumes.

## What the chart deploys

| Component             | Resources created                                   | Enabled by default | Values that control it                                                 |
| --------------------- | --------------------------------------------------- | ------------------ | ---------------------------------------------------------------------- |
| Client                | Deployment, Service, Route                          | Yes                | `client.enabled`, `client.route.enabled`                               |
| Server                | Deployment, Service, Route, HorizontalPodAutoscaler | Yes                | `server.enabled`, `server.route.enabled`, `server.autoscaling.enabled` |
| AI Engine             | Deployment, Service (cluster-internal only)         | Yes                | `aiEngine.enabled`                                                     |
| Business Intelligence | Deployment (no Service or Route)                    | Yes                | `businessIntelligence.enabled`                                         |

Resources are named after the Helm release, for example `<release>-server` and `<release>-server-service`.

The chart does not set a security context. OpenShift assigns one through its default `restricted-v2` Security Context Constraint, and all DecisionRules images run under the arbitrary non-root user ID that OpenShift assigns. The client uses the rootless image, which listens on port 4000.

## Secrets

The chart reads credentials from existing Kubernetes Secrets in the release namespace. You set only the **name** of the Secret in the values, never the values themselves.

| Value                     | Default                | Secret keys                                                   |
| ------------------------- | ---------------------- | ------------------------------------------------------------- |
| `server.existingSecret`   | `decisionrules-config` | `MONGO_DB_URI`, `BI_MONGO_DB_URI`, `REDIS_URL`, `LICENSE_KEY` |
| `aiEngine.existingSecret` | `decisionrules-config` | `AIA_SECRET` (only when `aiEngine.enabled=true`)              |

{% hint style="warning" %}
All four connection keys must be present, even if you disable Business Intelligence. The server always reads `BI_MONGO_DB_URI`, and a missing key keeps the pod from starting.
{% endhint %}

Both values point to the same Secret by default, so you can keep everything in one Secret or split the AI provider key into its own Secret.

```bash
oc new-project decisionrules

oc create secret generic decisionrules-config -n decisionrules \
  --from-literal=MONGO_DB_URI='mongodb+srv://user:password@cluster0.example.mongodb.net/decisionrules' \
  --from-literal=BI_MONGO_DB_URI='mongodb+srv://user:password@cluster0.example.mongodb.net/decisionrules-audit' \
  --from-literal=REDIS_URL='redis://:password@redis.example.internal:6379' \
  --from-literal=LICENSE_KEY='YOUR-LICENSE-KEY' \
  --from-literal=AIA_SECRET='YOUR-AI-PROVIDER-KEY'
```

The Secret can also be created by any tool that materializes Kubernetes Secrets, for example the External Secrets Operator (from Azure Key Vault, AWS Secrets Manager, HashiCorp Vault and others) or Sealed Secrets. The chart only needs the Secret to exist.

The chart fails to render with a clear error message when `server.existingSecret` is empty, or when `aiEngine.existingSecret` is empty while the AI Engine is enabled.

## Application URLs

The client and the server need to know their public URLs. The chart builds them as follows:

| Variable        | Set on         | Taken from (first match wins)                                                                     |
| --------------- | -------------- | ------------------------------------------------------------------------------------------------- |
| `API_URL`       | Server, Client | `server.apiUrl` (for the client `client.apiUrl` takes precedence) → `https://<server.route.host>` |
| `CLIENT_URL`    | Server         | `server.clientUrl` → `https://<client.route.host>/#`                                              |
| `AI_ENGINE_URL` | Server         | `server.aiEngineUrl` → internal AI Engine Service URL (only when the AI Engine is enabled)        |

{% hint style="danger" %}
If you leave `client.route.host` and `server.route.host` empty, OpenShift generates the route hostnames, but the chart cannot know them and falls back to placeholder URLs (`https://api.example.com`). Always set both route hosts, or set `server.apiUrl` and `server.clientUrl` explicitly. `CLIENT_URL` must end with `/#`.
{% endhint %}

## Optional features

What changes when you turn each feature on or off:

<details>

<summary>AI Engine — <code>aiEngine.enabled</code> (default: <code>true</code>)</summary>

* Creates the AI Engine Deployment and a cluster-internal Service `<release>-ai-engine-service` on port 8084.
* Sets `AI_ENGINE_URL` on the server to the internal Service URL. Override it with `server.aiEngineUrl`.
* Requires `aiEngine.existingSecret` pointing to a Secret with the `AIA_SECRET` key.
* The provider settings are passed as environment variables: `aiEngine.provider` → `AIA_PROVIDER`, `aiEngine.family` → `AIA_FAMILY`, `aiEngine.model` → `AIA_MODEL`, `aiEngine.additionalDataJson` → `AIA_ADDITIONAL_DATA_JSON`. See [AI Engine providers and models](../../../ai-engine-providers-and-models.md) for valid combinations.
* Set it to `false` if your license does not include the AI Assistant or you do not want to run it.

</details>

<details>

<summary>Business Intelligence — <code>businessIntelligence.enabled</code> (default: <code>true</code>)</summary>

* Creates the Business Intelligence Deployment. It reads `MONGO_DB_URI` and `BI_MONGO_DB_URI` from the connection Secret.
* No Service or Route is created for it.

</details>

<details>

<summary>Server autoscaling — <code>server.autoscaling.enabled</code> (default: <code>true</code>)</summary>

* Creates a HorizontalPodAutoscaler for the server, scaling at 60 % average CPU utilization. The range comes from the solver profile: 2 to 5 replicas for `aero` (default), 2 to 10 for `gaia`, see [Server sizing](openshift-helm-chart.md#server-sizing).
* While autoscaling is enabled, `server.replicaCount` is ignored.

</details>

<details>

<summary>Routes — <code>client.route.enabled</code>, <code>server.route.enabled</code> (default: <code>true</code>)</summary>

* Creates an OpenShift Route for the client and for the server with edge TLS termination and HTTP to HTTPS redirect (`tls.termination: edge`, `tls.insecureEdgeTerminationPolicy: Redirect`).
* The hostname comes from `client.route.host` / `server.route.host`.
* By default the Routes use the cluster's default router certificate. To use your own certificate, set `client.route.tls.certificate` and `client.route.tls.key` (and the same for `server.route.tls`) to the PEM-encoded certificate and key.
* Disable a Route if you expose the Service another way. Then set `server.apiUrl` and `server.clientUrl` explicitly.

</details>

<details>

<summary>Outbound proxy — <code>proxy.enabled</code> (default: <code>false</code>)</summary>

* Sets `HTTP_PROXY`, `HTTPS_PROXY` and `NO_PROXY` on the Server and the AI Engine from `proxy.httpProxy`, `proxy.httpsProxy` and `proxy.noProxy`. Business Intelligence does not get proxy settings.
* With `proxy.caBundle.enabled=true` and `proxy.caBundle.configMapName` set, the chart mounts that ConfigMap into the Server and AI Engine pods at `proxy.caBundle.mountPath` (default `/etc/ssl/custom`). The ConfigMap must contain a key named after `proxy.caBundle.fileName` (default `mitmproxy-ca.pem`) with the proxy's CA certificate.
* The certificate path is passed to the Server as `PROXY_CA_BUNDLE_PATH` and to the AI Engine as `SSL_CERT_FILE` and `REQUESTS_CA_BUNDLE`.

</details>

<details>

<summary>Extra server environment variables — <code>server.extraEnv</code></summary>

* A list of `name` / `value` pairs added to the server container, for any variable from [Environment Variables](../../../containers-environmental-variables.md) that the chart does not set itself (for example `DB_TYPE`, `REDIS_MODE` or SSO settings).
* Values are stored in plain text in the Deployment. Do not put credentials here.

</details>

## Server sizing

The `server.solver` value sizes the server for the rule solver you use:

| `server.solver`  | Use for                                 | Server CPU / memory per Pod                      | Autoscaling |
| ---------------- | --------------------------------------- | ------------------------------------------------ | ----------- |
| `aero` (default) | Aero (V2) solver or mixed V1/V2 traffic | `4000m` / `4Gi` (requests = limits)              | 2–5 Pods    |
| `gaia`           | Gaia (V1) solver only                   | `1000m` / `1Gi` requests, `2000m` / `2Gi` limits | 2–10 Pods   |

Aero uses several CPUs within one process, so it runs best on fewer, larger replicas. The profiles are defined in `server.solverProfiles` in the chart's `values.yaml`, so you can adjust them, for example `--set server.solverProfiles.aero.maxReplicas=8`. To size the server yourself regardless of the profile, set `server.resources` and `server.autoscaling.minReplicas` / `maxReplicas`; they take precedence over the profile. See [server sizing](../../../../../decisionrules-applications/server-app.md#minimal-requirements) for scaling and resource reserve.

{% hint style="warning" %}
Aero is the default from chart version 0.2.0. Version 0.1.x sized the server like `gaia`. When you upgrade an existing installation, set `server.solver: gaia` to keep the previous sizing.
{% endhint %}

## Configuration reference

### Client

| Value                                            | Default                                    | Description                                          |
| ------------------------------------------------ | ------------------------------------------ | ---------------------------------------------------- |
| `client.enabled`                                 | `true`                                     | Deploy the client.                                   |
| `client.replicaCount`                            | `2`                                        | Number of client pods.                               |
| `client.image.repository` / `tag`                | `decisionrules/client` / `latest-rootless` | Use a rootless tag, for example `1.26.2.1-rootless`. |
| `client.port`                                    | `4000`                                     | Port the rootless image listens on.                  |
| `client.apiUrl`                                  | `""`                                       | Overrides `API_URL` for the client only.             |
| `client.resources`                               | 250m / 128Mi requests, 500m / 256Mi limits | CPU and memory.                                      |
| `client.route.enabled`                           | `true`                                     | Create the client Route.                             |
| `client.route.host`                              | `""`                                       | Client hostname, for example `app.example.com`.      |
| `client.route.tls.termination`                   | `edge`                                     | Route TLS termination.                               |
| `client.route.tls.insecureEdgeTerminationPolicy` | `Redirect`                                 | Redirect HTTP to HTTPS.                              |

### Server

| Value                                                      | Default                                                    | Description                                                                                          |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `server.enabled`                                           | `true`                                                     | Deploy the server.                                                                                   |
| `server.replicaCount`                                      | `2`                                                        | Number of server pods when autoscaling is disabled.                                                  |
| `server.image.repository` / `tag`                          | `decisionrules/server` / `latest`                          | Pin a version in production, for example `1.26.2.1`.                                                 |
| `server.port`                                              | `8080`                                                     | Server port.                                                                                         |
| `server.solver`                                            | `aero`                                                     | Server sizing profile: `aero` or `gaia`, see [Server sizing](openshift-helm-chart.md#server-sizing). |
| `server.solverProfiles.aero`, `server.solverProfiles.gaia` | see [Server sizing](openshift-helm-chart.md#server-sizing) | Server `resources`, `minReplicas` and `maxReplicas` of each profile.                                 |
| `server.resources`                                         | From the `server.solver` profile                           | CPU and memory of the server. Overrides the profile when set.                                        |
| `server.existingSecret`                                    | `decisionrules-config`                                     | Name of the connection Secret. Required.                                                             |
| `server.apiUrl`                                            | `""`                                                       | Overrides `API_URL`.                                                                                 |
| `server.clientUrl`                                         | `""`                                                       | Overrides `CLIENT_URL`. Must end with `/#`.                                                          |
| `server.aiEngineUrl`                                       | `""`                                                       | Overrides `AI_ENGINE_URL`.                                                                           |
| `server.inMemoryRuleCount`                                 | `40`                                                       | `IN_MEMORY_RULE_COUNT`, number of rules cached in memory.                                            |
| `server.flushRedisOnStartup`                               | `false`                                                    | `FLUSH_REDIS_ON_STARTUP`.                                                                            |
| `server.extraEnv`                                          | `[]`                                                       | Additional environment variables.                                                                    |
| `server.route.*`                                           | see Client                                                 | Same options as `client.route`.                                                                      |
| `server.autoscaling.enabled`                               | `true`                                                     | Create the HorizontalPodAutoscaler.                                                                  |
| `server.autoscaling.minReplicas` / `maxReplicas`           | From the `server.solver` profile                           | Autoscaling range (2–5 for `aero`, 2–10 for `gaia`). Overrides the profile when set.                 |
| `server.autoscaling.targetCPUUtilizationPercentage`        | `60`                                                       | CPU target.                                                                                          |
| `server.startupProbe`, `livenessProbe`, `readinessProbe`   | HTTP `/health-check` on port 8080                          | Probe definitions. The startup probe gives the server up to 65 seconds to start.                     |

### AI Engine

| Value                                  | Default                                    | Description                                  |
| -------------------------------------- | ------------------------------------------ | -------------------------------------------- |
| `aiEngine.enabled`                     | `true`                                     | Deploy the AI Engine.                        |
| `aiEngine.replicaCount`                | `1`                                        | Number of pods.                              |
| `aiEngine.image.repository` / `tag`    | `decisionrules/ai-engine` / `latest`       | Image.                                       |
| `aiEngine.port`                        | `8084`                                     | Service port.                                |
| `aiEngine.provider`, `family`, `model` | `""`                                       | AI provider, model family and model.         |
| `aiEngine.additionalDataJson`          | `""`                                       | Provider-specific settings as a JSON string. |
| `aiEngine.existingSecret`              | `decisionrules-config`                     | Name of the Secret with `AIA_SECRET`.        |
| `aiEngine.resources`                   | 250m / 256Mi requests, 500m / 512Mi limits | CPU and memory.                              |

### Business Intelligence

| Value                                           | Default                                          | Description                   |
| ----------------------------------------------- | ------------------------------------------------ | ----------------------------- |
| `businessIntelligence.enabled`                  | `true`                                           | Deploy Business Intelligence. |
| `businessIntelligence.replicaCount`             | `1`                                              | Number of pods.               |
| `businessIntelligence.image.repository` / `tag` | `decisionrules/business-intelligence` / `latest` | Image.                        |
| `businessIntelligence.resources`                | 250m / 256Mi requests, 500m / 512Mi limits       | CPU and memory.               |

### Proxy

| Value                                      | Default            | Description                                                               |
| ------------------------------------------ | ------------------ | ------------------------------------------------------------------------- |
| `proxy.enabled`                            | `false`            | Inject proxy settings into the Server and the AI Engine.                  |
| `proxy.httpProxy`, `httpsProxy`, `noProxy` | `""`               | Proxy URLs and exclusions.                                                |
| `proxy.caBundle.enabled`                   | `false`            | Mount the proxy CA certificate.                                           |
| `proxy.caBundle.configMapName`             | `""`               | ConfigMap with the CA certificate. Required when `caBundle.enabled=true`. |
| `proxy.caBundle.mountPath`                 | `/etc/ssl/custom`  | Mount directory.                                                          |
| `proxy.caBundle.fileName`                  | `mitmproxy-ca.pem` | Key in the ConfigMap / file name.                                         |

## Example values

{% code title="my-values.yaml" %}
```yaml
client:
  image:
    tag: "1.26.2.1-rootless"
  route:
    host: app.example.com

server:
  image:
    tag: "1.26.2.1"
  existingSecret: decisionrules-config
  route:
    host: api.example.com
  solver: aero   # or gaia for the classic Gaia (V1) solver

aiEngine:
  enabled: true
  provider: google-vertex
  family: google
  model: gemini-3-flash-preview
  additionalDataJson: '{"location":"global"}'
  existingSecret: decisionrules-config

businessIntelligence:
  enabled: true

# Only when outbound traffic goes through a proxy
proxy:
  enabled: true
  httpProxy: "http://proxy.example.internal:8888"
  httpsProxy: "http://proxy.example.internal:8888"
  noProxy: "localhost,127.0.0.1,.svc.cluster.local"
  caBundle:
    enabled: true
    configMapName: proxy-ca
```
{% endcode %}

## Install

Create the project and the Secrets first (see [Secrets](openshift-helm-chart.md#secrets)), then install the chart:

```bash
helm repo add decisionrules-ocp https://decisionrules.github.io/helm-charts/decisionrules-ocp/
helm repo update

helm install decisionrules decisionrules-ocp/decisionrules-ocp \
  -n decisionrules \
  -f my-values.yaml
```

To apply changed values or a new chart version later:

```bash
helm upgrade decisionrules decisionrules-ocp/decisionrules-ocp -n decisionrules -f my-values.yaml
```

## Verify

```bash
oc get pods -n decisionrules
oc get routes -n decisionrules
curl -s https://api.example.com/health-check
```

All pods should be `Running` and `1/1` ready. If a pod stays in `CreateContainerConfigError`, the Secret or one of its keys is missing. Run `oc describe pod <pod-name> -n decisionrules` to see which one.
