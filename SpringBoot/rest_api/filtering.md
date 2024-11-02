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