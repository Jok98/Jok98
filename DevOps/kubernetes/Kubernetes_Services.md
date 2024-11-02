# Kubernetes Services
### Replacing Netflix Eureka
Kubernetes has a built-in discovery service based on kubernetes services and the kube-proxy run time component.<br>
Kubernetes discovery service doesn't require a client library so it make it independent to the programming language.<br>

## How Kubernetes will be used
- For each microservice, database, and queue manager that will be deployed in kube
    -> one `deployment object` and one `service object` will be created.
    -> For all the components (except for the `edge server` named gateway) the service type will be `ClusterIP`
    -> For the `edge server` the service type will be `NodePort` accepting external https requests.
- The config server will use  a `configMap` containing the configuration files.
- To hold credentials for the config server and its clients will be created a `secret object` for each.

## Spring Boot's support
- **graceful shutdown** When applying graceful shutdown, a microservice stops accepting new requests and waits for a configurable time for active requests to complete before it shuts down the application.
On Config Server properties
```yml
server.shutdown: graceful
spring.lifecycle.timeout-per-shutdown-phase: 20s
```
- **Liveness and readiness probes**
    - Liveness probe: checks if the application is running.
    - Readiness probe: checks if the application is ready to accept requests.
  Spring Boot Actuator provides endpoints for these probes.
    - /actuator/health/liveness
    - /actuator/health/readiness
    They can either be declared by configuration or implementation in source code
On Config Server properties
```yml
management.endpoint.health.probes.enabled: true
management.endpoint.health.group.readiness.include: readinessState, rabbit, db, mongo
```