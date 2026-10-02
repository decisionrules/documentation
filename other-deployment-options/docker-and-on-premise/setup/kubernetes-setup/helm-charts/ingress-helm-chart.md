---
description: >-
  Helm chart for deploying DecisionRules to any Kubernetes cluster with the
  NGINX Ingress Controller and cert-manager. What it deploys, what you need to
  provision separately, and how to configure it.
---

# Ingress Helm Chart

The `decisionrules-ingress` chart deploys DecisionRules to any Kubernetes cluster that runs the NGINX Ingress Controller and cert-manager. All components are exposed through a single Ingress with one hostname per component and a TLS certificate from cert-manager. All configuration, including credentials, is set in `values.yaml`.

|                 |                                                                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Chart name      | `decisionrules-ingress`                                                                                                          |
| Helm repository | `https://decisionrules.github.io/helm-charts/decisionrules-ingress/`                                                             |
| Artifact Hub    | [decisionrules-ingress](https://artifacthub.io/packages/helm/decisionrules-ingress/decisionrules-ingress)                        |
| Images          | `decisionrules/client`, `decisionrules/server`, `decisionrules/business-intelligence`, `decisionrules/ai-engine` from Docker Hub |

## What you need to provision separately

The chart deploys only the DecisionRules application. Prepare the following before you install it:

| Requirement                                                | Required | Notes                                                                                                                                                                                                       |
| ---------------------------------------------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Kubernetes cluster                                         | Yes      | Any distribution.                                                                                                                                                                                           |
| NGINX Ingress Controller                                   | Yes      | The Ingress uses the ingress class `nginx`. See step 2 of [Kubernetes Setup](../).                                                                                                                          |
| cert-manager with a ClusterIssuer named `letsencrypt-prod` | Yes      | The chart references this exact name. See steps 3 and 4 of [Kubernetes Setup](../).                                                                                                                         |
| DNS records                                                | Yes      | One hostname per component, all pointing at the external IP address of the NGINX Ingress Controller.                                                                                                        |
| MongoDB                                                    | Yes      | The main database (`MONGO_DB_URI`) and, with Business Intelligence, the audit database (`BI_MONGO_DB_URI`). For MongoDB Atlas, see [MongoDB Atlas Network Peering](../../mongodb-atlas-network-peering.md). |
| Redis                                                      | Yes      | See [Redis Connection Modes](../../../redis-connection-modes.md).                                                                                                                                           |
| DecisionRules license key                                  | Yes      | `LICENSE_KEY`                                                                                                                                                                                               |
| Outbound access to the license and distribution servers    | Yes      | See [Prerequisites](../../../prerequisites.md), or use an [Offline License](../../../offline-license.md).                                                                                                   |

The chart does not install the Ingress Controller or cert-manager, and does not create MongoDB, Redis or DNS records.

## What the chart deploys

| Component             | Resources created                                                                                                                     | Service port | Enabled      |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------------ |
| Namespace             | Namespace named after the `namespace` value                                                                                           | –            | Always       |
| Client                | Deployment `decisionrules-client`, Service `decisionrules-client-service`                                                             | 80           | Always       |
| Server                | Deployment `decisionrules-server`, Service `decisionrules-server-service`, HorizontalPodAutoscaler `decisionrules-server-autoscaling` | 8080         | Always       |
| Business Intelligence | Deployment `decisionrules-bi`, Service `decisionrules-bi-service`                                                                     | 8082         | `bi.enabled` |
| AI Engine             | Deployment `decisionrules-ai`, Service `decisionrules-ai-service`                                                                     | 8084         | `ai.enabled` |
| Ingress               | Ingress `decisionrules-ingress`                                                                                                       | –            | Always       |

The Services are cluster-internal (`ClusterIP`). The Ingress routes each hostname from `domain` to its Service:

| Hostname        | Routed to             | Included     |
| --------------- | --------------------- | ------------ |
| `domain.client` | Client                | Always       |
| `domain.api`    | Server                | Always       |
| `domain.bi`     | Business Intelligence | `bi.enabled` |
| `domain.ai`     | AI Engine             | `ai.enabled` |

The Ingress has the annotation `cert-manager.io/cluster-issuer: letsencrypt-prod`. cert-manager requests one certificate for all included hostnames and stores it in the Secret `echo-tls` in the release namespace.

{% hint style="warning" %}
The chart creates the namespace itself. Do not create it beforehand (and do not use `--create-namespace`), otherwise the installation fails because the namespace already exists.
{% endhint %}

## Credentials

`LICENSE_KEY`, `MONGO_DB_URI`, `REDIS_URL` and `BI_MONGO_DB_URI` are set in `values.yaml` (`env.server` and `env.bi`) and passed to the Deployments as plain environment variables.

{% hint style="warning" %}
The credentials are stored in plain text in your values file, in the Helm release and in the Deployment spec. Keep the values file out of version control and restrict who can read Deployments and Helm release Secrets in the namespace. If you need Secret-based configuration, use the [OpenShift](openshift-helm-chart.md) or [GKE](gke-helm-chart.md) chart, or the [Amazon EKS](amazon-eks-helm-chart.md) chart with `secrets.existingSecret`.
{% endhint %}

## Application URLs

The chart does not derive the URLs from the hostnames, so set them to match `domain`:

| Value                   | Set to                                                       |
| ----------------------- | ------------------------------------------------------------ |
| `env.server.API_URL`    | `https://<domain.api>`                                       |
| `env.server.CLIENT_URL` | `https://<domain.client>/#` (the trailing `/#` is mandatory) |
| `env.client.API_URL`    | `https://<domain.api>`                                       |
| `env.client.BI_API_URL` | `https://<domain.bi>` (only with `bi.enabled`)               |

When the AI Engine is enabled, the chart also sets `AI_ENGINE_URL` on the server to the cluster-internal address of the AI Engine Service, so you do not need to configure it.

## Optional components

<details>

<summary>Business Intelligence — <code>bi.enabled</code> (default: <code>false</code>)</summary>

* Creates the Business Intelligence Deployment and Service and adds `domain.bi` to the Ingress and its certificate.
* Requires `env.bi.BI_MONGO_DB_URI` and a DNS record for `domain.bi`.
* Set `env.client.BI_API_URL` to `https://<domain.bi>`, otherwise the client cannot use Business Intelligence features.

</details>

<details>

<summary>AI Engine — <code>ai.enabled</code> (default: <code>false</code>)</summary>

* Creates the AI Engine Deployment and Service and adds `domain.ai` to the Ingress and its certificate. It needs a DNS record for `domain.ai`, because cert-manager validates every hostname in the certificate.
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
Aero is the default from chart version 0.3.0. Earlier versions sized the server like `gaia`. When you upgrade an existing installation, set `solver: gaia` to keep the previous sizing.
{% endhint %}

## Configuration reference

| Value                                              | Default                                                  | Description                                                                                        |
| -------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `namespace`                                        | `decisionrules`                                          | Namespace the chart creates and deploys into.                                                      |
| `bi.enabled`                                       | `false`                                                  | Deploy Business Intelligence.                                                                      |
| `ai.enabled`                                       | `false`                                                  | Deploy the AI Engine.                                                                              |
| `solver`                                           | `aero`                                                   | Server sizing profile: `aero` or `gaia`, see [Server sizing](ingress-helm-chart.md#server-sizing). |
| `solverProfiles.aero`, `solverProfiles.gaia`       | see [Server sizing](ingress-helm-chart.md#server-sizing) | Server `resources`, `minReplicas` and `maxReplicas` of each profile.                               |
| `domain.client`                                    | `yourdomain.local`                                       | Client hostname.                                                                                   |
| `domain.api`                                       | `api.yourdomain.local`                                   | Server hostname.                                                                                   |
| `domain.bi`                                        | `bi.yourdomain.local`                                    | Business Intelligence hostname.                                                                    |
| `domain.ai`                                        | `ai.yourdomain.local`                                    | AI Engine hostname.                                                                                |
| `env.client.API_URL`                               | `""`                                                     | Server URL used by the client.                                                                     |
| `env.client.BI_API_URL`                            | `""`                                                     | Business Intelligence URL used by the client.                                                      |
| `env.server.API_URL`                               | `""`                                                     | Public URL of the server.                                                                          |
| `env.server.CLIENT_URL`                            | `""`                                                     | Public URL of the client, ending with `/#`.                                                        |
| `env.server.LICENSE_KEY`                           | `""`                                                     | License key.                                                                                       |
| `env.server.MONGO_DB_URI`                          | `""`                                                     | Main database connection string.                                                                   |
| `env.server.REDIS_URL`                             | `""`                                                     | Redis connection string.                                                                           |
| `env.bi.BI_MONGO_DB_URI`                           | `""`                                                     | Audit database connection string.                                                                  |
| `images.client`, `server`, `bi`, `ai`              | `decisionrules/<component>`                              | Image references. Pin a version in production, for example `decisionrules/server:1.26.2.1`.        |
| `resources.client`                                 | 250m / 128Mi requests, 500m / 256Mi limits               | CPU and memory.                                                                                    |
| `resources.server`                                 | From the `solver` profile                                | CPU and memory of the server. Overrides the profile when set.                                      |
| `resources.bi`                                     | 1 CPU / 1Gi requests, 2 CPU / 4Gi limits                 | CPU and memory.                                                                                    |
| `resources.ai`                                     | 1 CPU / 1Gi requests, 2 CPU / 2Gi limits                 | CPU and memory.                                                                                    |
| `replicaCount.client`, `server`, `bi`, `ai`        | `2` each                                                 | Number of Pods. For the server, the autoscaler takes over.                                         |
| `autoscalingServer.minReplicas` / `maxReplicas`    | From the `solver` profile                                | Server autoscaling range (2–5 for `aero`, 2–10 for `gaia`). Overrides the profile when set.        |
| `autoscalingServer.targetCPUUtilizationPercentage` | `60`                                                     | Server CPU target.                                                                                 |

{% hint style="info" %}
The server receives only the variables listed above. Other entries under `env.server` in the chart's default `values.yaml` (for example `WORKERS_NUMBER` or the timeouts) are not passed to the server by this chart and have no effect.
{% endhint %}

See [Environment Variables](../../../containers-environmental-variables.md) for details on each variable.

## Example values

{% code title="values.yaml" %}
```yaml
namespace: decisionrules

bi:
  enabled: true

ai:
  enabled: false

solver: aero   # or gaia for the classic Gaia (V1) solver

domain:
  client: app.example.com
  api: api.example.com
  bi: bi.example.com

env:
  client:
    API_URL: "https://api.example.com"
    BI_API_URL: "https://bi.example.com"
  server:
    API_URL: "https://api.example.com"
    CLIENT_URL: "https://app.example.com/#"
    LICENSE_KEY: "<YOUR_LICENSE_KEY>"
    MONGO_DB_URI: "mongodb+srv://<user>:<password>@cluster0.xxxxx.mongodb.net/decisionrules"
    REDIS_URL: "redis://<redis-host>:6379"
  bi:
    BI_MONGO_DB_URI: "mongodb+srv://<user>:<password>@cluster0.xxxxx.mongodb.net/decisionrules-audit"

images:
  client: decisionrules/client:1.26.2.1
  server: decisionrules/server:1.26.2.1
  bi: decisionrules/business-intelligence:1.4.1.1
```
{% endcode %}

## Install

Install the NGINX Ingress Controller and cert-manager, and create the `letsencrypt-prod` ClusterIssuer first (steps 2 to 4 of [Kubernetes Setup](../)). Point the DNS records at the Ingress Controller's external IP address (`kubectl get svc -n ingress-nginx`). Then install the chart:

```bash
helm repo add decisionrules-ingress https://decisionrules.github.io/helm-charts/decisionrules-ingress/
helm repo update

helm install decisionrules-ingress decisionrules-ingress/decisionrules-ingress -f values.yaml
```

## Verify

```bash
kubectl get pods -n decisionrules
kubectl get ingress,certificate -n decisionrules
curl -s https://api.example.com/health-check
```

All Pods should be `Running` and ready, and the certificate should show `READY` `True`. If the certificate stays not ready, check that every hostname in the Ingress resolves to the Ingress Controller: `kubectl describe certificate -n decisionrules`.
