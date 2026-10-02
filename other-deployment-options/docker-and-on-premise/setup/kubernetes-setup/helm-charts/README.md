---
description: >-
  Official Helm charts for deploying DecisionRules to Kubernetes: Amazon EKS,
  Azure AKS, generic Kubernetes with NGINX Ingress, Red Hat OpenShift and Google
  Kubernetes Engine.
---

# Helm Charts

DecisionRules provides Helm charts for deploying the application to Kubernetes. Each chart is tailored to one platform and uses that platform's way of exposing applications to users. Pick the chart for your platform below. Each chart has its own page describing what it deploys, what you need to provision separately, and all configuration options.

## Choose a chart

| Chart                                  | Platform                                                          | How the application is exposed                                             | TLS                                         | Credentials                                      |
| -------------------------------------- | ----------------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------- | ------------------------------------------------ |
| [Amazon EKS](amazon-eks-helm-chart.md) | Amazon EKS with EKS Auto Mode                                     | A public Network Load Balancer per component                               | Not configured by the chart                 | Kubernetes Secret (recommended) or `values.yaml` |
| [Azure AKS](azure-aks-helm-chart.md)   | Azure Kubernetes Service                                          | A public Azure Load Balancer IP per component                              | Not configured by the chart                 | `values.yaml`                                    |
| [Ingress](ingress-helm-chart.md)       | Any Kubernetes with the NGINX Ingress Controller and cert-manager | One Ingress, a hostname per component                                      | Let's Encrypt certificate from cert-manager | `values.yaml`                                    |
| [OpenShift](openshift-helm-chart.md)   | Red Hat OpenShift (OCP, ARO, ROSA)                                | An OpenShift Route for the client and the server                           | Edge TLS on the Routes                      | Kubernetes Secret (required)                     |
| [GKE](gke-helm-chart.md)               | Google Kubernetes Engine (Standard or Autopilot)                  | One GKE Ingress (Google Cloud load balancer) for the client and the server | Google-managed certificate                  | Kubernetes Secret (required)                     |

## What all charts have in common

* **The charts deploy only DecisionRules:** the client, the server and, optionally, Business Intelligence and the AI Engine. MongoDB and Redis are never deployed by the charts. Provision them separately and make sure they are reachable from the cluster. For a private connection to MongoDB Atlas, see [MongoDB Atlas Network Peering](../../mongodb-atlas-network-peering.md).
* **Outbound access:** the server must reach the DecisionRules license and distribution servers, see [Prerequisites](../../../prerequisites.md), or use an [Offline License](../../../offline-license.md).
* **Images:** all charts use the official images from Docker Hub and default to the `latest` tag. Pin a specific version in production.
* **Server sizing:** every chart sizes the server for the rule solver you use, see [Server sizing](./#server-sizing). Make sure your cluster has room for at least two server Pods.
* **Application URLs:** the server needs its own public URL (`API_URL`) and the client's URL (`CLIENT_URL`, ending with `/#`). The OpenShift and GKE charts derive them from the hostnames. With the other charts you set them in `values.yaml`.

See [Environment Variables](../../../containers-environmental-variables.md) for the meaning of every variable the charts set.

## Server sizing

All charts size the server according to the rule solver you use. Aero is the default.

| Rule solver                      | Chart value      | Server CPU / memory per Pod                      | Autoscaling |
| -------------------------------- | ---------------- | ------------------------------------------------ | ----------- |
| Aero (V2) or mixed V1/V2 traffic | `aero` (default) | `4000m` / `4Gi` (requests = limits)              | 2–5 Pods    |
| Gaia (V1) only                   | `gaia`           | `1000m` / `1Gi` requests, `2000m` / `2Gi` limits | 2–10 Pods   |

Aero uses several CPUs within one process, so it runs best on fewer, larger replicas. Select the profile with `solver` in the EKS, AKS and Ingress charts and with `server.solver` in the OpenShift and GKE charts. Both profiles are defined in each chart's `values.yaml` (`solverProfiles`, or `server.solverProfiles` in the OpenShift and GKE charts), so you can adjust them. To size the server yourself regardless of the profile, set the server resources and the autoscaling range explicitly; they take precedence over the profile. See [server sizing](../../../../../decisionrules-applications/server-app.md#minimal-requirements) for scaling and resource reserve.

{% hint style="warning" %}
Aero is the default from chart versions EKS 0.4.0, AKS 0.3.0, Ingress 0.3.0 and OpenShift 0.2.0, and in all versions of the GKE chart. Earlier versions sized the server like `gaia`. When you upgrade an existing installation, set the solver to `gaia` to keep the previous sizing.
{% endhint %}

## Quick start

The commands below only add the repository and install the chart. Read the chart's page first to prepare the values file and the resources the chart expects.

{% tabs %}
{% tab title="EKS" %}
```bash
helm repo add decisionrules-eks https://decisionrules.github.io/helm-charts/decisionrules-eks/

helm install decisionrules-eks decisionrules-eks/decisionrules-eks -f values.yaml
```

[Amazon EKS Helm Chart](amazon-eks-helm-chart.md)
{% endtab %}

{% tab title="AKS" %}
```bash
helm repo add decisionrules-aks https://decisionrules.github.io/helm-charts/decisionrules-aks/

helm install decisionrules-aks decisionrules-aks/decisionrules-aks -f values.yaml
```

[Azure AKS Helm Chart](azure-aks-helm-chart.md)
{% endtab %}

{% tab title="Ingress" %}
```bash
helm repo add decisionrules-ingress https://decisionrules.github.io/helm-charts/decisionrules-ingress/

helm install decisionrules-ingress decisionrules-ingress/decisionrules-ingress -f values.yaml
```

[Ingress Helm Chart](ingress-helm-chart.md)
{% endtab %}

{% tab title="OpenShift" %}
```bash
helm repo add decisionrules-ocp https://decisionrules.github.io/helm-charts/decisionrules-ocp/

helm install decisionrules decisionrules-ocp/decisionrules-ocp -n decisionrules -f my-values.yaml
```

[OpenShift Helm Chart](openshift-helm-chart.md)
{% endtab %}

{% tab title="GKE" %}
```bash
helm repo add decisionrules-gke https://decisionrules.github.io/helm-charts/decisionrules-gke/

helm install decisionrules decisionrules-gke/decisionrules-gke -n decisionrules -f my-values.yaml
```

[GKE Helm Chart](gke-helm-chart.md)
{% endtab %}
{% endtabs %}

If you prefer to write the Kubernetes manifests yourself, see [Kubernetes Setup](../).
