# Kubernetes

Is a container orchestration platform for the management of containerized applications.

## Features

- **Automatic Scaling**: Scale containers based on demand.
- **Service Discovery**: Help microservices find and communicate with each other.
- **Load Balancing**: Distribute load among multiple instances of a microservice.
- **Self-Healing**: Do health checks and replace failing instances.
- **Zero Downtime Deployment**: Update applications without downtime.

## Container Orchestration Platforms

- **AWS Specific**
    - **ECS**: Elastic Container Service.
    - **Fargate**: Serverless version of ECS.

- **Cloud neutral** `Kubernetes`
    - **GKE**: Google Kubernetes Engine.
    - **AKS**: Azure Kubernetes Service.
    - **EKS**: Elastic Kubernetes Service.


## Kubernetes Api Objects

K8s defines apis for managing its resources that are :
### `Node` 
It represents a server virtual or physical in the `cluster`

### `Pod` 
It represents the smallest possible deployable component, usually consisting in a single container<br>
but can also be multiple containers that share same IP and port range (cnts can communicate with each other at localhost level)

### `Deployment`
is used to upgrade and deploy Pods.<br>
it hands over the responsibility of creating and monitoring the pods to a `ReplicaSet`.<br>
When a `Deployment` is created its role is just to create a `ReplicaSet` to manage the pods.

### `ReplicaSet`
It is responsible for ensuring that a specified number of pod replicas are running at any given time.<br>
If a pod goes down, the `ReplicaSet` will create a new one to replace it.



# Milestone to achieve

`Create a Kubernetes environment locally using Minikube and Rancher`

## Hierarchy

**Lowest Layer**: Kubernetes is the core technology, responsible for orchestrating containerized applications.

**Middle Layer**: Minikube runs Kubernetes in a local virtual machine, allowing developers to use Kubernetes features
locally.

**Highest Layer**: Rancher oversees multiple Kubernetes clusters, including those created with Minikube, k3s, or a cloud
provider, allowing for streamlined management and monitoring across environments.

| Level  | Technology | Role                     | Purpose                                           | Hierarchy Level                |
|--------|------------|--------------------------|---------------------------------------------------|--------------------------------|
| Low    | Kubernetes | Container Orchestrator   | Core system for deploying and managing containers | Foundation (Core)              |
| Middle | Minikube   | Local Kubernetes Cluster | Local development and testing                     | Development Tool (Local Setup) |
| High   | Rancher    | Cluster Management Tool  | Manage multiple Kubernetes clusters               | Cluster Manager (Higher Level) |