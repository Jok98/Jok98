# Spring REST

## Table of Contents

- [Java JSON Data Binding](#java-json-data-binding)
- [@RestController](#restcontroller)
- [POST](#post)
    - [POST with Created Location](#post-with-created-location)
- [GET](#get)
- [PUT](#put)
- [DELETE](#delete)
- [Key Annotations](#key-annotations)
- [Validation](#validation)
- [Exception Handling](#exception-handling)
    - [Global Exception Handling](#global-exception-handling)
    - [Error Class](#error-class)
    - [Create Custom Exception Handler](#create-custom-exception-handler)
    - [Define Exception](#define-exception)
    - [Call the Exception in any Controller](#call-the-exception-in-any-controller)
    - [Error Response](#error-response)
- [Internationalization (i18n)](#internationalization-i18n)

## Java JSON Data Binding

Also known as:

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

## Validation

On pojo/entity

```java
public class Book {
    private int id;
    @Size(min = 2)
    private String title;
    @Past(message = "Publication date should be in the past")
    private LocalDate publicationDate;

}
```

On Controller

```java

@PostMapping
public ResponseEntity<Book> createBook(@Valid @RequestBody Book book) {

```

---

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

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        return buildErrorResponse(ex, HttpStatus.BAD_REQUEST, request);
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

---

## Api Documentation

Using Springdoc OpenAPI

On pom.xml

```xml

<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-ui</artifactId>
</dependency>
```

Springdoc will mange automatically the documentation of the API, found in http://localhost:8080/swagger-ui.html.

It could be customized with annotations

```java
@Operation(summary = "Get all books")

@Parameter(description = "Book Id", required = true)

@ApiResponse(responseCode = "200", description = "Book found")

@Schema(implementation = Book.class)
```

---

## Negociation Content

- ### Return XML

The client can request the response in XML format by setting the `Accept` header to `application/xml`.
The conversion is automatic, managed by jackson library.

On pom.xml

```xml

<dependency>
    <groupId>com.fasterxml.jackson.dataformat</groupId>
    <artifactId>jackson-dataformat-xml</artifactId>
</dependency>
```

- ### Internationalization (i18n)

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

Client need to set the `Accept-Language` header to the desired language.

---

## HATEOAS

(Hypermedia as the Engine of Application State)

It is a constraint of the REST application architecture. It allows the client to interact with the server through
hypermedia links.
On Controller

```java

@GetMapping(path = "/books/{id}")
public EntityModel<Book> retrieveBook(@PathVariable int id) {
    Book book = bookService.findOne(id);
    if (book == null) {
        throw new BookNotFoundException("id-" + id);
    }
    EntityModel<Book> resource = EntityModel.of(book);

    WebMvcLinkBuilder linkTo = linkTo(methodOn(this.getClass()).retrieveAllBooks());
    resource.add(linkTo.withRel("all-books"));

    return resource;
}
```

Response

```json
{
  "id": 1,
  "name": "Book 1",
  "author": "Author 1",
  "price": 1000,
  "_links": {
    "all-books": {
      "href": "http://localhost:8080/books"
    }
  }
}
```

---

## Customize Response

- ### Customize field name

`@JsonIgnoreProperties("book_id")`
On pojo/entity

```java
public class Book {
    @JsonProperty("book_id")
    private int id;
    //...
}
```

---

## Filtering

- ### **Static filtering**

Same filter for all requests

`@JsonIgnore`
On pojo/entity

```java
public class Book {
    @JsonIgnore
    private int id;
    //...
}
```

`@JsonIgnoreProperties(value = {"book_id", "author"})`
On pojo/entity

```java

@JsonIgnoreProperties(value = {"book_id", "author"})
public class Book {
    private int id;
    private String author;
    //...
}
```

- ### **Dynamic filtering**

Customize filtering for a bean for specific REST API

`@JsonFilter("BookFilter")`

On pojo/entity

```java

@JsonFilter("BookFilter")
public class Book {
    private int id;
    private String name;
    //...
}
```

On controller

```java

@GetMapping(path = "/books/{id}")
public MappingJacksonValue retrieveBook(@PathVariable int id) {
    Book book = bookService.findOne(id);
    if (book == null) {
        throw new BookNotFoundException("id-" + id);
    }
    SimpleBeanPropertyFilter filter = SimpleBeanPropertyFilter.filterOutAllExcept("id", "name");
    FilterProvider filters = new SimpleFilterProvider().addFilter("BookFilter", filter);
    MappingJacksonValue mapping = new MappingJacksonValue(book);
    mapping.setFilters(filters);
    return mapping;
}
```

---

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


