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