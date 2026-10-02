---
description: >-
  Helm chart for deploying DecisionRules to Google Kubernetes Engine (GKE). What
  it deploys, what you need to provision separately, and how to configure it.
---

# GKE Helm Chart

The `decisionrules-gke` chart deploys DecisionRules to Google Kubernetes Engine (GKE), both Standard and Autopilot clusters. The client and the server are exposed through a single GKE Ingress (Google Cloud Application Load Balancer) with a Google-managed TLS certificate by default. All credentials are read from Kubernetes Secrets that you create yourself, so nothing sensitive is stored in values files or in the Helm release.

For a complete walkthrough including the Google Cloud infrastructure, see [Google Kubernetes Engine (GKE)](../../google-kubernetes-engine-gke.md).

|                 |                                                                                                                                                     |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Chart name      | `decisionrules-gke`                                                                                                                                 |
| Helm repository | `https://decisionrules.github.io/helm-charts/decisionrules-gke/`                                                                                    |
| Artifact Hub    | [decisionrules-gke](https://artifacthub.io/packages/helm/decisionrules-gke/decisionrules-gke)                                                       |
| Images          | `decisionrules/client` (rootless variant), `decisionrules/server`, `decisionrules/ai-engine`, `decisionrules/business-intelligence` from Docker Hub |

## What you need to provision separately

The chart deploys only the DecisionRules application. Prepare the following before you install it:

| Requirement                                               | Required                            | Notes                                                                                                                                                                                                                                                                                |
| --------------------------------------------------------- | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GKE cluster                                               | Yes                                 | Standard or Autopilot. It must be VPC-native (the default for new clusters) with the HTTP Load Balancing add-on enabled (also the default).                                                                                                                                          |
| MongoDB                                                   | Yes                                 | Two databases: the main database (`MONGO_DB_URI`) and the Business Intelligence (audit) database (`BI_MONGO_DB_URI`). They can live on the same MongoDB cluster, for example MongoDB Atlas connected through [network peering](../../mongodb-atlas-network-peering.md#google-cloud). |
| Redis                                                     | Yes                                 | For example Memorystore for Redis. Used by the server (`REDIS_URL`).                                                                                                                                                                                                                 |
| DecisionRules license key                                 | Yes                                 | `LICENSE_KEY`                                                                                                                                                                                                                                                                        |
| Kubernetes Secret with connection strings and license key | Yes                                 | See [Secrets](gke-helm-chart.md#secrets).                                                                                                                                                                                                                                            |
| Secret with the AI provider key (`AIA_SECRET`)            | Only with AI Engine                 | The AI Engine is enabled by default. See [AI Engine providers and models](../../../ai-engine-providers-and-models.md).                                                                                                                                                               |
| Two DNS names (client and API)                            | Yes, with Ingress                   | You create A records pointing at the load balancer IP.                                                                                                                                                                                                                               |
| Reserved static IP address                                | Recommended                         | Keeps the IP stable if the Ingress is recreated. Global for the external load balancer, regional for the internal one.                                                                                                                                                               |
| SSL policy, Cloud Armor policy                            | Optional                            | Referenced by name.                                                                                                                                                                                                                                                                  |
| Your own TLS certificate                                  | Optional                            | Instead of the Google-managed certificate. Required for the internal load balancer.                                                                                                                                                                                                  |
| Proxy-only subnet                                         | Only for the internal load balancer | See [Internal load balancer](gke-helm-chart.md#internal-load-balancer).                                                                                                                                                                                                              |
| Outbound proxy and a ConfigMap with its CA certificate    | Optional                            | Only when outbound traffic must go through a proxy.                                                                                                                                                                                                                                  |
| Outbound access to the license and distribution servers   | Yes                                 | See [Prerequisites](../../../prerequisites.md), or use an [Offline License](../../../offline-license.md).                                                                                                                                                                            |

The chart does not create MongoDB, Redis, Secrets, ConfigMaps, static IP addresses, DNS records or persistent volumes.

## What the chart deploys

| Component             | Resources created                                                                              | Enabled by default | Values that control it                         |
| --------------------- | ---------------------------------------------------------------------------------------------- | ------------------ | ---------------------------------------------- |
| Client                | Deployment, Service                                                                            | Yes                | `client.enabled`                               |
| Server                | Deployment, Service, HorizontalPodAutoscaler                                                   | Yes                | `server.enabled`, `server.autoscaling.enabled` |
| AI Engine             | Deployment, Service (cluster-internal only)                                                    | Yes                | `aiEngine.enabled`                             |
| Business Intelligence | Deployment (no Service)                                                                        | Yes                | `businessIntelligence.enabled`                 |
| Load balancer         | Ingress, ManagedCertificate, FrontendConfig, BackendConfig (one per client and server Service) | Yes                | `ingress.*`                                    |

Resources are named after the Helm release, for example `<release>-server`, `<release>-server-service` and `<release>-ingress`.

When the Ingress is enabled:

* One **Ingress** routes `ingress.hosts.client` to the client and `ingress.hosts.server` to the server, so a single load balancer with one IP address serves both.
* The client and server **Services** use container-native load balancing (network endpoint groups).
* A **BackendConfig** per Service sets the load balancer health check explicitly: `/health-check` on the server, `/` on the client.
* A **ManagedCertificate** requests a Google-managed certificate for both hostnames.
* A **FrontendConfig** redirects HTTP to HTTPS and applies an optional SSL policy.

## Secrets

The chart reads credentials from existing Kubernetes Secrets in the release namespace. You set only the **name** of the Secret in the values, never the values themselves.

| Value                     | Default                | Secret keys                                                   |
| ------------------------- | ---------------------- | ------------------------------------------------------------- |
| `server.existingSecret`   | `decisionrules-config` | `MONGO_DB_URI`, `BI_MONGO_DB_URI`, `REDIS_URL`, `LICENSE_KEY` |
| `aiEngine.existingSecret` | `decisionrules-config` | `AIA_SECRET` (only when `aiEngine.enabled=true`)              |

{% hint style="warning" %}
All four connection keys must be present, even if you disable Business Intelligence. The server always reads `BI_MONGO_DB_URI`, and a missing key keeps the pod from starting.
{% endhint %}

```bash
kubectl create namespace decisionrules

kubectl create secret generic decisionrules-config -n decisionrules \
  --from-literal=MONGO_DB_URI='mongodb+srv://user:password@cluster0-pri.example.mongodb.net/decisionrules' \
  --from-literal=BI_MONGO_DB_URI='mongodb+srv://user:password@cluster0-pri.example.mongodb.net/decisionrules-audit' \
  --from-literal=REDIS_URL='redis://10.10.0.3:6379' \
  --from-literal=LICENSE_KEY='YOUR-LICENSE-KEY' \
  --from-literal=AIA_SECRET='YOUR-AI-PROVIDER-KEY'
```

The chart fails to render with a clear error message when `server.existingSecret` is empty, or when `aiEngine.existingSecret` is empty while the AI Engine is enabled.

### Using Google Secret Manager

For production, keep the credentials in Google Secret Manager and sync them into the cluster with the [External Secrets Operator](https://external-secrets.io/), authenticated through Workload Identity. The Kubernetes ServiceAccount used by the SecretStore needs the `roles/secretmanager.secretAccessor` role on the secrets.

```yaml
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: gcp-secret-manager
  namespace: decisionrules
spec:
  provider:
    gcpsm:
      projectID: my-gcp-project
      auth:
        workloadIdentity:
          clusterLocation: europe-west1
          clusterName: my-gke-cluster
          serviceAccountRef:
            name: external-secrets-sa
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
    name: gcp-secret-manager
  target:
    name: decisionrules-config   # the Kubernetes Secret the chart reads
  data:
    - secretKey: MONGO_DB_URI
      remoteRef:
        key: decisionrules-mongo-db-uri   # Secret Manager secret names
    - secretKey: BI_MONGO_DB_URI
      remoteRef:
        key: decisionrules-bi-mongo-db-uri
    - secretKey: REDIS_URL
      remoteRef:
        key: decisionrules-redis-url
    - secretKey: LICENSE_KEY
      remoteRef:
        key: decisionrules-license-key
    - secretKey: AIA_SECRET
      remoteRef:
        key: decisionrules-aia-secret
```

## Exposing the application

### Default: external load balancer with a Google-managed certificate

With the defaults, you only set the two hostnames (and, ideally, a reserved static IP address):

```yaml
ingress:
  hosts:
    client: app.example.com
    server: api.example.com
  staticIpName: decisionrules-ip
```

After installation, point DNS A records for both hostnames at the load balancer IP address. Google provisions the certificate only after DNS resolves to the load balancer, which usually takes 15 to 60 minutes. Until the certificate is `Active`, HTTPS requests fail and HTTP requests are redirected to HTTPS.

### Your own certificate

Disable the managed certificate and reference either a Kubernetes TLS Secret or certificates already uploaded to Google Cloud:

```yaml
ingress:
  tls:
    managedCertificate:
      enabled: false
    secretName: decisionrules-tls        # Kubernetes TLS Secret
    # or
    preSharedCerts: my-cert-1,my-cert-2  # Google Cloud SSL certificates
```

### Internal load balancer

For a deployment that is reachable only from your VPC (and connected networks), use the internal Application Load Balancer (`gce-internal`). It needs a [proxy-only subnet](https://cloud.google.com/load-balancing/docs/proxy-only-subnets) in the cluster's region. Google-managed certificates are not supported by the internal load balancer, and the chart applies the HTTPS redirect and the SSL policy (FrontendConfig) only to the external one. Provide your own certificate:

```yaml
ingress:
  className: gce-internal
  staticIpName: decisionrules-internal-ip   # regional address
  hosts:
    client: app.internal.example.com
    server: api.internal.example.com
  tls:
    managedCertificate:
      enabled: false
    secretName: decisionrules-tls
```

{% hint style="info" %}
The chart refuses to render when the managed certificate is enabled together with `className: gce-internal`, so the combination cannot be deployed by accident.
{% endhint %}

### Your own ingress or Gateway API

Set `ingress.enabled=false` to expose the Services yourself, for example with Gateway API `HTTPRoute` resources. In that case the chart cannot derive the public URLs, so you must set them explicitly:

```yaml
ingress:
  enabled: false

server:
  apiUrl: https://api.example.com
  clientUrl: https://app.example.com/#
```

The Services are `<release>-client-service` (port 4000) and `<release>-server-service` (port 8080).

## Application URLs

| Variable        | Set on         | Taken from (first match wins)                                                                           |
| --------------- | -------------- | ------------------------------------------------------------------------------------------------------- |
| `API_URL`       | Server, Client | `server.apiUrl` (for the client `client.apiUrl` takes precedence) → `<scheme>://<ingress.hosts.server>` |
| `CLIENT_URL`    | Server         | `server.clientUrl` → `<scheme>://<ingress.hosts.client>/#`                                              |
| `AI_ENGINE_URL` | Server         | `server.aiEngineUrl` → internal AI Engine Service URL (only when the AI Engine is enabled)              |

The scheme is `https` when a certificate is configured (managed certificate, `tls.secretName` or `tls.preSharedCerts`), otherwise `http`. If the Ingress or the corresponding component is disabled and no explicit URL is set, the chart fails with an error message instead of using a placeholder.

## Server sizing

The `server.solver` value sizes the server for the rule solver you use:

| `server.solver`  | Use for                                 | Server CPU / memory per Pod                      | Autoscaling |
| ---------------- | --------------------------------------- | ------------------------------------------------ | ----------- |
| `aero` (default) | Aero (V2) solver or mixed V1/V2 traffic | `4000m` / `4Gi` (requests = limits)              | 2–5 Pods    |
| `gaia`           | Gaia (V1) solver only                   | `1000m` / `1Gi` requests, `2000m` / `2Gi` limits | 2–10 Pods   |

Aero uses several CPUs within one process, so it runs best on fewer, larger replicas. The profiles are defined in `server.solverProfiles` in the chart's `values.yaml`, so you can adjust them, for example `--set server.solverProfiles.aero.maxReplicas=8`. To size the server yourself regardless of the profile, set `server.resources` and `server.autoscaling.minReplicas` / `maxReplicas`; they take precedence over the profile. See [server sizing](../../../../../decisionrules-applications/server-app.md#minimal-requirements) for scaling and resource reserve.

On GKE Autopilot you pay for the requested resources, so the `aero` profile with two server Pods requests 8 vCPU and 8 GiB for the server alone.

## Security context

GKE does not enforce non-root containers by default, so the chart sets a security context for every component. It is compatible with the Kubernetes `restricted` Pod Security Standard and with typical Policy Controller / Gatekeeper rules:

* `runAsNonRoot: true` with the image's user ID: `runAsUser: 100` for the client, server and Business Intelligence, `999` for the AI Engine
* `seccompProfile: RuntimeDefault`
* `allowPrivilegeEscalation: false` and all Linux capabilities dropped

The client must use a rootless image tag (for example `1.26.2.1-rootless`), which listens on port 4000. To remove a security context, set it to `null`. An empty `{}` is merged with the defaults and has no effect:

```yaml
server:
  podSecurityContext: null
  securityContext: null
```

## Optional features

What changes when you turn each feature on or off:

<details>

<summary>AI Engine — <code>aiEngine.enabled</code> (default: <code>true</code>)</summary>

* Creates the AI Engine Deployment and a cluster-internal Service `<release>-ai-engine-service` on port 8084. It is not exposed through the Ingress.
* Sets `AI_ENGINE_URL` on the server to the internal Service URL. Override it with `server.aiEngineUrl`.
* Requires `aiEngine.existingSecret` pointing to a Secret with the `AIA_SECRET` key.
* The provider settings are passed as environment variables: `aiEngine.provider` → `AIA_PROVIDER`, `aiEngine.family` → `AIA_FAMILY`, `aiEngine.model` → `AIA_MODEL`, `aiEngine.additionalDataJson` → `AIA_ADDITIONAL_DATA_JSON`. See [AI Engine providers and models](../../../ai-engine-providers-and-models.md).
* Set it to `false` if your license does not include the AI Assistant or you do not want to run it.

</details>

<details>

<summary>Business Intelligence — <code>businessIntelligence.enabled</code> (default: <code>true</code>)</summary>

* Creates the Business Intelligence Deployment. It reads `MONGO_DB_URI` and `BI_MONGO_DB_URI` from the connection Secret.
* No Service is created and it is not exposed through the Ingress.

</details>

<details>

<summary>Server autoscaling — <code>server.autoscaling.enabled</code> (default: <code>true</code>)</summary>

* Creates a HorizontalPodAutoscaler for the server, scaling at 60 % average CPU utilization. The range comes from the solver profile: 2 to 5 replicas for `aero` (default), 2 to 10 for `gaia`, see [Server sizing](gke-helm-chart.md#server-sizing).
* While autoscaling is enabled, `server.replicaCount` is ignored.

</details>

<details>

<summary>Ingress — <code>ingress.enabled</code> (default: <code>true</code>)</summary>

* Creates the Ingress, the BackendConfigs and, depending on the TLS settings, the ManagedCertificate and the FrontendConfig.
* Adds the container-native load balancing and BackendConfig annotations to the client and server Services.
* When disabled, the Services are plain ClusterIP Services and `server.apiUrl` and `server.clientUrl` are required.

</details>

<details>

<summary>Outbound proxy — <code>proxy.enabled</code> (default: <code>false</code>)</summary>

* Sets `HTTP_PROXY`, `HTTPS_PROXY` and `NO_PROXY` on the Server and the AI Engine. Business Intelligence does not get proxy settings.
* With `proxy.caBundle.enabled=true` and `proxy.caBundle.configMapName` set, the chart mounts that ConfigMap into the Server and AI Engine pods at `proxy.caBundle.mountPath` (default `/etc/ssl/custom`). The ConfigMap must contain a key named after `proxy.caBundle.fileName` (default `mitmproxy-ca.pem`).
* The certificate path is passed to the Server as `PROXY_CA_BUNDLE_PATH` and to the AI Engine as `SSL_CERT_FILE` and `REQUESTS_CA_BUNDLE`.

</details>

<details>

<summary>Extra server environment variables — <code>server.extraEnv</code></summary>

* A list of `name` / `value` pairs added to the server container, for any variable from [Environment Variables](../../../containers-environmental-variables.md) that the chart does not set itself (for example `REDIS_MODE` or SSO settings).
* Values are stored in plain text in the Deployment. Do not put credentials here.

</details>

## Configuration reference

### Ingress

| Value                                    | Default | Description                                                                         |
| ---------------------------------------- | ------- | ----------------------------------------------------------------------------------- |
| `ingress.enabled`                        | `true`  | Create the Ingress and related GKE resources.                                       |
| `ingress.className`                      | `gce`   | `gce` for the external load balancer, `gce-internal` for the internal one.          |
| `ingress.hosts.client`                   | `""`    | Client hostname. Required when the Ingress is enabled.                              |
| `ingress.hosts.server`                   | `""`    | API hostname. Required when the Ingress is enabled.                                 |
| `ingress.staticIpName`                   | `""`    | Name of a reserved static IP address. Empty means an ephemeral IP.                  |
| `ingress.tls.managedCertificate.enabled` | `true`  | Google-managed certificate for both hostnames. `gce` only.                          |
| `ingress.tls.secretName`                 | `""`    | Kubernetes TLS Secret with your own certificate.                                    |
| `ingress.tls.preSharedCerts`             | `""`    | Comma-separated names of Google Cloud SSL certificates.                             |
| `ingress.tls.redirectToHttps`            | `true`  | Redirect HTTP to HTTPS. `gce` only, applied only when a certificate is configured.  |
| `ingress.tls.sslPolicy`                  | `""`    | Google Cloud SSL policy name, for example one enforcing TLS 1.2+. `gce` only.       |
| `ingress.backendConfig.timeoutSec`       | `30`    | Load balancer backend timeout in seconds.                                           |
| `ingress.backendConfig.securityPolicy`   | `""`    | Cloud Armor security policy name. `gce` only.                                       |
| `ingress.annotations`                    | `{}`    | Extra Ingress annotations, for example `kubernetes.io/ingress.allow-http: "false"`. |

### Client

| Value                                                 | Default                                                    | Description                                          |
| ----------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| `client.enabled`                                      | `true`                                                     | Deploy the client.                                   |
| `client.replicaCount`                                 | `2`                                                        | Number of client pods.                               |
| `client.image.repository` / `tag`                     | `decisionrules/client` / `latest-rootless`                 | Use a rootless tag, for example `1.26.2.1-rootless`. |
| `client.port`                                         | `4000`                                                     | Port the rootless image listens on.                  |
| `client.apiUrl`                                       | `""`                                                       | Overrides `API_URL` for the client only.             |
| `client.resources`                                    | 250m / 128Mi requests, 500m / 256Mi limits                 | CPU and memory.                                      |
| `client.podSecurityContext`, `client.securityContext` | see [Security context](gke-helm-chart.md#security-context) | Pod and container security context.                  |

### Server

| Value                                                      | Default                                                    | Description                                                                                    |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `server.enabled`                                           | `true`                                                     | Deploy the server.                                                                             |
| `server.replicaCount`                                      | `2`                                                        | Number of server pods when autoscaling is disabled.                                            |
| `server.image.repository` / `tag`                          | `decisionrules/server` / `latest`                          | Pin a version in production, for example `1.26.2.1`.                                           |
| `server.port`                                              | `8080`                                                     | Server port.                                                                                   |
| `server.solver`                                            | `aero`                                                     | Server sizing profile: `aero` or `gaia`, see [Server sizing](gke-helm-chart.md#server-sizing). |
| `server.solverProfiles.aero`, `server.solverProfiles.gaia` | see [Server sizing](gke-helm-chart.md#server-sizing)       | Server `resources`, `minReplicas` and `maxReplicas` of each profile.                           |
| `server.resources`                                         | From the `server.solver` profile                           | CPU and memory of the server. Overrides the profile when set.                                  |
| `server.existingSecret`                                    | `decisionrules-config`                                     | Name of the connection Secret. Required.                                                       |
| `server.apiUrl`                                            | `""`                                                       | Overrides `API_URL`. Required when the Ingress is disabled.                                    |
| `server.clientUrl`                                         | `""`                                                       | Overrides `CLIENT_URL`. Must end with `/#`. Required when the Ingress is disabled.             |
| `server.aiEngineUrl`                                       | `""`                                                       | Overrides `AI_ENGINE_URL`.                                                                     |
| `server.inMemoryRuleCount`                                 | `40`                                                       | `IN_MEMORY_RULE_COUNT`, number of rules cached in memory.                                      |
| `server.flushRedisOnStartup`                               | `false`                                                    | `FLUSH_REDIS_ON_STARTUP`.                                                                      |
| `server.extraEnv`                                          | `[]`                                                       | Additional environment variables.                                                              |
| `server.autoscaling.enabled`                               | `true`                                                     | Create the HorizontalPodAutoscaler.                                                            |
| `server.autoscaling.minReplicas` / `maxReplicas`           | From the `server.solver` profile                           | Autoscaling range (2–5 for `aero`, 2–10 for `gaia`). Overrides the profile when set.           |
| `server.autoscaling.targetCPUUtilizationPercentage`        | `60`                                                       | CPU target.                                                                                    |
| `server.podSecurityContext`, `server.securityContext`      | see [Security context](gke-helm-chart.md#security-context) | Pod and container security context.                                                            |
| `server.startupProbe`, `livenessProbe`, `readinessProbe`   | HTTP `/health-check` on port 8080                          | Probe definitions. The startup probe gives the server up to 65 seconds to start.               |

### AI Engine

| Value                                                     | Default                                                    | Description                                  |
| --------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------- |
| `aiEngine.enabled`                                        | `true`                                                     | Deploy the AI Engine.                        |
| `aiEngine.replicaCount`                                   | `1`                                                        | Number of pods.                              |
| `aiEngine.image.repository` / `tag`                       | `decisionrules/ai-engine` / `latest`                       | Image.                                       |
| `aiEngine.port`                                           | `8084`                                                     | Service port.                                |
| `aiEngine.provider`, `family`, `model`                    | `""`                                                       | AI provider, model family and model.         |
| `aiEngine.additionalDataJson`                             | `""`                                                       | Provider-specific settings as a JSON string. |
| `aiEngine.existingSecret`                                 | `decisionrules-config`                                     | Name of the Secret with `AIA_SECRET`.        |
| `aiEngine.resources`                                      | 250m / 256Mi requests, 500m / 512Mi limits                 | CPU and memory.                              |
| `aiEngine.podSecurityContext`, `aiEngine.securityContext` | see [Security context](gke-helm-chart.md#security-context) | Pod and container security context.          |

### Business Intelligence

| Value                                                                             | Default                                                    | Description                         |
| --------------------------------------------------------------------------------- | ---------------------------------------------------------- | ----------------------------------- |
| `businessIntelligence.enabled`                                                    | `true`                                                     | Deploy Business Intelligence.       |
| `businessIntelligence.replicaCount`                                               | `1`                                                        | Number of pods.                     |
| `businessIntelligence.image.repository` / `tag`                                   | `decisionrules/business-intelligence` / `latest`           | Image.                              |
| `businessIntelligence.resources`                                                  | 250m / 256Mi requests, 500m / 512Mi limits                 | CPU and memory.                     |
| `businessIntelligence.podSecurityContext`, `businessIntelligence.securityContext` | see [Security context](gke-helm-chart.md#security-context) | Pod and container security context. |

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
ingress:
  hosts:
    client: app.example.com
    server: api.example.com
  staticIpName: decisionrules-ip
  tls:
    sslPolicy: decisionrules-tls12   # optional

client:
  image:
    tag: "1.26.2.1-rootless"

server:
  image:
    tag: "1.26.2.1"
  existingSecret: decisionrules-config
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
```
{% endcode %}

## Install

Create the namespace and the Secrets first (see [Secrets](gke-helm-chart.md#secrets)), then install the chart:

```bash
helm repo add decisionrules-gke https://decisionrules.github.io/helm-charts/decisionrules-gke/
helm repo update

helm install decisionrules decisionrules-gke/decisionrules-gke \
  -n decisionrules \
  -f my-values.yaml
```

To apply changed values or a new chart version later:

```bash
helm upgrade decisionrules decisionrules-gke/decisionrules-gke -n decisionrules -f my-values.yaml
```

## Verify

```bash
kubectl get pods -n decisionrules
kubectl get ingress,managedcertificate -n decisionrules
curl -s https://api.example.com/health-check
```

The post-install notes printed by Helm list the exact commands for your release. For the expected timeline and common issues, see [Last checks & Troubleshooting](../../google-kubernetes-engine-gke.md#last-checks-and-troubleshooting) in the GKE deployment guide.

## MongoDB Atlas

MongoDB Atlas is a common choice for the database on GKE. Connect it privately with VPC network peering, use the private connection string (with `-pri` in the hostname), and add the cluster's Pod IP range to the Atlas IP access list. GKE Pods keep their own IP addresses when they talk to a peered network, so the Pod range, not only the node range, is what Atlas sees. See the [Google Cloud section of MongoDB Atlas Network Peering](../../mongodb-atlas-network-peering.md#google-cloud) for step-by-step instructions.
