---
description: >-
  Helm chart for deploying DecisionRules to Amazon EKS. What it deploys, what
  you need to provision separately, and how to configure it.
---

# Amazon EKS Helm Chart

The `decisionrules-eks` chart deploys DecisionRules to Amazon Elastic Kubernetes Service (EKS). Every component gets its own internet-facing Network Load Balancer. Credentials can be read from an existing Kubernetes Secret (recommended) or set directly in `values.yaml`.

|                 |                                                                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Chart name      | `decisionrules-eks`                                                                                                              |
| Helm repository | `https://decisionrules.github.io/helm-charts/decisionrules-eks/`                                                                 |
| Artifact Hub    | [decisionrules-eks](https://artifacthub.io/packages/helm/decisionrules-eks/decisionrules-eks)                                    |
| Images          | `decisionrules/client`, `decisionrules/server`, `decisionrules/business-intelligence`, `decisionrules/ai-engine` from Docker Hub |

## What you need to provision separately

The chart deploys only the DecisionRules application. Prepare the following before you install it:

| Requirement                                             | Required    | Notes                                                                                                                                                                                                           |
| ------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| EKS cluster with **EKS Auto Mode**                      | Yes         | The Services use the load balancer class `eks.amazonaws.com/nlb`, which is provided by EKS Auto Mode.                                                                                                           |
| MongoDB                                                 | Yes         | The main database (`MONGO_DB_URI`) and, with Business Intelligence, the audit database (`BI_MONGO_DB_URI`). For MongoDB Atlas, see [MongoDB Atlas Network Peering](../../mongodb-atlas-network-peering.md#aws). |
| Redis                                                   | Yes         | For example Amazon ElastiCache, see [Cache - Amazon ElastiCache](../../aws/cache-amazon-elasticache.md).                                                                                                        |
| DecisionRules license key                               | Yes         | `LICENSE_KEY`                                                                                                                                                                                                   |
| Kubernetes Secret with the credentials                  | Recommended | See [Credentials](amazon-eks-helm-chart.md#credentials).                                                                                                                                                        |
| DNS names and TLS                                       | Optional    | The chart publishes plain HTTP on port 80 of each load balancer. It does not configure TLS or DNS.                                                                                                              |
| Outbound access to the license and distribution servers | Yes         | See [Prerequisites](../../../prerequisites.md), or use an [Offline License](../../../offline-license.md).                                                                                                       |

The chart does not create MongoDB, Redis, Secrets, DNS records or TLS certificates.

## What the chart deploys

| Component             | Resources created                                                                                                                     | Load balancer                 | Enabled      |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- | ------------ |
| Namespace             | Namespace named after the `namespace` value                                                                                           | –                             | Always       |
| Client                | Deployment `decisionrules-client`, Service `decisionrules-client-service`                                                             | Port 80 → container port 80   | Always       |
| Server                | Deployment `decisionrules-server`, Service `decisionrules-server-service`, HorizontalPodAutoscaler `decisionrules-server-autoscaling` | Port 80 → container port 8080 | Always       |
| Business Intelligence | Deployment `decisionrules-bi`, Service `decisionrules-bi-service`                                                                     | Port 80 → container port 8082 | `bi.enabled` |
| AI Engine             | Deployment `decisionrules-ai`, Service `decisionrules-ai-service`                                                                     | Port 80 → container port 8084 | `ai.enabled` |

All Services are of type `LoadBalancer` with the annotation `service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing`, so each of them gets a public Network Load Balancer.

{% hint style="warning" %}
The chart creates the namespace itself. Do not create it beforehand (and do not use `--create-namespace`), otherwise the installation fails because the namespace already exists.
{% endhint %}

## Credentials

The sensitive values are `LICENSE_KEY`, `MONGO_DB_URI`, `REDIS_URL` and, with Business Intelligence, `BI_MONGO_DB_URI`. You can provide them in two ways.

### Existing Secret (recommended)

Set `secrets.existingSecret` to the name of a Kubernetes Secret with these keys. The chart then reads them with `secretKeyRef`, and the corresponding values in `env` are ignored. The credentials never appear in your values file, in the Helm release or in the Deployment spec.

```yaml
secrets:
  existingSecret: decisionrules-config
```

Because the chart creates the namespace, install the chart first and create the Secret right after it. The server Pods wait in `CreateContainerConfigError` until the Secret exists and then start on their own.

```bash
kubectl create secret generic decisionrules-config -n decisionrules \
  --from-literal=LICENSE_KEY='YOUR-LICENSE-KEY' \
  --from-literal=MONGO_DB_URI='mongodb+srv://user:password@cluster0.example.mongodb.net/decisionrules' \
  --from-literal=REDIS_URL='rediss://master.example.cache.amazonaws.com:6379' \
  --from-literal=BI_MONGO_DB_URI='mongodb+srv://user:password@cluster0.example.mongodb.net/decisionrules-audit'
```

`BI_MONGO_DB_URI` is only required when `bi.enabled=true`.

<details>

<summary>Syncing the Secret from AWS Secrets Manager</summary>

With the [External Secrets Operator](https://external-secrets.io/) and IAM Roles for Service Accounts (IRSA), you can keep the credentials in AWS Secrets Manager:

```yaml
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: aws-secrets-manager
  namespace: decisionrules
spec:
  provider:
    aws:
      service: SecretsManager
      region: eu-central-1
      auth:
        jwt:
          serviceAccountRef:
            name: external-secrets-sa   # ServiceAccount annotated with an IAM role
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: decisionrules-config
  namespace: decisionrules
spec:
  refreshInterval: 1h
  secretStoreRef:
    kind: SecretStore
    name: aws-secrets-manager
  target:
    name: decisionrules-config
  data:
    - secretKey: LICENSE_KEY
      remoteRef:
        key: decisionrules/prod
        property: LICENSE_KEY
    - secretKey: MONGO_DB_URI
      remoteRef:
        key: decisionrules/prod
        property: MONGO_DB_URI
    - secretKey: REDIS_URL
      remoteRef:
        key: decisionrules/prod
        property: REDIS_URL
    - secretKey: BI_MONGO_DB_URI
      remoteRef:
        key: decisionrules/prod
        property: BI_MONGO_DB_URI
```

</details>

### Values in values.yaml

If `secrets.existingSecret` is empty, the chart puts `env.server.LICENSE_KEY`, `env.server.MONGO_DB_URI`, `env.server.REDIS_URL` and `env.bi.BI_MONGO_DB_URI` directly into the Deployments. This is fine for evaluation, but not recommended for production: the credentials are stored in plain text in your values file, in the Helm release and in the Deployment spec.

## Application URLs

The client and the server need to know their public URLs. The chart does not derive them, so you set them yourself:

| Value                   | Meaning                                                      |
| ----------------------- | ------------------------------------------------------------ |
| `env.server.API_URL`    | Public URL of the server                                     |
| `env.server.CLIENT_URL` | Public URL of the client, ending with `/#`                   |
| `env.client.API_URL`    | Public URL of the server, as called from the browser         |
| `env.client.BI_API_URL` | Public URL of Business Intelligence (only with `bi.enabled`) |

The load balancer hostnames exist only after the first installation. The usual order is:

1. Install the chart with the URLs left empty.
2. Read the load balancer hostnames from the `EXTERNAL-IP` column of `kubectl get svc -n decisionrules`. Optionally create DNS records for them.
3. Set the URLs in your values file and run `helm upgrade`.

When the AI Engine is enabled, the chart also sets `AI_ENGINE_URL` on the server to the cluster-internal address of the AI Engine Service, so you do not need to configure it.

## Optional components

<details>

<summary>Business Intelligence — <code>bi.enabled</code> (default: <code>false</code>)</summary>

* Creates the Business Intelligence Deployment and its own public load balancer.
* Requires `BI_MONGO_DB_URI` (in the Secret or in `env.bi`).
* Set `env.client.BI_API_URL` to the address of the BI load balancer, otherwise the client cannot use Business Intelligence features.

</details>

<details>

<summary>AI Engine — <code>ai.enabled</code> (default: <code>false</code>)</summary>

* Creates the AI Engine Deployment and its own public load balancer.
* Sets `AI_ENGINE_URL` on the server automatically.
* The chart does not pass any AI provider settings to the AI Engine. Configure the AI provider in DecisionRules, see [AI Assistant Provider](../../../../../environment/ai-assistant-provider.md) and [AI Engine providers and models](../../../ai-engine-providers-and-models.md).

</details>

## Server sizing

The `solver` value sizes the server for the rule solver you use:

| `solver`         | Use for                                 | Server CPU / memory per Pod                      | Autoscaling |
| ---------------- | --------------------------------------- | ------------------------------------------------ | ----------- |
| `aero` (default) | Aero (V2) solver or mixed V1/V2 traffic | `4000m` / `4Gi` (requests = limits)              | 2–5 Pods    |
| `gaia`           | Gaia (V1) solver only                   | `1000m` / `1Gi` requests, `2000m` / `2Gi` limits | 2–10 Pods   |

Aero uses several CPUs within one process, so it runs best on fewer, larger replicas. The profiles are defined in `solverProfiles` in the chart's `values.yaml`, so you can adjust them, for example `--set solverProfiles.aero.maxReplicas=8`. To size the server yourself regardless of the profile, set `resources.server` and `autoscalingServer.minReplicas` / `maxReplicas`; they take precedence over the profile. See [server sizing](../../../../../decisionrules-applications/server-app.md#minimal-requirements) for scaling and resource reserve.

{% hint style="warning" %}
Aero is the default from chart version 0.4.0. Earlier versions sized the server like `gaia`. When you upgrade an existing installation, set `solver: gaia` to keep the previous sizing.
{% endhint %}

## Configuration reference

| Value                                                 | Default                                                     | Description                                                                                           |
| ----------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `namespace`                                           | `decisionrules`                                             | Namespace the chart creates and deploys into.                                                         |
| `secrets.existingSecret`                              | `""`                                                        | Name of the Secret with the credentials. Empty means plain values from `env`.                         |
| `bi.enabled`                                          | `false`                                                     | Deploy Business Intelligence.                                                                         |
| `ai.enabled`                                          | `false`                                                     | Deploy the AI Engine.                                                                                 |
| `solver`                                              | `aero`                                                      | Server sizing profile: `aero` or `gaia`, see [Server sizing](amazon-eks-helm-chart.md#server-sizing). |
| `solverProfiles.aero`, `solverProfiles.gaia`          | see [Server sizing](amazon-eks-helm-chart.md#server-sizing) | Server `resources`, `minReplicas` and `maxReplicas` of each profile.                                  |
| `env.client.API_URL`                                  | `""`                                                        | Server URL used by the client.                                                                        |
| `env.client.BI_API_URL`                               | `""`                                                        | Business Intelligence URL used by the client.                                                         |
| `env.server.API_URL`                                  | `""`                                                        | Public URL of the server.                                                                             |
| `env.server.CLIENT_URL`                               | `""`                                                        | Public URL of the client, ending with `/#`.                                                           |
| `env.server.LICENSE_KEY`, `MONGO_DB_URI`, `REDIS_URL` | `""`                                                        | Credentials, ignored when `secrets.existingSecret` is set.                                            |
| `env.server.WORKERS_NUMBER`                           | `"1"`                                                       | Number of server worker processes.                                                                    |
| `env.server.RF_TIMEOUT`                               | `"5000"`                                                    | Rule Flow timeout in milliseconds.                                                                    |
| `env.server.SR_TIMEOUT`                               | `"5000"`                                                    | Rule solve timeout in milliseconds.                                                                   |
| `env.server.WORKFLOW_TIMEOUT`                         | `"10000"`                                                   | Workflow timeout in milliseconds.                                                                     |
| `env.server.FLUSH_REDIS_ON_STARTUP`                   | `"false"`                                                   | Flush Redis when the server starts.                                                                   |
| `env.server.IN_MEMORY_RULE_COUNT`                     | `"100"`                                                     | Number of rules cached in memory.                                                                     |
| `env.server.CONNECTION_TIMEOUT`                       | `"60000"`                                                   | Connection timeout in milliseconds.                                                                   |
| `env.server.REDIS_PING_INTERVAL`                      | `"300000"`                                                  | Interval of Redis keep-alive pings in milliseconds.                                                   |
| `env.bi.BI_MONGO_DB_URI`                              | `""`                                                        | Audit database, ignored when `secrets.existingSecret` is set.                                         |
| `images.client`, `server`, `bi`, `ai`                 | `decisionrules/<component>`                                 | Image references. Pin a version in production, for example `decisionrules/server:1.26.2.1`.           |
| `resources.client`                                    | 250m / 128Mi requests, 500m / 256Mi limits                  | CPU and memory.                                                                                       |
| `resources.server`                                    | From the `solver` profile                                   | CPU and memory of the server. Overrides the profile when set.                                         |
| `resources.bi`                                        | 1 CPU / 1Gi requests, 2 CPU / 4Gi limits                    | CPU and memory.                                                                                       |
| `resources.ai`                                        | 1 CPU / 1Gi requests, 2 CPU / 2Gi limits                    | CPU and memory.                                                                                       |
| `replicaCount.client`, `server`, `bi`, `ai`           | `2` each                                                    | Number of Pods. For the server, the autoscaler takes over.                                            |
| `autoscalingServer.minReplicas` / `maxReplicas`       | From the `solver` profile                                   | Server autoscaling range (2–5 for `aero`, 2–10 for `gaia`). Overrides the profile when set.           |
| `autoscalingServer.targetCPUUtilizationPercentage`    | `60`                                                        | Server CPU target.                                                                                    |

See [Environment Variables](../../../containers-environmental-variables.md) for details on each variable.

## Example values

{% code title="values.yaml" %}
```yaml
namespace: decisionrules

secrets:
  existingSecret: decisionrules-config

bi:
  enabled: true

ai:
  enabled: false

solver: aero   # or gaia for the classic Gaia (V1) solver

env:
  client:
    API_URL: "https://api.example.com"
    BI_API_URL: "https://bi.example.com"
  server:
    API_URL: "https://api.example.com"
    CLIENT_URL: "https://app.example.com/#"

images:
  client: decisionrules/client:1.26.2.1
  server: decisionrules/server:1.26.2.1
  bi: decisionrules/business-intelligence:1.4.1.1
```
{% endcode %}

## Install

```bash
helm repo add decisionrules-eks https://decisionrules.github.io/helm-charts/decisionrules-eks/
helm repo update

helm install decisionrules-eks decisionrules-eks/decisionrules-eks -f values.yaml
```

Then create the Secret (see [Credentials](amazon-eks-helm-chart.md#credentials)), read the load balancer addresses and, if needed, update the URLs:

```bash
kubectl get svc -n decisionrules

helm upgrade decisionrules-eks decisionrules-eks/decisionrules-eks -f values.yaml
```

## Verify

```bash
kubectl get pods -n decisionrules
curl -s <SERVER_URL>/health-check
```

All Pods should be `Running` and ready. If a Pod stays in `CreateContainerConfigError`, the Secret or one of its keys is missing.
