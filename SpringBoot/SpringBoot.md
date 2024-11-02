# SpringBoot

# Spring/SpringBoot fundamental concepts

## Inversion of Control (IoC)

**Definition**: IoC is a design principle where the control flow of a program is inverted. Instead of the application
code controlling the flow, the framework takes control of the flow and instantiates and manages the lifecycle of
objects.

## Dependency Injection

**Definition**: It is a technique where an object receives its dependencies from an external source (in this case Spring
Framework) rather than creating them internally.

### Types of Injection in Spring

- **Constructor Injection**

```java

@Component
class Client {
    private final Service service;

    // Constructor injection
    @Autowired
    public Client(Service service) {
        this.service = service;
    }
}
```

- **Setter Injection**

```java

@Component
class Client {
    private Service service;

    // Setter injection
    @Autowired
    public void setService(Service service) {
        this.service = service;
    }
}
```

- **Field Injection**

```java

@Component
class Client {

    // Field injection
    @Autowired
    private Service service;
}
```

## SpringBoot Annotation

- **@SpringBootApplication**
- **@Component**
- **@Configuration**

### @SpringBootApplication

```java

@SpringBootApplication
public class MyApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }
}
```

This annotation is a shortcut that combines three fundamental annotations in Spring:

| Annotation               | Description                                                                                                                                                                            |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| @Configuration           | Indicates that the class can be used by the Spring IoC container as a source of bean definitions.                                                                                      |
| @EnableAutoConfiguration | Enables the auto-configuration, which automatically configures your application based on the dependencies you have added.                                                              |
| @ComponentScan           | Instructs Spring to scan the current package and its sub-packages for components, configurations, and services, allowing it to detect and register beans with the application context. |

### @Component

It is used to mark a Java class as a "component" so that Spring can automatically detect and manage the class as a bean
within its Inversion of Control (IoC) container without explicit configuration.

```java

@Component
public class MyComponent {
    public void performAction() {
        // Business logic here
    }
}
```

#### Specialized Stereotypes

| Annotation      | Description                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------|
| @Service        | Indicates that the class holds business logic                                               |
| @Repository     | Indicates that the class is a Data Access Object (DAO) and will interact with the database. |
| @Controller     | Used in Spring MVC to denote a controller class that handles HTTP requests                  |
| @RestController | Combines @Controller and @ResponseBody. It is used in RESTful web services                  |

### @Configuration

Purpose:

- Define Beans in Java: @Configuration classes are used to define beans using methods annotated with @Bean. This enables
  type-safe, refactor-friendly configuration.
- Initialize Application Context: Acts as a source for the Spring container to generate and manage bean definitions at
  runtime.

```java

@Configuration
public class AppConfig {

    @Bean
    public DataSource dataSource() {
        // Configure and return the necessary JDBC DataSource
    }
}
```


