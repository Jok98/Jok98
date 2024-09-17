# Spring

## Configuring Spring Applications

| Topic                          | Description                                                   | Done |
|--------------------------------|---------------------------------------------------------------|------|
| XML-Based Configuration        | Setting up beans and dependencies using XML files             |      |
| Annotation-Based Configuration | Using annotations like @Component, @Autowired, @Qualifier     |      |
| Java-Based Configuration       | Creating configuration classes using @Configuration and @Bean |      |
| Spring Application Context     | Understanding ApplicationContext and BeanFactory              |      |

## Spring Core Concepts

- ## Spring Bean Lifecycle

| Subtopic               | Description                                                       | Done |
|------------------------|-------------------------------------------------------------------|------|
| Bean Scopes            | Singleton, Prototype, Request, Session, and Global Session scopes |      |
| Bean Lifecycle Methods | @PostConstruct and @PreDestroy annotations                        |      |
| Bean Post Processors   | Customizing bean initialization and destruction                   |      |

- ## Aspect-Oriented Programming (AOP)

| Subtopic                   | Description                                         | Done |
|----------------------------|-----------------------------------------------------|------|
| Introduction to AOP        | Understand cross-cutting concerns                   |      |
| AOP Terminology            | Aspect, Join Point, Pointcut, Advice, Weaving       |      |
| Implementing AOP in Spring | Using @Aspect, @Before, @After, @Around annotations |      |

- ## Spring Expression Language (SpEL)

| Subtopic                  | Description                                                  | Done |
|---------------------------|--------------------------------------------------------------|------|
| Introduction to SpEL      | Using SpEL in annotations and XML configurations             |      |
| Expressions and Operators | Navigating object graphs, method invocation, and collections |      |

- ## Object-Relational Mapping (ORM) with Spring

| Subtopic                    | Description                                                   | Done |
|-----------------------------|---------------------------------------------------------------|------|
| Introduction to ORM         | Understanding ORM and its benefits in Spring                  |      |
| Configuring ORM with Spring | Integrating ORM frameworks like Hibernate and JPA with Spring |      |
| Spring Data JPA             | Simplifying database access with Spring Data JPA              |      |

- ## Spring MVC

| Subtopic                        | Description                                                                       | Done |
|---------------------------------|-----------------------------------------------------------------------------------|------|
| Architecture Overview           | DispatcherServlet, Controllers, Models, and Views                                 |      |
| Controllers and Request Mapping | Using @Controller, @RestController, @RequestMapping, @GetMapping, @PostMapping    |      |
| Handling Form Data              | Data binding with @ModelAttribute, Form validation using @Valid and BindingResult |      |
| View Technologies               | Integrating Thymeleaf, JSP, and FreeMarker                                        |      |
| Internationalization (i18n)     | Implementing locale-specific views and messages                                   |      |

- ## Building RESTful Web Services

| Subtopic            | Description                                      | Done |
|---------------------|--------------------------------------------------|------|
| REST Principles     | Understanding REST architecture                  |      |
| Creating REST APIs  | Consuming and producing JSON/XML                 |      |
| Exception Handling  | Global exception handling with @ControllerAdvice |      |
| Content Negotiation | Handling different media types                   |      |

---

# SpringBoot

- ## Configuration in Spring Boot

| Subtopic                                         | Description                                       | Done |
|--------------------------------------------------|---------------------------------------------------|------|
| Externalized Configuration                       | Using application.properties and application.yml  |      |
| Profiles                                         | Environment-specific configurations with @Profile |      |
| Command-Line Arguments and Environment Variables | Overriding default configurations                 |      |

- ## Spring Boot Actuator

| Subtopic                    | Description                      | Done |
|-----------------------------|----------------------------------|------|
| Monitoring and Management   | Enabling Actuator endpoints      |      |
| Health Checks and Metrics   | Custom health indicators         |      |
| Securing Actuator Endpoints | Protecting sensitive information |      |

- ## Logging

| Subtopic              | Description                                 | Done |
|-----------------------|---------------------------------------------|------|
| Configuring Logging   | Using Logback and Log4j2                    |      |
| Custom Logging Levels | Adjusting log levels for different packages |      |

- ## Security

| Subtopic                        | Description                                       | Done |
|---------------------------------|---------------------------------------------------|------|
| Introduction to Spring Security | Core concepts of authentication and authorization |      |
| Method-Level Security           | Using @Secured, @PreAuthorize, @PostAuthorize     |      |
| OAuth2 and JWT                  | Implementing token-based security                 |      |
| Password Encoding               | Using PasswordEncoder for secure password storage |      |

- ## Testing

| Subtopic            | Description                                     | Done |
|---------------------|-------------------------------------------------|------|
| Integration Testing | Using @SpringBootTest for full context testing  |      |
| MockMVC             | Testing controllers without starting the server |      |
| Test Slices         | Focused testing with @WebMvcTest, @DataJpaTest  |      |

---

# Reactive Programming and WebFlux

- ## Introduction to Reactive Programming

| Subtopic              | Description                             | Done |
|-----------------------|-----------------------------------------|------|
| Reactive Principles   | Non-blocking, asynchronous data streams |      |
| Project Reactor       | Understanding Mono and Flux             |      |
| Backpressure Handling |                                         |      |

- ## Spring WebFlux

| Subtopic               | Description                               | Done |
|------------------------|-------------------------------------------|------|
| Building Reactive APIs | Using @RestController with reactive types |      |
| Functional Endpoints   | Router functions and handler functions    |      |
| Reactive Data Access   | Working with Reactive MongoDB and R2DBC   |      |