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