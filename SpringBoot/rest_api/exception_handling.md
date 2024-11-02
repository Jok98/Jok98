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