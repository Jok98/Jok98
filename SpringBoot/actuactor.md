## Actuactor

Actuator is a Spring Boot module that provides monitoring and management capabilities.
It provides a number of built-in endpoints that can be used to monitor and interact with your application.
Most common endpoints:

| Endpoint              | Description                                                           |
|-----------------------|-----------------------------------------------------------------------|
| `/actuator/health`    | Shows application health information.                                 |
| `/actuator/info`      | Displays arbitrary application info.                                  |
| `/actuator/metrics`   | Shows metrics information for the current application.                |
| `/actuator/httptrace` | Displays HTTP trace information.                                      |
| `/actuator/beans`     | Displays a complete list of all the Spring beans in your application. |

To expose all endpoints, add the following to `application.properties`:

```properties
management.endpoints.web.exposure.include=*
```

To access the endpoints, go to `http://localhost:8080/actuator`.