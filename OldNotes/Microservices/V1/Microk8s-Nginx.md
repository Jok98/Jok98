# Microk8s
## Install Microk8s
```bash
sudo snap install microk8s --classic
```
## Add user to microk8s group
```bash
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```
## Start microk8s
```bash
microk8s start
```
## Enable microk8s ingress
```bash
microk8s enable ingress
```
## Check Ingress Controller
```bash
microk8s kubectl get pods -A | grep ingress
```
## Test Connection
```bash
curl -v 127.0.0.1
```
### Output
```html
*   Trying 127.0.0.1:80...
* Connected to 127.0.0.1 (127.0.0.1) port 80 (#0)
> GET / HTTP/1.1
> Host: 127.0.0.1
> User-Agent: curl/7.81.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< Date: Wed, 26 Jun 2024 22:32:47 GMT
< Content-Type: text/html
< Content-Length: 146
< Connection: keep-alive
<
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
* Connection #0 to host 127.0.0.1 left intact
```

## Get ConfigMaps List
### When MicroK8s enables Ingress, it generates three ConfigMaps in the ingress namespace.
```bash
microk8s kubectl -n ingress get configmap
```
### To enable exposing services over HTTP, you must edit the load balancer ConfigMap.

## Edit Load Balancer ConfigMap
```bash
microk8s kubectl -n ingress edit configmaps nginx-load-balancer-microk8s-conf
```
## Add the following lines to the ConfigMap:
```yaml
data:
  use-forwarded-headers: "true"
```
### Output
```yaml
apiVersion: v1
kind: ConfigMap
data:
  use-forwarded-headers: "true"
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"ConfigMap","metadata":{"annotations":{},"name":"nginx-load-balancer-microk8s-conf","namespace":"ingress"}}
  creationTimestamp: "2024-06-26T22:32:31Z"
  name: nginx-load-balancer-microk8s-conf
  namespace: ingress
  resourceVersion: "1324"
  uid: 9ce95770-13db-4d05-a34d-b16f30e0fc63
```
## Check the Ingress Controller
```bash
microk8s kubectl get pods -A | grep ingress
```
##  Confirm Ingress Setup
```bash
microk8s kubectl -n ingress logs [pod-name] | grep reload
```
### Output
```bash
I0626 22:32:38.730897       7 controller.go:190] "Configuration changes detected, backend reload required"
I0626 22:32:38.768356       7 controller.go:207] "Backend successfully reloaded"
I0626 22:32:38.768505       7 event.go:285] Event(v1.ObjectReference{Kind:"Pod", Namespace:"ingress", Name:"nginx-ingress-microk8s-controller-hnctj", UID:"7a85f4a2-bf49-4e88-8523-cbe0b8906796", APIVersion:"v1", ResourceVersion:"1338", FieldPath:""}): type: 'Normal' reason: 'RELOAD' NGINX reload triggered due to a change in configuration
I0626 23:04:16.828061       7 controller.go:190] "Configuration changes detected, backend reload required"
I0626 23:04:16.864926       7 controller.go:207] "Backend successfully reloaded"
I0626 23:04:16.865282       7 event.go:285] Event(v1.ObjectReference{Kind:"Pod", Namespace:"ingress", Name:"nginx-ingress-microk8s-controller-hnctj", UID:"7a85f4a2-bf49-4e88-8523-cbe0b8906796", APIVersion:"v1", ResourceVersion:"1338", FieldPath:""}): type: 'Normal' reason: 'RELOAD' NGINX reload triggered due to a change in configuration
```

## Create a deployment
```yaml
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
## Create a service
```yaml
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
  type: ClusterIP
```
## Create an Ingress
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
### Apply the configuration

## Update local file /etc/hosts
```bash
sudo echo "127.0.0.1 nginx.local" >> /etc/hosts
```
## Test the Ingress
```bash
curl -v nginx.local
```

---

## Dashboard
```bash
microk8s enable dashboard
```

## Enable Proxy
```bash
microk8s kubectl proxy
```

## Get the token
```bash
microk8s kubectl -n kube-system get secret | grep default-token
```

## Access the dashboard
```text
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```
---

## Expose the nginx service
```bash
microk8s kubectl -n ingress edit configmaps nginx-load-balancer-microk8s-conf
```
#### Add the following lines to the ConfigMap:
```yaml
data:
  bind-address: "0.0.0.0"
```

## Get microk8s IP
```bash
microk8s kubectl get nodes -o wide
```
## Add dns entry for microk8s
```bash
echo "$(microk8s kubectl get nodes -o wide | grep -v NAME | awk '{print $6}') nginx.local" | sudo tee -a /etc/hosts
```
### Output
```text
NAME   STATUS   ROLES    AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION                       CONTAINER-RUNTIME
jok    Ready    <none>   37m   v1.29.4   172.31.169.8   <none>        Ubuntu 22.04.3 LTS   5.15.153.1-microsoft-standard-WSL2   containerd://1.6.28
```
### Use the internal IP address to access the service


