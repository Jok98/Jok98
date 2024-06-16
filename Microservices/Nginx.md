

# Set Up Kubernetes Environment For Nginx
### Nginx config as API Gateway e Load Balancer
1. Install docker
2. Install kubectl
3. Install minikube
4. Start minikube
```cmd
minikube start --driver=docker
```
5. Enable ingress
```cmd
minikube addons enable ingress
```
6. Create a deployment
```yaml
# kubectl apply -f nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```
7. Create a service
```yaml
# kubectl apply -f nginx-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
```
8. Create an ingress
```yaml
# kubectl apply -f nginx-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: my-nginx.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
```
9. Apply the yaml files
```cmd
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f nginx-ingress.yaml
```
10. Get the minikube ip
```cmd
minikube ip
```
11. Add the minikube ip to the hosts file
```cmd
echo "{minikube-ip} my-nginx.local" | sudo tee -a /etc/hosts
```
12. Expose the service
```cmd
minikube service nginx-service --url
```
## Personalize the nginx
1. Create a config map
```yaml
# kubectl apply -f nginx-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    events { }
    http {
    server {
        listen 80;
        location / {
            return 301 https://github.com;
        }
    }
    }
```
2. Apply the config map
```cmd
kubectl apply -f nginx-configmap.yaml
```
3. Modify the deployment to use the config map
```yaml
# kubectl apply -f nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
          volumeMounts:
            - name: nginx-config-volume
              mountPath: /etc/nginx/nginx.conf
              subPath: nginx.conf
      volumes:
        - name: nginx-config-volume
          configMap:
            name: nginx-config
```
4. Apply the deployment
```cmd
kubectl apply -f nginx-deployment.yaml
```


