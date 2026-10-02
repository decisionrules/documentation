---
description: >-
  This article goes over the deployment process for the On-Premise solution of
  DecisionRules on Google Kubernetes Engine (GKE) using the official Helm chart.
icon: google
---

# Google Kubernetes Engine (GKE)

This tutorial deploys DecisionRules to Google Kubernetes Engine with the official `decisionrules-gke` Helm chart. The application is exposed through a GKE Ingress (Google Cloud Application Load Balancer) with a Google-managed TLS certificate. The database runs in MongoDB Atlas, connected to your VPC through network peering, and the cache runs in Memorystore for Redis, reachable only from your VPC. If your use case doesn't call for strict network security, you can use a publicly reachable MongoDB instead and skip the peering step, which makes the deployment faster.

The following steps might differ depending on your level of security and the sophistication of your existing Google Cloud environment.

{% hint style="info" %}
It is possible to follow this tutorial without prior Google Cloud experience, although basic Kubernetes knowledge is recommended. If you prefer to write the Kubernetes manifests yourself instead of using Helm, see [Kubernetes Setup](kubernetes-setup/).
{% endhint %}

## Prerequisites and Recommendations

To follow this article successfully you will need the following things:

* A Google Cloud project with an active billing account.
* Permissions to create GKE clusters, Memorystore instances, IP addresses and VPC peerings in the project (for example the Owner or Editor role, or Kubernetes Engine Admin, Compute Network Admin and Cloud Memorystore Redis Admin).
* A MongoDB Atlas account with a dedicated cluster (M10 or larger) in the same Google Cloud region, or another MongoDB database reachable from the cluster.
* A DecisionRules license key.
* Two DNS names you can create records for, one for the client and one for the API, for example `app.example.com` and `api.example.com`.

It is also recommended to use **Google Cloud Shell** (the **>\_** icon in the top right corner of the Google Cloud console). It has `gcloud`, `kubectl` and `helm` preinstalled, so all commands in this article can be run there without any local setup.

## List of Topics

Below are the steps our deployment will follow.

1. [Enabling the required APIs](google-kubernetes-engine-gke.md#id-1.-enabling-the-required-apis)
2. [Creating the GKE cluster](google-kubernetes-engine-gke.md#id-2.-creating-the-gke-cluster)
3. [Provisioning Memorystore for Redis](google-kubernetes-engine-gke.md#id-3.-provisioning-memorystore-for-redis)
4. [Connecting MongoDB Atlas](google-kubernetes-engine-gke.md#id-4.-connecting-mongodb-atlas)
5. [Reserving a static IP address and creating DNS records](google-kubernetes-engine-gke.md#id-5.-reserving-a-static-ip-address-and-creating-dns-records)
6. [Connecting to the cluster](google-kubernetes-engine-gke.md#id-6.-connecting-to-the-cluster)
7. [Creating the namespace and the Secret](google-kubernetes-engine-gke.md#id-7.-creating-the-namespace-and-the-secret)
8. [Installing DecisionRules with Helm](google-kubernetes-engine-gke.md#id-8.-installing-decisionrules-with-helm)
9. [Waiting for the load balancer and the certificate](google-kubernetes-engine-gke.md#id-9.-waiting-for-the-load-balancer-and-the-certificate)
10. [Accessing the application](google-kubernetes-engine-gke.md#id-10.-accessing-the-application)
11. [Additional steps](google-kubernetes-engine-gke.md#id-11.-additional-steps)

[Last checks & Troubleshooting](google-kubernetes-engine-gke.md#last-checks-and-troubleshooting)

## The Deployment

### 1. Enabling the required APIs

If this is the first time you work with Google Cloud, some services are disabled by default. Navigate to **APIs & Services → Library** and enable:

* **Kubernetes Engine API** (this also enables the Compute Engine API)
* **Google Cloud Memorystore for Redis API**
* **Service Networking API** (used by Memorystore's private connection)

Or in Cloud Shell:

```bash
gcloud services enable container.googleapis.com redis.googleapis.com servicenetworking.googleapis.com
```

***

### 2. Creating the GKE cluster

Navigate to **Kubernetes Engine → Clusters** and click **Create**. If you are asked for the cluster mode, choose **Autopilot** and click **Configure**. With Autopilot, Google manages the nodes, their scaling and upgrades, and you pay for the resources your Pods request. A Standard cluster works as well.

* **Name:** for example `decisionrules`
* **Region:** the same region as your Atlas cluster and your Memorystore instance, for example `europe-west1`
* **Networking:** choose the VPC network the cluster will use (the `default` network is fine for a start). Make a note of it, you will attach Memorystore and peer MongoDB Atlas with the same network.

Leave the rest of the settings default and click **Create**. Creating the cluster takes 5 to 10 minutes.

Or in Cloud Shell:

```bash
gcloud container clusters create-auto decisionrules --region europe-west1 --network default
```

{% hint style="info" %}
The cluster must be **VPC-native** and have the **HTTP Load Balancing** add-on enabled. Both are the default for new clusters, and Autopilot clusters always meet these requirements.
{% endhint %}

***

### 3. Provisioning Memorystore for Redis

Navigate to **Memorystore → Redis** and click **Create instance**.

* **Instance ID:** for example `decisionrules-cache`
* **Tier:** **Basic** for development and testing, **Standard** (with a replica and automatic failover) for production
* **Capacity:** 1 GB is enough for most deployments
* **Region:** the same region as your cluster
* **Redis version:** the newest version offered
* **Networking:** set **Network** to your cluster's VPC and **Connection** to **Private service access**. The first time, the console asks you to allocate an IP range and create the private connection. Accept the suggested values.
* **Security:** you can enable **AUTH**. Leave **in-transit encryption** disabled, because the traffic stays inside your VPC.

{% hint style="warning" %}
The price of the instance depends on the tier and capacity. The cost estimate is shown next to the form. Please think this through before creating a larger instance than you really need.
{% endhint %}

Click **Create**. When the instance is ready, copy its **Primary endpoint** IP address (and the **AUTH string** if you enabled AUTH). Your `REDIS_URL` is then:

```
redis://<PRIMARY_ENDPOINT_IP>:6379
```

or, with AUTH enabled:

```
redis://:<AUTH_STRING>@<PRIMARY_ENDPOINT_IP>:6379
```

***

### 4. Connecting MongoDB Atlas

DecisionRules needs two databases: the main database (`MONGO_DB_URI`) and the Business Intelligence (audit) database (`BI_MONGO_DB_URI`). Both can live on the same Atlas cluster.

1. In MongoDB Atlas, create a dedicated cluster (M10 or larger) on **Google Cloud** in the same region as your GKE cluster.
2. Peer the Atlas network with your cluster's VPC and add the cluster's **Pod IPv4 range** and **node subnet** to the Atlas IP access list. Follow the [Google Cloud section of MongoDB Atlas Network Peering](mongodb-atlas-network-peering.md#google-cloud) step by step.
3. Create a database user in **Security → Database & Network Access → Database Users**.
4. Open **Connect** on your cluster, choose **Private IP for Peering** and copy the connection string. The hostname contains `-pri`.

Your connection strings then look like this:

```
MONGO_DB_URI=mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules
BI_MONGO_DB_URI=mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules-audit
```

{% hint style="warning" %}
On Google Cloud, the standard connection string (without `-pri`) resolves to public IP addresses and bypasses the peering. Always use the private one.
{% endhint %}

***

### 5. Reserving a static IP address and creating DNS records

A reserved IP address keeps the load balancer's address stable, so your DNS records never have to change.

Navigate to **VPC network → IP addresses** and click **Reserve external static IP address**:

* **Name:** `decisionrules-ip`
* **Network Service Tier:** Premium
* **IP version:** IPv4
* **Type:** **Global**

Click **Reserve**. Or in Cloud Shell:

```bash
gcloud compute addresses create decisionrules-ip --global
gcloud compute addresses describe decisionrules-ip --global --format='value(address)'
```

Now create two DNS **A records**, for example `app.example.com` and `api.example.com`, both pointing at this IP address. Use Cloud DNS or your own DNS provider. Google can issue the TLS certificate only once these records resolve.

***

### 6. Connecting to the cluster

In **Kubernetes Engine → Clusters**, click the **⋮** menu next to your cluster, choose **Connect** and then **Run in Cloud Shell**. Or run:

```bash
gcloud container clusters get-credentials decisionrules --region europe-west1
```

Check that you are connected:

```bash
kubectl get namespaces
```

{% hint style="info" %}
On Autopilot, `kubectl get nodes` may show no nodes until the first workloads are scheduled. That is expected.
{% endhint %}

***

### 7. Creating the namespace and the Secret

The Helm chart never takes credentials from values files. Instead, it reads them from a Kubernetes Secret that must exist before installation.

```bash
kubectl create namespace decisionrules

kubectl create secret generic decisionrules-config -n decisionrules \
  --from-literal=MONGO_DB_URI='mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules' \
  --from-literal=BI_MONGO_DB_URI='mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules-audit' \
  --from-literal=REDIS_URL='redis://<PRIMARY_ENDPOINT_IP>:6379' \
  --from-literal=LICENSE_KEY='<YOUR_LICENSE_KEY>'
```

If you want to use the AI Assistant, add the key of your AI provider to the same Secret with `--from-literal=AIA_SECRET='<KEY>'`. See [AI Engine providers and models](../ai-engine-providers-and-models.md).

{% hint style="info" %}
For production, keep the credentials in Google Secret Manager and sync them into the cluster with the External Secrets Operator. See [Using Google Secret Manager](kubernetes-setup/helm-charts/gke-helm-chart.md#using-google-secret-manager) on the GKE Helm Chart page.
{% endhint %}

***

### 8. Installing DecisionRules with Helm

Create a values file with your hostnames. It is best practice to pin the image versions. The client must use a **rootless** tag.

{% hint style="info" %}
The chart sizes the server for the **Aero (V2)** solver or mixed V1/V2 traffic by default: **4 vCPU and 4 GiB per replica** (`4000m` / `4Gi` for both requests and limits) and autoscaling between **2 and 5** replicas. If you use only the classic **Gaia (V1)** solver, set `server.solver: gaia` (`1000m` / `1Gi` requests, `2000m` / `2Gi` limits, 2 to 10 replicas). See [Server sizing](kubernetes-setup/helm-charts/gke-helm-chart.md#server-sizing) on the GKE Helm Chart page.
{% endhint %}

{% code title="my-values.yaml" %}
```yaml
ingress:
  hosts:
    client: app.example.com   # must be changed
    server: api.example.com   # must be changed
  staticIpName: decisionrules-ip

client:
  image:
    tag: "<YOUR_PREFERRED_VERSION>-rootless"

server:
  image:
    tag: "<YOUR_PREFERRED_VERSION>"
  existingSecret: decisionrules-config
  solver: aero   # or gaia for the classic Gaia (V1) solver

aiEngine:
  enabled: false   # set to true and configure the provider to use the AI Assistant

businessIntelligence:
  enabled: true
```
{% endcode %}

Add the Helm repository and install the chart:

```bash
helm repo add decisionrules-gke https://decisionrules.github.io/helm-charts/decisionrules-gke/
helm repo update

helm install decisionrules decisionrules-gke/decisionrules-gke -n decisionrules -f my-values.yaml
```

The chart creates the Deployments, Services, a HorizontalPodAutoscaler for the server (2 to 5 replicas with the default Aero profile), the Ingress, the Google-managed certificate and the load balancer configuration. All available options, including an internal-only load balancer, your own certificates and the AI Engine settings, are described on the [GKE Helm Chart](kubernetes-setup/helm-charts/gke-helm-chart.md) page.

{% hint style="danger" %}
Please be aware of the resource requests of the containers. With the default Aero profile, the server requests 4 vCPU and 4 GiB of memory per Pod, with at least 2 Pods. On a Standard cluster, make sure your node pool has enough capacity. On Autopilot, you pay for what the Pods request.
{% endhint %}

***

### 9. Waiting for the load balancer and the certificate

Google Cloud needs some time to provision everything. This is the expected order:

| What                   | Typically ready after                 | How to check                                                                      |
| ---------------------- | ------------------------------------- | --------------------------------------------------------------------------------- |
| Pods                   | 2–5 minutes                           | `kubectl get pods -n decisionrules`: all `Running` and `1/1`                      |
| Load balancer          | 5–10 minutes                          | `kubectl get ingress -n decisionrules`: the `ADDRESS` column shows your static IP |
| Backend health         | a few minutes after the load balancer | All backends `HEALTHY` (see below)                                                |
| HTTP to HTTPS redirect | up to 10 more minutes                 | The server URL over HTTP returns `301 Moved Permanently` (see below)              |
| TLS certificate        | 15–60 minutes after DNS resolves      | `kubectl get managedcertificate -n decisionrules`: status `Active`                |

To check the health of the load balancer backends:

```bash
kubectl get ingress decisionrules-ingress -n decisionrules \
  -o jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/backends}'; echo
```

All entries, including the client and server Services, should be `HEALTHY`. You can see the same in the Google Cloud console under **Kubernetes Engine → Gateways, Services & Ingress → Ingress**.

To check that the load balancer answers and redirects to HTTPS:

```bash
curl -I http://api.example.com/health-check
```

***

### 10. Accessing the application

Once the certificate is `Active`, check the server:

```bash
curl https://api.example.com/health-check
```

Then open `https://app.example.com` in your browser. On a new installation, create the first account as described in [Sign Up on On Premise](../../../access/on-premise/sign-up-on-on-premise.md).

The server checks its own public URL when it starts. If it started before the certificate was active, its log contains `API_URL health check failed`. Restart it once the certificate is active:

```bash
kubectl rollout restart deploy/decisionrules-server -n decisionrules
```

***

### 11. Additional steps

* **Enforce modern TLS:** create an SSL policy (`gcloud compute ssl-policies create decisionrules-tls12 --profile MODERN --min-tls-version 1.2`) and set `ingress.tls.sslPolicy` in your values.
* **Protect the application:** attach a Cloud Armor security policy with `ingress.backendConfig.securityPolicy`.
* **Internal-only access:** use the internal load balancer (`ingress.className: gce-internal`) if the application should be reachable only from your network. See the [GKE Helm Chart](kubernetes-setup/helm-charts/gke-helm-chart.md#internal-load-balancer) page.
* **Monitoring and logging:** container logs are collected in Cloud Logging by default. See [Logging Options](../logging-options.md) and [OpenTelemetry and Access Logging](../opentelemetry-and-access-logging.md).
* **Backups:** enable Cloud Backup in MongoDB Atlas.
* **Automated deployments:** see [Google Cloud DevOps CICD Pipelines](../cd-ci-pipelines/google-cloud-devops-cicd-pipelines.md).

***

## Last checks & Troubleshooting

Incorrectly following the steps listed above can result in your application not running properly. Below is a list of known problems and checks you might want to know about.

#### Pods stay in Pending

On Autopilot, Google adds nodes when Pods need them, which takes a few minutes. On a Standard cluster, check that your node pool has enough CPU and memory: `kubectl describe pod <pod-name> -n decisionrules`.

#### Pod in CreateContainerConfigError

The Secret or one of its keys is missing. The Secret must contain `MONGO_DB_URI`, `BI_MONGO_DB_URI`, `REDIS_URL` and `LICENSE_KEY`, plus `AIA_SECRET` when the AI Engine is enabled. Run `kubectl describe pod <pod-name> -n decisionrules` to see which one.

#### Server not starting or crashing repeatedly

Check the server log: `kubectl logs deploy/decisionrules-server -n decisionrules`. A timeout while connecting to MongoDB usually means the Pod IP range is missing from the Atlas IP access list, or the connection string does not contain `-pri`. See [Troubleshooting in MongoDB Atlas Network Peering](mongodb-atlas-network-peering.md#troubleshooting). A Redis connection error usually means Memorystore is attached to a different VPC than the cluster.

#### "Translation failed" or "MissingCertificate" warnings on the Ingress

Right after the first installation, `kubectl describe ingress` may show warnings such as `no BackendConfig for service port exists` or `ManagedCertificate ... missing`. Helm creates the GKE-specific resources a moment after the Ingress, and GKE resolves this on its own within seconds. Only warnings that keep repeating need attention.

#### Empty reply, 404 or 502 from the load balancer

For the first 10 to 15 minutes after the load balancer is created, requests may fail with an empty reply, `404` or `502` while Google Cloud distributes the configuration. Wait and try again. If it persists, check that all backends are `HEALTHY` (see step 9).

#### Certificate stays in Provisioning

The certificate is issued only after both hostnames resolve to the load balancer IP address. Check your DNS records with `dig +short app.example.com`. For details on each domain, run `kubectl describe managedcertificate -n decisionrules`. The status `FailedNotVisible` means Google cannot see a DNS record pointing at the load balancer.

#### Browser shows a certificate error right after the certificate became Active

It can take a few more minutes until all Google front ends serve the new certificate. Wait and reload the page.

#### Login through SSO is not working

Make sure `CLIENT_URL` ends with `/#`. The chart sets it automatically from `ingress.hosts.client`. If you set `server.clientUrl` yourself, check the trailing `/#`.

#### Private connection

To check that the connection to your database is private, run a test Pod as described in [Verify the connection](mongodb-atlas-network-peering.md#verify-the-connection). The database hostname must resolve into a private IP address (for example `192.168.x.x`) inside the Atlas CIDR block.

**Note**: Adaptations might be required based on Google Cloud updates. Always refer to the latest Google Cloud documentation for current practices and configurations.
