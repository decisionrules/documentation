---
description: >-
  This document describes end-to-end deployment process of DecisionRules app for
  Google Kubernetes Engine.
---

# Google Kubernetes Engine (GKE)

## Prerequisites: <a href="#prerequisites" id="prerequisites"></a>

1. DecisionRules docker images for both client and server.
2. MongoDB database with administrator access.
3. GCP account with activated billing account.

{% hint style="info" %}
If it is first time you work with GCP some services and APIs may be disabled by default, you have to activate them in order to continue.
{% endhint %}

## Mandatory GCP APIs and services: <a href="#mandatory-gcp-apis-and-services" id="mandatory-gcp-apis-and-services"></a>

1. Kubernetes Engine API
2. Memorystore
3. Certificate Manager

## Creating Memorystore Redis instance <a href="#creating-memorystore-redis-instance" id="creating-memorystore-redis-instance"></a>

1. Click on “Create Instance” on Memorystore page
2. Set desired configuration of Redis
3. Click “Create”

{% hint style="warning" %}
Price of Redis instance depends on configuration settings, please think this through before create too powerful and too expensive instances that are not really needed. Cost estimation is on the left side of form.
{% endhint %}

After creating Redis instance copy primary endpoint IPv4 address. This address will be used for decisionrules/server later.

## Creating GKE cluster <a href="#creating-gke-cluster" id="creating-gke-cluster"></a>

{% hint style="danger" %}
Use a Standard cluster, because the Autopilot feature is broken and doesn’t work properly. This is very important and you **won't be able to** **proceed** with Autopilot.
{% endhint %}

1. Set the name of the cluster
2. Choose desired Location type
   1. Zonal picks one zone in region
   2. Regional picks one region with all zones included
3. Choose control plane version
   1. Depends on if you want static GKE version or not.
4. Configure nodepools
   1. On the Nodes page you can configure which VMs will be deployed in Kubernetes node(s). This depends on the requirements of the system.
   2. Leave disk as is if there are no requirements for specific settings.
5. Configure Node-pool
   1. Here we choose the number of nodes we want to spin up in our Kubernetes cluster
   2. We can also enable autoscaler and node locations
6. Click “Create”

## Setting up GKE cluster <a href="#setting-up-gke-cluster" id="setting-up-gke-cluster"></a>

Connect to the cluster with google cloud shell (recommended) or setup your own SSH connection with your favorite terminal.

Connect to the cluster with this command:

{% code overflow="wrap" %}
```
gcloud container clusters get-credentials <CLUSTER_NAME> --zone=<CLUSTER_ZONE> --project=<PROJECT_WITH_CLUSTER>
```
{% endcode %}

{% hint style="info" %}
\--zone parameter also accepts regions
{% endhint %}

Check that you are connected to the right cluster by verifying cluster node that you specified earlier by command:

```
kubectl get nodes
```

You should see something like this:

{% code overflow="wrap" lineNumbers="true" %}
```
NAME                                        STATUS ROLES AGE VERSION 
gke-dr-cluster-1-default-pool-ed5a4901-fkkp Ready <none> 24h v1.25.8-gke.1000 gke-dr-cluster-1-default-pool-ed5a4901-qns3 Ready <none> 24h v1.25.8-gke.1000
```
{% endcode %}

### Creating DecisionRules namespace: <a href="#creating-decisionrules-namespace" id="creating-decisionrules-namespace"></a>

Create a **yaml** file with the following contents:

{% code overflow="wrap" lineNumbers="true" %}
```
apiVersion: v1
kind: Namespace
metadata:
  name: decisionrules
  labels:
    name: decisionrules
```
{% endcode %}

You can just redirect the standard output of the echo command to a yaml file in bash or open any editor that your terminal offers (GCP - Active Cloud Shell offers nano afaik).

Then apply these settings:

```
kubectl apply -f namespace.yaml
```

{% hint style="info" %}
`kubectl apply -f <file_path>` command will be used many times from now and its syntax is always the same.

So every time you read that you should **apply** something use this command + file creation/editing.
{% endhint %}

{% hint style="success" %}
You can verify that your namespace is created by running:

`kubectl get namespaces | grep decisionrules`
{% endhint %}

### Install cert-manager <a href="#install-cert-manager" id="install-cert-manager"></a>

{% code overflow="wrap" %}
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
```
{% endcode %}

Check that cert-manager is installed properly with `kubectl get all -n cert-manager`

You should see something like this:

{% code lineNumbers="true" fullWidth="true" %}
```
NAME                                           READY   STATUS    RESTARTS      AGE
pod/cert-manager-655bf9748f-c9wdj              1/1     Running   1 (24h ago)   25h
pod/cert-manager-cainjector-7985fb445b-l5dgn   1/1     Running   3 (24h ago)   25h
pod/cert-manager-webhook-6dc9656f89-89dk8      1/1     Running   0             25h

NAME                           TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/cert-manager           ClusterIP   XX.XX.X.XXX   <none>        9402/TCP   25h
service/cert-manager-webhook   ClusterIP   XX.XX.X.XX    <none>        443/TCP    25h

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cert-manager              1/1     1            1           25h
deployment.apps/cert-manager-cainjector   1/1     1            1           25h
deployment.apps/cert-manager-webhook      1/1     1            1           25h

NAME                                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/cert-manager-655bf9748f              1         1         1       25h
replicaset.apps/cert-manager-cainjector-7985fb445b   1         1         1       25h
replicaset.apps/cert-manager-webhook-6dc9656f89      1         1         1       25h
```
{% endcode %}

Now **apply** the ClusterIssuer class

```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: letsencrypt-test-dr
 namespace: decisionrules
spec:
 acme:
   server: your_cert_server
   email: your_email
   privateKeySecretRef:
     name: letsencrypt-test-dr
   solvers:
   - http01:
       ingress:
         class: nginx
```



{% hint style="info" %}
name is important, because you need that for further settings, remember that.
{% endhint %}

Now **apply** Issuer class

```
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ca-issuer
  namespace: decisionrules
spec:
  ca:
    secretName: ca-key-pair
```

Now we can apply cert as is described here:

{% embed url="https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#setting_up_a_google-managed_certificate" %}
Using google-managed SSL certificates
{% endembed %}

## Install Ingress: <a href="#install-ingress" id="install-ingress"></a>

{% code overflow="wrap" %}
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/cloud/deploy.yaml
```
{% endcode %}

## Deploying Ingress: <a href="#deploying-ingress" id="deploying-ingress"></a>

**apply** file below

```
apiVersion: v1
kind: Service
metadata:
  name: decisionrules-client-service
  namespace: decisionrules
spec:
  selector:
    app: decisionrules-client
  ports:
    - port: 80
---
apiVersion: v1
kind: Service
metadata:
  name: decisionrules-server-service
  namespace: decisionrules
spec:
  selector:
    app: decisionrules-server
  ports:
    - port: 8080
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: decisionrules-ingress
  namespace: decisionrules
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: "/"
    cert-manager.io/cluster-issuer: <name_clusterissuer_class>
    kubernetes.io/ingress.class: "nginx"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - yourdomain.local
    - api.yourdomain.local
    secretName: echo-tls
  rules:
  - host: yourdomain.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: decisionrules-client-service
            port:
              number: 80
  - host: api.yourdomain.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: decisionrules-server-service
            port:
              number: 8080
```

We can check that ingress is up and running by running commad: `kubectl get all -n ingress-nginx`

You should see something like this:

{% code lineNumbers="true" fullWidth="true" %}
```
NAME                                            READY   STATUS      RESTARTS   AGE
pod/ingress-nginx-admission-create-mlvkt        0/1     Completed   0          26h
pod/ingress-nginx-admission-patch-v9b7l         0/1     Completed   0          26h
pod/ingress-nginx-controller-6bc476f787-2xr8g   1/1     Running     0          26h

NAME                                         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE
service/ingress-nginx-controller             LoadBalancer   XX.XX.XX.XX   XX.XXX.XXX.XXX   80:31163/TCP,443:31959/TCP   26h
service/ingress-nginx-controller-admission   ClusterIP      XX.XX.X.XXX    <none>           443/TCP                      26h

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ingress-nginx-controller   1/1     1            1           26h

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/ingress-nginx-controller-6bc476f787   1         1         1       26h

NAME                                       COMPLETIONS   DURATION   AGE
job.batch/ingress-nginx-admission-create   1/1           6s         26h
job.batch/ingress-nginx-admission-patch    1/1           6s         26h
```
{% endcode %}

Obtain IPv4 address of Ingress for DNS A record:

Run command: `kubectl get ingress --namespace=decisionrules`

You should see something like this:

{% code fullWidth="true" %}
```
NAME                    CLASS   HOSTS                                           ADDRESS          PORTS     AGE
decisionrules-ingress   nginx   yourdomain_api.com,yourdomain_app.com           XXX.XXX.XXX.XXX   80, 443   26h
```
{% endcode %}

## Deploy app <a href="#deploy-app" id="deploy-app"></a>

{% hint style="danger" %}
Please, be aware of container resource consuptions, because if you exceed your MVs HW limits you wont be able to deploy pods.
{% endhint %}

For DB security you can add PODs IPs to the network access rules. You can obtain these addresses with command below:

`kubectl get pod -o wide`

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: decisionrules-client
  namespace: decisionrules
spec:
  replicas: 2
  selector:
    matchLabels:
      app: decisionrules-client
  strategy: 
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: decisionrules-client
    spec:
      containers:
      - name: decisionrules-client
        image: decisionrules/client
        resources:
          requests:
            cpu: 250m
            memory: 128Mi
          limits:
            cpu: 500m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: API_URL
          value: "https://api.yourdomain.local" #must be changed
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: decisionrules-server
  namespace: decisionrules
spec:
  replicas: 2
  selector:
    matchLabels:
      app: decisionrules-server
  strategy: 
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: decisionrules-server
    spec:
      containers:
      - name: decisionrules-server
        image: decisionrules/server
        resources:
          requests:
            cpu: 1000m
            memory: 300Mi
          limits:
            cpu: 2000m
            memory: 600Mi
        ports:
        - containerPort: 8080
        env:
        - name: REDIS_URL
          value: "" # must be filled
        - name: MONGO_DB_URI
          value: "" # must be filled
        - name: CLIENT_URL
          value: "https://yourdomain.local/#" # must be changed and end with "/#"
        - name: API_URL
          value: "https://api.yourdomain.local" # this is only necessary with certain deployment models
        - name: LICENSE_KEY
          value: "" # must be filled.yaml
        livenessProbe:
          httpGet:
            path: /health-check
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 30
---
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: decisionrules-server-autoscaling
  namespace: decisionrules
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: decisionrules-server
  minReplicas: 1
  maxReplicas: 10
  targetCPUUtilizationPercentage: 60
```

**Apply** changed configuration above.

Then, you can verify that everything is running by running command: kubectl get all -n decisionrules

You should see something like this:

{% code fullWidth="true" %}
```
NAME                                        READY   STATUS    RESTARTS   AGE
pod/decisionrules-client-5b6bd4494-2gm6m    1/1     Running   0          144m
pod/decisionrules-server-7bc5d6888b-lt92s   1/1     Running   0          144m

NAME                                   TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/decisionrules-client-service   ClusterIP   XX.XX.XX.XXX   <none>        80/TCP     23h
service/decisionrules-server-service   ClusterIP   XX.XX.X.XXX    <none>        8080/TCP   23h

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/decisionrules-client   1/1     1            1           144m
deployment.apps/decisionrules-server   1/1     1            1           144m

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/decisionrules-client-5b6bd4494    1         1         1       144m
replicaset.apps/decisionrules-server-7bc5d6888b   1         1         1       144m

NAME                                                                   REFERENCE                         TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/decisionrules-server-autoscaling   Deployment/decisionrules-server   0%/60%    1         10        1          144m
```
{% endcode %}

Now just add Ingress IPv4 address to your DNS and its done. App is available on hostname you specified earlier with TLS working.

