

# Set Up Kubernetes Environment For Nginx
1. Install docker
2. Install kubectl
3. Install minikube
4. Start minikube
5. Enable ingress
```cmd
minikube addons enable ingress
```
6. Verify the ingress controller
```cmd
kubectl get pods -n kube-system -l app.kubernetes.io/name=ingress-nginx
```
7. Create a deployment yaml file for nginx
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
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
8. Apply the deployment yaml file
```cmd
kubectl apply -f nginx-deployment.yaml
```
9. Create a service yaml file for nginx
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30007
```
10. Apply the service yaml file
```cmd
kubectl apply -f nginx-service.yaml
```
11. Create an Ingress yaml file
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: nginx.local
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
12. Apply the Ingress yaml file
```cmd
kubectl apply -f nginx-ingress.yaml
```
13. Get the Minikube IP
```cmd
minikube ip
```
14. Add the IP to the hosts file
```text
<minikube-ip> nginx.local
```
15. Verify the deployment and service
```cmd
kubectl get deployments
kubectl get services
```
16. Get the Ingress IP
```cmd
kubectl get ingress
```
17. Get the Service list
```cmd
kubectl get services
```
18. Access the nginx service
```cmd
minikube service nginx-service --url
```
# Configure Nginx
If you want to customize the Nginx configuration, you can use a ConfigMap.
## Create a ConfigMap YAML file: `nginx-configmap.yaml`
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    events {}
    http {
      server {
        listen 80;
        location / {
          return 200 'Hello, Kubernetes!';
          add_header Content-Type text/plain;
        }
      }
    }
```
## Apply the ConfigMap:
```bash
kubectl apply -f nginx-configmap.yaml
```
## Update the Deployment to use the ConfigMap:
nginx-deployment.yaml (updated)
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
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
## Apply the updated Deployment:
```bash
kubectl apply -f nginx-deployment.yaml
```
## Restart the Pods:
```bash
kubectl rollout restart deployment nginx-deployment
```


## Verify the Setup
Check the Pods:
```cmd
kubectl get pods
```
Access the Nginx Service:
```cmd
minikube service nginx-service --url
```