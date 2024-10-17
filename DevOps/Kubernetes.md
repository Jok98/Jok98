## Table of Contents
- [Kubernetes](#kubernetes)
  - [Features](#features)
  - [Container Orchestration Platforms](#container-orchestration-platforms)
  - [Kubernetes Api Objects](#kubernetes-api-objects)
    - [Node](#node)
    - [Pod](#pod)
    - [Deployment](#deployment)
    - [ReplicaSet](#replicaset)
    - [Service](#service)
    - [Ingress](#ingress)
    - [Namespace](#namespace)
    - [ConfigMap](#configmap)
    - [Secret](#secret)
    - [DaemonSet](#daemonset)
  - [Run Time Components](#run-time-components)
    - [Master Node](#master-node)
      - [Api Server](#api-server)
      - [etcd](#etcd)
      - [Controller Manager](#controller-manager)
      - [Scheduler](#scheduler)
    - [Data Plane](#data-plane)
      - [Kubelet](#kubelet)
      - [Kubeproxy](#kubeproxy)
      - [Container Runtime](#container-runtime)
      - [Kubernetes DNS](#kubernetes-dns)
  - [Sequence of Events](#sequence-of-events)
  - [Milestone to achieve](#milestone-to-achieve)
  - [Hierarchy](#hierarchy)

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
It represents a server, virtual or physical in the `cluster`

### `Pod` 
It represents the smallest possible deployable component, usually consisting in a single container<br>
but can also be multiple containers that share same IP and port range (cnts can communicate with each other at localhost level)

### `Deployment`
is used to upgrade and deploy Pods.<br>
it hands over the responsibility of creating and monitoring the `pods` to a `ReplicaSet`.<br>
When a `Deployment` is created its role is just to create a `ReplicaSet` to manage the `pods`.

### `ReplicaSet`
It is responsible for ensuring that a specified number of `pod` replicas are running at any given time.<br>
If a `pod` goes down, the `ReplicaSet` will create a new one to replace it.

### `Service`
It is an abstraction which defines a logical set of `pods` and a policy by which to access them.<br>
A `Service` is assigned an IP address and a DNS name, which never changes, even if the `pods` behind the service are replaced.<br>
A `Service` provides a stable endpoint for the `pods` that it manages.<br>
By default, a `Service` is exposed inside the `cluster`, but it can also be exposed outside the `cluster`.<br>
A `Service` is defined using a YAML file, which specifies the type of `service`, the selector, and the ports.<br>

### `Ingress`
It manages external access to the services in a `cluster`, typically HTTP/HTTPS.<br>
It can route traffic to different `services` based on the URL path or host in the HTTP header.<br>

### `Namespace`
Is used to group and isolate resources in a `cluster`.<br>
The name of the resources must be unique within a `namespace`, but not across `namespaces`.<br>

### `ConfigMap`
Is used to store configuration used by pods.<br>
`ConfigMap` can be mapped into a running `pod` as environment variables or files.<br>

### `Secret`
It is used to store sensitive data, such as passwords, OAuth tokens, and SSH keys.<br>
`Secrets` are stored in `base64` encoded format, but they are not encrypted.<br>
It can be read by anyone with full access to the `cluster`.<br>

### `DaemonSet`
Are used to automatically distribute a copy of a `pod` on each node and keep it running.

## Run Time Components

- ## Master Node
### `Api Server`
The entry point to the control plane.<br>
It exposes the `Kubernetes API` (ex. kubectl)

### `etcd`
Is a distributed key-value store for all `cluster` data.

### `Controller Manager`
It contains a number of controllers that continuously evaluate the desired state versus the current state of the objects defined in the `etcd` database.<br>

### `Scheduler`
Is responsible for assigning newly created `pods` to a `node` with available capacity.<br>
Affinity rules can be used to control how `Pods` are assigned to `Nodes`.

- ## Data Plane
### `Kubelet`
It is an agent that runs on each `node` in the `cluster`.<br>
Ensure that `pods` are running and healthy on the `node`.<br>
It acts as a conduit between the API server and the container runtime on its node.

### ` Kubeproxy`
Is deployed as a `DaemonSet` on each `node` in the `cluster`.<br>
It enables the `service` concept in `Kubernetes` and is capable of forwarding traffic to the correct `pod`.

### `Container Runtime`
Is the software that is responsible for running containers (support for Docker engine was removed).<br>
As today can be used any implementation of the Kubernetes Container Runtime Interface (CRI) such as `containerd` or `CRI-O`.

### `Kubernetes DNS`
Is a DNS server that runs in the `cluster` and provides DNS-based service discovery.<br>
It assigns a DNS name to each `service` and `pod` in the `cluster`.<br>
The `DNS` server is typically deployed as a `Deployment` and a `Service`.

---

## Sequence of Events
1. A user uses `kubectl` to send in a new desired state to Kubernetes, containing manifests declaring a new `Deployment`, `Service`, `Ingress`, etc. object.<br><br>
2. The `Ingress` defines a route to the `Service` object and the `Service` is defined to select `Pods` that are configured by the Deployment.<br><br>
3. `kubectl` talks to the `API Server` and it stores the new desired state in `etcd` database.<br><br>
4. Various `Controllers` will react to the creation of the new object and take the following actions:<br>
    - For the `Deployment` :
      - New `ReplicaSet` and `Pod` will be registered in the `API Server`.
      - The `Scheduler` will see the new `Pod` and schedule it to the appropriate `worker node`.
      - On the `worker node`, the `Kubelet` agent will launch containers as described by the `Pod`.<br>
      - The `Kubelet` will use the `Container Runtime` on the `worker node` to manage the container.<br><br>

    - For the `Service` :
      - A `DNS` name will be registered in the `Kubernetes DNS` server. for the `Service`.<br>
      - The `Kube-Proxy` will be able to route requests that us ethe `DNS` to one of the available `Pods`.<br><br>
      
    - For the `Ingress` :
      - The `Ingress Controller` will set up routes according to the `Ingress` object and be ready to accept requests from the outside.<br>
      - External request that match the routes defined by the `Ingress` will be forwarded by the `Ingress` Controller to the appropriate `Service`.<br>
        These requests will be forwarded by the `Kube-Proxy` to the appropriate `Pod`.<br>

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