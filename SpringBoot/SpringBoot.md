# SpringBoot

**Matteo Moi**

## Table of Contents

1. [`Spring/SpringBoot fundamental concepts`](#springspringboot-fundamental-concepts)
    - [Inversion of Control (IoC)](#inversion-of-control-ioc)
    - [Dependency Injection](#dependency-injection)
        - [Types of Injection in Spring](#types-of-injection-in-spring)
            - [Constructor Injection](#constructor-injection)
            - [Setter Injection](#setter-injection)
            - [Field Injection](#field-injection)

2. [`SpringBoot Annotation`](#springboot-annotation)
    - [@SpringBootApplication](#springbootapplication)
        - [@Component](#component)
        - [Specialized Stereotypes](#specialized-stereotypes)
        - [@Configuration](#configuration)

3. [`Spring Data`](#spring-data)
    - [Configuration](#configuration-1)
    - [Entity](#entity)
        - [JPA](#jpa)
        - [Mongo](#mongo)
    - [Repository](#repository)
    - [Reactive Repository](#reactive-repository)
    - [Service](#service)

4. [`Spring REST`](#spring-rest)
    - [@RestController](#restcontroller)
    - [@PostMapping](#POST)
    - [@GetMapping](#GET)
    - [@PutMapping](#PUT)
    - [@DeleteMapping](#DELETE)
    - [Global Exception Handling](#Global-Exception-Handling)

5. [`Spring Cloud`](#spring-cloud)
    - [Spring Cloud Stream](#spring-cloud-stream)
    - [Core concepts](#core-concepts)

6. [`In Progress`](#in-progress)

## Spring/SpringBoot fundamental concepts

### Inversion of Control (IoC)

**Definition**: IoC is a design principle where the control flow of a program is inverted. Instead of the application
code controlling the flow, the framework takes control of the flow and instantiates and manages the lifecycle of
objects.

### Dependency Injection

**Definition**: It is a technique where an object receives its dependencies from an external source (in this case Spring
Framework) rather than creating them internally.

#### Types of Injection in Spring

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

---

## Spring Data

In Spring Data, an entity represents a database table, and a repository provides an abstraction to perform CRUD
operations on the entity. Spring Data JPA automates the creation of the repository based on the interfaces you define.

### Configuration

```yaml
spring.datasource.url= jdbc:mysql//localhost:3306/db_name
spring.datasource.username= username
spring.datasource.password= password
```

### Entity

The class is annotated with @Entity and the fields with annotations like @Id and @GeneratedValue to define the primary
key and its auto-generation strategy.

#### JPA

```java

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    // Default constructor required by JPA
    public User() {
    }
}
```

#### Mongo

```java

@Document(collection = "users")  // Specifies the MongoDB collection name
public class User {

    @Id
    private String id;  // MongoDB will automatically generate the `_id` field
    private String name;
    private String email;

    // Default constructor required by Spring Data
    public User() {
    }
}
```

| **Name**                  | **Description**                                                                    |
|---------------------------|------------------------------------------------------------------------------------|
| `GenerationType.AUTO`     | Pick an appropriate strategy for the particular database                           |
| `GenerationType.IDENTITY` | Assign primary keys using database identity column                                 |
| `GenerationType.SEQUENCE` | Assign primary keys using a database sequence                                      |
| `GenerationType.TABLE`    | Assign primary keys using an underlying database table to ensure uniqueness        |
| `GenerationType.UUID`     | Assign primary keys using a globally unique identifier (UUID) to ensure uniqueness |

### Repository

The repository interface provides methods to interact with the database (CRUD ops). Extending JpaRepository (or
CrudRepository) gives these functionalities automatically.

```java

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // You can define custom query methods here
    @Query("SELECT u FROM User u WHERE u.email = ?1")
    User findByEmail(String email);

}
```

#### Reactive Repository

Based on non-blocking I/O, this interface does not return objects or collections of objects; instead, it returns Mono
and Flux objects, which are reactive streams capable of returning either 0...1 or 0...m entities as they become
available on the stream. (Supported by Mongo, not supported by JPA)

```java

@Repository
public interface UserRepository extends ReactiveCrudRepository<User, Long> {

    // You can define custom query methods here
    Flux<User> findByEmail(String email);
}
```

### Service

A service layer is a common way to encapsulate business logic and handle repository interactions.

```java

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
}
```

---

## Spring REST

## Java JSON Data Binding

Also know as:

- **Mapping**
- **Serialization/Deserialization**
- **Marshalling/Unmarshalling**

This is the process to convert JSON to a Java POJO and vice versa. The Jackson Project handles data binding (it is
automatically included in Spring Boot Starter Web). It works through attributes and getter/setter methods of Java POJOs.

## @RestController

```java

@RestController
@RequestMapping("/api/books")
public class BookController {
    @Autowired
    private Book book;
}
```

- **@RestController**: Indicates that the class handles REST requests and automatically serializes responses to JSON.
- **@RequestMapping**("/api/books"): Sets the base URI for all endpoints in the controller.

## POST

```java
// **Create a new book**
@PostMapping
public ResponseEntity<Book> createBook(@RequestBody Book book) {
    Book savedBook = bookRepository.save(book);
    return new ResponseEntity<>(savedBook, HttpStatus.CREATED);
}
```

### POST with Created Location

```java

@PostMapping
public ResponseEntity<Book> createBook(@RequestBody Book book) {
    Book savedBook = bookRepository.save(book);
    URI location = ServletUriComponentsBuilder.fromCurrentRequest()
            .path("/{id}")
            .buildAndExpand(savedBook.getId())
            .toUri();
    return ResponseEntity.created(location).build();
}
```

This response puts the location of the generated entity in the header.  
Example: `(location: http://localhost:8080/book/8)`

## GET

```java
// **Get all books**
@GetMapping
public List<Book> getAllBooks() {
    return bookRepository.findAll();
}
```

```java
// **Get a book by ID**
@GetMapping("/{id}")
public ResponseEntity<Book> getBookById(@PathVariable Long id) {
    Optional<Book> book = bookRepository.findById(id);
    return book.map(value -> ResponseEntity.ok().body(value))
            .orElseGet(() -> ResponseEntity.notFound().build());
}
```

## PUT

```java
// **Update a book**
@PutMapping("/{id}")
public ResponseEntity<Book> updateBook(@PathVariable Long id, @RequestBody Book bookDetails) {
    Optional<Book> optionalBook = bookRepository.findById(id);

    if (optionalBook.isPresent()) {
        Book book = optionalBook.get();
        book.setTitle(bookDetails.getTitle());
        book.setAuthor(bookDetails.getAuthor());
        book.setIsbn(bookDetails.getIsbn());

        Book updatedBook = bookRepository.save(book);
        return ResponseEntity.ok(updatedBook);
    } else {
        return ResponseEntity.notFound().build();
    }
}
```

## DELETE

```java
// **Delete a book**
@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
    Optional<Book> book = bookRepository.findById(id);

    if (book.isPresent()) {
        bookRepository.delete(book.get());
        return ResponseEntity.noContent().build();
    } else {
        return ResponseEntity.notFound().build();
    }
}
```

## Key Annotations

- **@PathVariable**: Extracts values from the URI, e.g., `/api/books/1`
- **@RequestBody**: Binds the HTTP request body to a transfer or domain object.

## Exception Handling

### Global Exception Handling

The correct way to manage exceptions:

- Promote reuse
- Standardize exception responses
- Centralize exception handling

### Error Class

```java
public class ErrorResponse {
    private long timeStamp;
    private String message;
    private String details;

    // constructor
    // getter/setter
}
```

### Create Custom Exception Handler

```java

@ControllerAdvice
public class CustomizedResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {

    private ResponseEntity<Object> buildErrorResponse(Exception ex, HttpStatus status, WebRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(LocalDate.now(), ex.getMessage(), request.getDescription(false));
        return new ResponseEntity<>(errorResponse, status);
    }

    @ExceptionHandler(Exception.class)
    public final ResponseEntity<Object> handleAllExceptions(Exception ex, WebRequest request) {
        logger.error("Exception: ", ex);
        return buildErrorResponse(ex, HttpStatus.INTERNAL_SERVER_ERROR, request);
    }

    @ExceptionHandler(BookNotFoundException.class)
    public final ResponseEntity<Object> handleBookNotFoundException(BookNotFoundException ex, WebRequest request) {
        return buildErrorResponse(ex, HttpStatus.NOT_FOUND, request);
    }
}
```

**@ControllerAdvice** is similar to an interceptor/filter, used to pre-process and post-process.

### Define Exception

```java

@ResponseStatus(code = HttpStatus.NOT_FOUND)
public class BookNotFoundException extends RuntimeException {
    public BookNotFoundException(String message) {
        super(message);
    }
}
```

### Call the Exception in any Controller

```java
throw new BookNotFoundException("Book not found: "+id);
```

#### Error Response:

```json
{
  "timeStamp": "2090-08-19T13:28:16.777397",
  "message": "Book not found 5",
  "detail": "uri=/users/1000"
}
```

## Internationalization (i18n)

Create a `messages.properties` file in the same folder as `application.properties`.

```yaml
good.morning.message=Good Morning
```

For other languages, create `messages_x.properties` files (e.g., for `it`, `fr`, `de`).

```java

@Autowired
private MessageSource messageSource;

@GetMapping(path = "/hello-world-internationalized")
public String helloWorldInternationalized() {
    Locale locale = LocaleContextHolder.getLocale();
    return messageSource.getMessage("good.morning.message", null, "Default Message", locale);
}
```

---

## Spring Cloud

### Spring Cloud Stream

**Definition**: SCS provides a streaming abstraction over messaging, based on the publish and subscribe integration
pattern. SCS comes with built-in support for Apache Kafka and RabbitMQ.

#### Core concepts

- **Message**: A data structure that's used to describe data sent to and received from a messaging system.
- **Publisher (Supplier)**: Sends messages to the messaging system.
- **Subscriber (Consumer)**: Receives messages from the messaging system.
- **Destination**: Used to communicate with the messaging system.
    - Publishers use output destinations, and Subscribers use input destinations.
    - Destinations are mapped by specific binders to queues and topics in the underlying messaging system.
- **Binder**: Provides the actual integration with a specific messaging system (similar to JDBC with a specific
  database).

### System Messaging Implementation

- **Publisher**

```java

@Bean
public Supplier<String> myPublisher() {
    return () -> new Date().toString();
}
```

- **Consumer**

```java

@Bean
public Consumer<String> mySubscriber() {
    return s -> System.out.println("Message received: " + s);
}
```

- **Supplier/Consumer**

```java

@Bean
public Function<String> myProcessor() {
    return s -> "Message received: " + s;
}
```

- **Properties**

```yaml
# To make Spring aware of these functions
spring.cloud.function:
  definition: myPublisher; MyProcessor; mySubscriber

# To tell Spring what destination to use for each function
spring.cloud.stream.bindings:
  myPublisher-out-0:
    destination: myProcessor-in
  myProcessor-in-0:
    destination: myProcessor-in
  myProcessor-out-0:
    destination: myProcessor-out
  myConsumer-in-0:
    destination: myProcessor-out
```

Result: `myPublisher -> myProcessor -> mySubscriber`

By default, the supplier is triggered every second, but if you want to trigger it by an external event (e.g., a REST API
is called), use:

```java

@Autowired
private StreamBridge streamBridge;

@PostMapping
void exApi(@RequestBody String body) {
    streamBridge.send("myProcessor-in-0", body);
}
```

## in progress...
