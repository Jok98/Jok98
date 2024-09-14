# SpringBoot

`It simplifies Java application development through convention over configuration`

### Key points :
- **Fat JAR files** : <br>
`SpringBoot simplifies the creation of self-contained JAR files, including an embedded server, making it easy to deploy and run Spring applications without external dependencies`

- **@SpringBootApplication Annotation** : <br>
`This annotation is the entry point dor any Spring Boot Application, it combine three commonly used annotations :`
  - `@EnableAutoConfiguration`
  - `@ComponentScan`
  - `@Configuration`
```java
@SpringBootApplication
//Looks for Spring components and configuraion classes
//The application class itself becomes a configuration class
//Looks for JAR files in the classpath that it can configure automatically
public class MyApp { 
    public static void main(String[] args) {
        SpringApplication.run(MyApp.class, args);
    }
}
```

- **Component Scanning** : <br>
`This automatically detects and registers beans within a specified package or sub-pakages, helping to reduce boilerplate configuration`

- **Java-based Configuration** : <br>
`Instead of relying on xml configuration, SpringBoot uses Java-based configuration to define beans and handle dependency injection programmatically.`

---

## Component Scanning
`A spring component`
```java
@Component
public class MyComponentImpl implements MyComponent { ...
```

`Auto injection (auto-wired) of the component in another component through @Autowired Annotation`
```java
public class AnotherComponent {
private final MyComponent myComponent;
@Autowired
public AnotherComponent(MyComponent myComponent) {
this.myComponent = myComponent;
}
```

## Java-based configuration
`To override Spring Boot’s default configuration, annotate a class with @Configuration`

**Ex**
`If we want to set up a filter in the processing of HTTP requests`
```java
@Configuration
public class SubscriberApplication {
    @Bean
    public Filter logFilter() {
        CommonsRequestLoggingFilter filter = new
        CommonsRequestLoggingFilter();
        filter.setIncludeQueryString(true);
        filter.setIncludePayload(true);
        filter.setMaxPayloadLength(5120);
        return filter;
    }
```