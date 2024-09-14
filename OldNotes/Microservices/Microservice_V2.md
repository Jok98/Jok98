## Defining a Microservice
```text
Microservices involve decomposing a monolithic application into smaller, independent software components, each of which has a vertical implementation focused on a single service or a few services that are closely related.
```
### Characteristics
- Every microservice has its own database and should be not shared with other services.
- Must communicate with other services through well-defined APIs.
- Each instance of a microservice should be stateless and needs to runs as a separate process.

### Goals
- **Scalability**: it's the capability of a system to handle a growing or a declining of requests through the addition or removal of instances of a service.
- **Resilience**: it's the capability of a system to recover from failures and continue to function.

## Design patterns

### Service Discovery
```text
Is a mechanism used in microservices architectures to automatically detect and manage the network locations (like IP addresses and ports) of service instances. 
This process allows services to find and communicate with each other dynamically without hard-coding the network details.
```
#### Key Points
- **Dynamic Discovery**: As services start and stop or change locations, service discovery helps other services find their correct endpoints automatically.
- **Registry**: A centralized service registry keeps a record of available service instances and their locations, often updated dynamically.
- **Load Balancing**: Service discovery often integrates with load balancers to distribute traffic evenly across healthy service instances.
- **Resilience**: It improves resilience by routing requests only to healthy and available services, avoiding downtime.

### Edge Server
```text
Is a service that receive all the requests from the clients and route them to the appropriate microservice.
Allow to choose which microservice has to be exposed to external calls and which not.
The exposed ones are protected by a security layer (OAuth2, JWT, etc).
Can act as reverse proxy integrating a discovery service to provide dynamic load balancing.
```

### Reactive Microservices
```text
Use a non blocking I/O to handle requests and responses allowing to not block the thread and to handle more requests.
Can be implemented using asynchronous messages or synchronous requests using a reactive framework like Spring WebFlux that use non-blocking I/O.
```

### Central Configuration
```text
Use a central configuration service to store all the configuration of the microservices.
```
#### Key Points
- **Centralized Management**: Stores configuration files or settings in a central repository, making it easy to update and manage configurations for multiple services from one place.
- **Consistency**: Ensures all services use the same configuration, reducing the risk of discrepancies and configuration drift.
- **Dynamic Updates**: Allows for real-time updates to configurations without requiring redeployment of services, improving agility and response to changing needs.
- **Simplified Deployment**: Eases the deployment process by centralizing control over configuration changes, minimizing manual errors.

### Centralized log analysis
```text
Is the practice of aggregating logs from multiple sources into a single, central location or platform. 
This approach makes it easier to analyze and monitor logs in real-time, detect anomalies, and troubleshoot issues across a distributed system.
```
#### Key Points
- **Aggregation**: Collects logs from various sources into one central repository.
- **Simplified Troubleshooting**: Allows for quick searching and correlation of logs to identify issues across different components.
- **Improved Monitoring**: Provides a unified view of system health and performance, enabling proactive monitoring and alerting.
- **Enhanced Security and Compliance**: Centralized storage helps ensure logs are retained and managed according to security and regulatory requirements.

### Distributed Tracing
```text
Is a technique used to monitor and observe requests as they flow through a distributed system, such as a microservices architecture. 
It helps track the path of a request across multiple microservices to identify where delays, errors, or failures occur.
```
#### Key Points
- **Correlation ID** : A unique identifier is attached to each request and carried across all services to link related events together.
- **Centralized Logging**: Logs from different services are collected in a central place, making it easier to analyze the entire flow.
- **Performance Monitoring**: By recording timestamps when requests enter and exit each service, it helps identify slow or failing services in a call chain.

### Circuit Breaker
```text
Is used in microservices architectures to prevent cascading failures and improve system resilience. 
It acts as a protective mechanism that monitors the interactions between services and temporarily blocks or "breaks" calls to a failing service to avoid repeated failures.
```
#### Key Points
- **Failure Detection**: The circuit breaker monitors the success and failure rates of service calls. If failures exceed a certain threshold, the circuit breaker "trips" and stops further calls.
- **Open State**: When the circuit breaker is "open," requests to the failing service are immediately returned with an error, preventing additional strain on the system.
- **Half-Open State**: After a cooldown period, the circuit breaker allows a few test requests to see if the service has recovered. If successful, it "closes" the circuit; otherwise, it remains open.
- **Closed State**: The normal state where requests pass through the circuit breaker to the service as usual.

### Control Loop
```text
The control loop will constantly observe the actual state of the system landscape, comparing it with a desired state, as specified by the operators.
If the two states differ, it will take action to make theactual state equal to the desired state.
```

### Centralized monitoring and alarms
```text
Is the task assigned to a monitor service which is capable of collecting metrics about hardware resource usage for each microservice instance level.
```

---



| Design Pattern             | Spring Boot                          | Spring Cloud/Netflix OSS                | Kubernetes                        | Istio                           |
|----------------------------|--------------------------------------|-----------------------------------------|-----------------------------------|---------------------------------|
| **Service Discovery**       |                                      | Netflix Eureka and Spring Cloud LoadBalancer | Kubernetes kube-proxy and service resources |                                 |
| **Edge Server**             |                                      | Spring Cloud Gateway and Spring Security OAuth | Kubernetes Ingress controller     | Istio Ingress Gateway           |
| **Reactive Microservices**  | Project Reactor and Spring WebFlux   |                                         |                                   |                                 |
| **Central Configuration**   | Spring Config Server                 |                                         | Kubernetes ConfigMaps and Secrets |                                 |
| **Centralized Log Analysis**|                                      |                                         | Elasticsearch, Fluentd, and Kibana |                                 |
| **Distributed Tracing**     | Micrometer Tracing and Zipkin        |                                         |                                   | Jaeger                          |
| **Circuit Breaker**         | Resilience4j                         |                                         |                                   | Outlier Detection               |
| **Control Loop**            |                                      |                                         | Kubernetes controller managers    |                                 |
| **Centralized Monitoring and Alarms** |                           |                                         |                                   | Kiali, Grafana, and Prometheus  |




