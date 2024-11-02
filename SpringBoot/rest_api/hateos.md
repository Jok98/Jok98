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

### HAL
HAL Explorer is a browser-based tool for exploring and interacting with RESTful APIs that follow the Hypertext Application Language (HAL) standard. HAL is a simple format that gives a consistent and easy way to hyperlink between resources in your API. HAL Explorer provides a user-friendly interface to navigate these links and interact with the API.

Key features of HAL Explorer:
- **Hypermedia Navigation**: Allows users to navigate through API resources using hypermedia links.
- **Self-Discovery**: Automatically discovers and displays available links and resources.
- **Interactive**: Users can perform CRUD operations directly from the interface.
- **Visualization**: Presents a clear and structured view of the API's resources and their relationships.

To use HAL Explorer with a Spring Boot application, you typically need to include the `spring-data-rest-hal-explorer` dependency in your `pom.xml`:

```xml
<dependency>
    <groupId>org.springframework.data</groupId>
    <artifactId>spring-data-rest-hal-explorer</artifactId>
</dependency>
```

Once included, HAL Explorer is usually accessible at `http://localhost:8080/explorer` in your Spring Boot application.