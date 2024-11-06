```tree
Microservices Architecture
|
├── Minikube
|   └── Local Cluster Environment
|       └── Manages local Kubernetes cluster
|
├── Kubernetes
|   ├── API Server
|   ├── Scheduler
|   ├── Controller Manager
|   ├── ETCD (key-value store)
|   └── Nodes
|       ├── Kubelet
|       ├── Kube Proxy
|       └── Pods
|           └── Microservices
|
├── NGINX Ingress Controller
|   └── Ingress Rules
|       ├── Routes external traffic to services
|       └── Handles SSL termination with Cert Manager
|
├── OAuth2 Authentication
|   └── Auth Server
|       ├── Issues access tokens for services
|       └── Manages user authentication
|
├── Cert Manager
|   ├── Manages SSL/TLS certificates
|   └── Integrates with NGINX for HTTPS traffic
|
├── Istio (Service Mesh)
|   ├── Traffic Management
|   ├── Security
|   ├── Observability
|   └── Policy Enforcement
|   └── Service Mesh
|       ├── Envoy Proxies
|       |   └── Manages communication between services
|       ├── Control Plane
|       |   ├── Pilot (service discovery and configuration)
|       |   ├── Mixer (policy checks and telemetry)
|       |   └── Citadel (manages service-to-service authentication)
|       └── Gateway (external traffic management)
|
└── EFK Stack
    ├── Elasticsearch
    |   └── Data storage and indexing
    ├── Fluentd
    |   └── Log collection and forwarding
    └── Kibana
        └── Visualization of logs and metrics

```




