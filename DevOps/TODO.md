## `Create a Kubernetes environment locally using Minikube and Rancher`

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