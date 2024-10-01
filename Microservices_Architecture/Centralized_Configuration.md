# Spring Cloud Config Server
## Client side

we need to add `spring-cloud-starter-config` dependency to the `pom.xml` file.

This will allow the client to connect to the Config Server and fetch the configurations.

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>
```

application.properties
```properties
spring.application.name=microservice-name
spring.cloud.config.uri=optional:configserver:http://localhost:8888
```

calling the configuration
```java
@Value("${key}")
private String value;
```



## Server side

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-config-server</artifactId>
</dependency>
```

application.properties
```properties
spring.application.name=config-server
server.port=8888
# It points to repo where the configurations are stored
# client side will fetch the configurations from here looking for microservice-name.properties
spring.cloud.config.server.git.uri=URL
```

On Application.java
```java
@EnableConfigServer
@SpringBootApplication
public class ConfigServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(ConfigServerApplication.class, args);
    }
}
```

##  Dynamic Refresh
Of Properties Using /refresh

To enable the dynamic refresh of properties, we need to add the `spring-boot-starter-actuator` dependency to the `pom.xml` file.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

Expose the refresh endpoint in the properties.appilcation file
```properties
management.endpoints.web.exposure.include=refresh
```

Enable @RefreshScope on any beans or classes whose properties should be dynamically reloaded

```java
@RefreshScope
@RestController
public class MyController {
    @Value("${key}")
    private String value;
}
```

Trigger a refresh by calling the /actuator/refresh endpoint

```bash
curl -X POST http://localhost:8080/actuator/refresh
```

## Profiles

To use profiles, we need to create a file named `application-{profile}.properties` in the repository.

To use a profile as default, we need to add the following line to the `application.properties` file.
```properties
spring.profiles.active=dev
```

