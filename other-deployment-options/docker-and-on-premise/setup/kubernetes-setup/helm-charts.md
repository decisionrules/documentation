# Helm Charts

In order to be able to deploy DecisionRules on Kubernetes using Helm Charts, first make sure you have the prerequisite Redis and MongoDB instances already prepared and available and set the corresponding environment variables `REDIS_URL` and `MONGO_DB_URI` in values.yaml accordingly.

Also make sure you have properly set the 'client' and 'api' domains (and 'bi' if your license includes Business Intelligence) and then use them to construct the `CLIENT_URL` and `API_URL` variables.

Please refer to our official documentation page, which contains the complete list of all required [environment variables](https://docs.decisionrules.io/doc/other-deployment-options/docker-and-on-premise/containers-environmental-variables).

<details>

<summary>values.yaml</summary>

{% code title="" %}
```yaml
namespace: decisionrules

bi:
  enabled: false # set to true to enable audit

domain:
  client: "yourdomain.local" # to be filled by user
  api: "api.yourdomain.local" # to be filled by user
  bi: "bi.yourdomain.local" # to be filled by user

env:
  client:
    API_URL: "" # to be filled by user
    BI_API_URL: "" # to be filled by user
  server:
    REDIS_URL: "" # to be filled by user
    MONGO_DB_URI: "" # to be filled by user
    CLIENT_URL: "" # to be filled by user
    API_URL: "" # to be filled by user
    LICENSE_KEY: "" # to be filled by user
  bi:
    BI_MONGO_DB_URI: "" # to be filled by user

images:
  client: decisionrules/client
  server: decisionrules/server
  bi: decisionrules/business-intelligence

resources:
  client:
    requests:
      cpu: 250m
      memory: 128Mi
    limits:
      cpu: 500m
      memory: 256Mi
  server:
    requests:
      cpu: 1000m
      memory: 1Gi
    limits:
      cpu: 2000m
      memory: 2Gi
  bi:
    requests:
      cpu: 1000m
      memory: 1Gi
    limits:
      cpu: 2000m
      memory: 4Gi

replicaCount:
  client: 2
  server: 2
  bi: 2

autoscalingServer:
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 60
```
{% endcode %}

</details>

Currently there are packages for deployment on **AWS EKS** and **Azure AKS**, and also for deployment with Ingress support.

\
For more information follow the ArtifactHub link on each tab.

{% tabs %}
{% tab title="EKS" %}
```bash
helm repo add decisionrules-eks https://decisionrules.github.io/helm-charts/decisionrules-eks/

helm install decisionrules-eks decisionrules-eks/decisionrules-eks -f values.yaml
```

[https://artifacthub.io/packages/helm/decisionrules-eks/decisionrules-eks](https://artifacthub.io/packages/helm/decisionrules-eks/decisionrules-eks)
{% endtab %}

{% tab title="AKS" %}
```bash
helm repo add decisionrules-aks https://decisionrules.github.io/helm-charts/decisionrules-aks/

helm install decisionrules-aks decisionrules-aks/decisionrules-aks -f values.yaml
```

[https://artifacthub.io/packages/helm/decisionrules-aks/decisionrules-aks](https://artifacthub.io/packages/helm/decisionrules-aks/decisionrules-aks)
{% endtab %}

{% tab title="Ingress" %}
```bash
helm repo add decisionrules-ingress https://decisionrules.github.io/helm-charts/decisionrules-ingress/

helm install decisionrules-ingress decisionrules-ingress/decisionrules-ingress -f values.yaml
```

[https://artifacthub.io/packages/helm/decisionrules-ingress/decisionrules-ingress](https://artifacthub.io/packages/helm/decisionrules-ingress/decisionrules-ingress)
{% endtab %}
{% endtabs %}
