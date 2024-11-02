# Spring REST

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

