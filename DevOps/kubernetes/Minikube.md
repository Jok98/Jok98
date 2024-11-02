# Minikube

Minikube is a tool that makes it easy to run Kubernetes locally. <br>
Minikube runs a single-node Kubernetes cluster inside a VM on a local machine.

## Profile

In order to run multiple clusters on the same machine, you have to create a profile for each cluster. <br>

```shell
minikube profile list
```

```shell
minikube config get profile
```

to set the profile

```shell
minikube profile <profile-name>
```

## Create a Cluster

Steps :

1. Unset the KUBECONFIG environment variable to ensure that the contexts will be created in the default location
   `~/.kube/config`.
2. Create the cluster using the `minikube start` command where is possible to define some parameters :

```shell
unset KUBECONFIG
```

```shell
minikube start \
 --profile=handson-spring-boot-cloud \
 --memory=10240 \
 --cpus=4 \
 --disk-size=30g \
 --kubernetes-version=v1.26.1 \
 --driver=docker \
 --ports=8080:80 --ports=8443:443 \
 --ports=30080:30080 --ports=30443:30443
```

Truble shooting :

- Exiting due to PROVIDER_DOCKER_NEWGRP: "docker version --format <no value>-<no value>:<no value>" exit status 1:
  permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http:
  //%2Fvar%2Frun%2Fdocker.sock/v1.47/version": dial unix /var/run/docker.sock: connect: permission denied<br>
  Sol ->

```shell
#Add your user to the docker group with the following command:
sudo usermod -aG docker $USER
```

```shell
#activate the group change without having to restart your system
newgrp docker
```

```shell
minikube profile handson-spring-boot-cloud
````

3. After the cluster is created, use the add-on manager to enable additional features :

```shell
minikube addons enable ingress
minikube addons enable metrics-server
```

4. Tesst the cluster :

```shell
kubectl get nodes
```

```shell
kubectl get pods --all-namespaces
```

## Simple Deployment

```shell
kubectl create namespace first-attempts
kubectl config set-context $(kubectl config current-context) --namespace=first-attempts
```

### Nginx Deployment

```shell
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          ports:
            - containerPort: 80

```
- `kind` and `apiVersion` attributes are used to specify that we are declaring a Deployment object.
- `metadata` section is used to describe the Deployment object. For example, we give it the name nginx-deploy
- `spec` section defines our desired state for the Deployment object:
  - `replicas`: 1 specifies we want to have one Pod up and running.
  - `selector` specifies how the Deployment will find the Pods it manages.<br> In this case, the Deployment will look for Pods that have the app label set to `nginx-app`.
  - `template` e section is used to specify how Pods will be created
    - `metadata` section specifies the label, app: nginx-app, which is used to identify the Pods, thereby matching the selector.
    - `spec` section specifies details for the creation of the single container in the Pod, that is, name, image, and what ports it uses.

#### Create the Deployment

```shell
kubectl apply -f kubernetes/first-attempts/nginx-deployment.yaml
```

Result -> Deployment, ReplicaSet, Pod object
```shell
jok@jok-Pc:~/Documents/conf/kube$ kubectl get all
NAME                                READY   STATUS    RESTARTS   AGE
pod/nginx-deploy-58bfb487f9-62sd4   1/1     Running   0          23s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deploy   1/1     1            1           23s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deploy-58bfb487f9   1         1         1       23s
```

#### Create a Service
To enable external communication with the web servers, create a `Service` using the kubernetes/first-attempts/nginx-service.yaml file.
```shell
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx-app
  ports:
    - targetPort: 80
      port: 80
      nodePort: 30080
```
- `kind` and `apiVersion` attributes are used to specify that we are declaring a `Service` object.
- `metadata` section is used to describe the `Service` object. For example, we give it the name `nginx-service`.
- `spec` section defines the desired state of the `Service` object
  - `type` specify that we want NodePort, that is, a `Service` that is accessible externally on a dedicated port on each `node` in the `cluster`.<br>
  This means that an external caller can reach the `Pods` behind this `Service` using this `port` on any of the `nodes` in the `cluster`.
  - `selector` is used by the `Service` to find available `Pods`, which, in our case, are Pods labeled with app: `nginx-app`.
  - `port`: 80 specifies which `port` the `Service` will be accessible on, that is, internally in the `cluster`.
    - `targetPort`: 80 specifies the `port` in the `Pod` where the requests will be forwarded to.
    - `nodePort`: 30080 specifies which port the Service will be externally accessible on using any of the nodes in the cluster.<br>
    By default, a node port must be in the range of 30000 to 32767.

N.B. This port range is used to minimize the risk of colliding with other ports in use.<br>
In a production system, a load balancer is typically placed in front of the Kubernetes cluster,<br>
shielding the external users both from the knowledge of these ports and the IP numbers of the nodes in the Kubernetes cluster.

Apply the service
```shell
kubectl apply -f nginx-service.yaml
```

Result -> Service object
```shell
kubectl get svc
```
Output
```shell
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx-service   NodePort   10.102.192.13   <none>        80:30080/TCP   13m
```

**To access the web server** through the Service’s node port, we need to know the IP address or hostname of the single node in our cluster.<br>
When using the Docker driver, the hostname is always localhost.<br>
The node port, 30080, is forwarded from Docker Engine by the –ports option in the minikube start command.

to continue pg 390



















