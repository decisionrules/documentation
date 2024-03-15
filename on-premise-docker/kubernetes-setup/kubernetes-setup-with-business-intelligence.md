---
description: >-
  Here you can find the templates for the deployment of DecisionRules with
  Business Intelligence on Kubernetes
---

# Kubernetes Setup with Business Intelligence

In general, you can follow the general Kubernetes setup described on the previous page. You will just need the two main templates slightly adjusted. In particular, during the setup use the following templates.

First, the template for services and ingress will now look like this.

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
apiVersion: v1
kind: Service
metadata:
  name: decisionrules-bi-service
  namespace: decisionrules
spec:
  selector:
    app: decisionrules-bi
  ports:
    - port: 8082
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
  - host: bi.yourdomain.local # must be changed
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: decisionrules-bi-service
            port:
              number: 8082
```
{% endcode %}

Second, the deployment template.

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
        - name: BI_API_URL
          value: "https://bi.yourdomain.local" #must be changed
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
          value: " # must be filled
        - name: MONGO_DB_URI
          value: "" # must be filled
        - name: CLIENT_URL
          value: "https://yourdomain.local/#" # must be changed and end with "/#"   
        - name: API_URL
          value: "https://api.yourdomain.local" # this is only necessary with certain deployment models
        - name: LICENSE_KEY
          value: "" # must be filled
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
apiVersion: apps/v1
kind: Deployment
metadata:
  name: decisionrules-bi
  namespace: decisionrules
spec:
  replicas: 2
  selector:
    matchLabels:
      app: decisionrules-bi
  strategy: 
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: decisionrules-bi
    spec:
      containers:
      - name: decisionrules-bi
        image: decisionrules/business-intelligence
        resources:
          requests:
            cpu: 1000m
            memory: 1Gi
          limits:
            cpu: 2000m
            memory: 4Gi
        ports:
        - containerPort: 8082
        env:
        - name: BI_MONGO_DB_URI
          value: "" # must be filled
        livenessProbe:
          httpGet:
            path: /health-check
            port: 8082
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
{% endcode %}

Remember to enter your own custom ULRs consistently in bot the above templates. Also, in the deployment template, you will need to fill in valid values of the environment variables for both the server and the business intelligence container. All the places in the templates that need your attention are marked by a comment.

Upon following the instructions on the previous page and using these two templates instead of the respective templates provided therein, you should be able to successfully deploy DecisionRules with the Business Intelligence container on Kubernetes.
