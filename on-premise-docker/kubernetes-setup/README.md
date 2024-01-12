---
description: On this page you can find tutorial how to deploy DecisionRules into kubernetes
cover: >-
  https://res.cloudinary.com/gremlin/image/upload/t_default/1024px-kubernetes_logo.png
coverY: 0
---

# Kubernetes Setup

## How to Deploy DecisionRules on Kubernetes

### 1. Create a namespace for DecisionRules

#### Template

{% code title="namespace.yaml" %}
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: decisionrules
  labels:
    name: decisionrules
```
{% endcode %}

#### Activate

```
kubectl apply -f namespace.yaml
```

### 2. Install Ingress to kubernetes

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/cloud/deploy.yaml
```

### 3. Install Cert-Manager

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
```

### 4. Configure Cert-Manager

#### Template

{% code title="cert.yaml" %}
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: letsencrypt-prod
 namespace: decisionrules
spec:
 acme:
   server: https://acme-v02.api.letsencrypt.org/directory
   email: support@decisionrules.io
   privateKeySecretRef:
     name: letsencrypt-prod
   solvers:
   - http01:
       ingress:
         class: nginx
```
{% endcode %}

#### Activate

```
kubectl apply -f cert.yaml
```

### 5. Create services and configure ingress

In this template, you must specify your custom hostname. Be sure to change the same hostname in the TLS hosts section.

#### Template

{% code title="ingress.yaml" %}
```yaml
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
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - yourdomain.local # must be changed
    - api.yourdomain.local # must be changed
    secretName: echo-tls
  rules:
  - host: yourdomain.local # must be changed
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: decisionrules-client-service
            port:
              number: 80
  - host: api.yourdomain.local # must be changed
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
{% endcode %}

#### Activate

```
kubectl apply -f ingress.yaml
```

### 6. Getting Ingress IP address for setting domain

#### Command

```
kubectl get ingress --namespace=decisionrules
```

#### Example of Response

```
NAME                    CLASS   HOSTS                                                         ADDRESS        PORTS     AGE
decisionrules-ingress   nginx   kubernetes.decisionrules.io,api.kubernetes.decisionrules.io   104.45.71.23   80, 443   3d23h
```

In the response, you can find column ADDRESS where you can find the IP Address of Ingress. This IP Address you can use to specify your custom domain as  A record of DNS.

### 7. Create deployment service

In this template, you must fill Environmental variables and change the URL to the Ingress hostname which you specify in the previous step. The place is markup with comments.

#### Template

{% code title="deployment.yaml" %}
```yaml
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
            memory: 1Gi
          limits:
            cpu: 2000m
            memory: 2Gi
        ports:
        - containerPort: 8080
        env:
        - name: REDIS_URL
          value: "" # must be filled
        - name: MONGO_DB_URI
          value: "" # must be filled
        - name: CLIENT_URL
          value: "https://yourdomain.local/#" # must be changed and end with "/#"
        - name: LICENSE_KEY
          value: "" # must be filled.yaml
        startupProbe:
          httpGet:
            path: /health-check
            port: ​8080
          failureThreshold: 20 # Application will have 5s+3s*20=65s to start
          initialDelaySeconds: 5
          periodSeconds: 3
        livenessProbe:
          httpGet:
            path: /health-check
            port: ​8080
          initialDelaySeconds: 10 # Is equal to periodSeconds so it does not do anything
          failureThreshold: 2 # Application will have 2*10s=20s to recover, otherwise it will be killed
          periodSeconds: 10
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
{% endcode %}

#### Activate

```
kubectl apply -f deployment.yaml
```
