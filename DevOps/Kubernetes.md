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

## Components

- **Master Node**: Control plane that manages the cluster.
    - **API Server**: Frontend for the Kubernetes control plane.
    - **Scheduler**: Assigns workloads to nodes.
    - **Controller Manager**: Monitors the state of the cluster.
    - **etcd**: Key-value store for all cluster data.

- **Kubelet**
  - Function: The primary node agent.
  - Role: Ensures containers are running in pods.
  - Operation: Receives pod specifications from the API server and manages the containers via the container runtime (e.g., Docker, containerd).

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