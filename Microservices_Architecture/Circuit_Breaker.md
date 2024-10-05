# Circuit Breaker

A circuit breaker is a design pattern that prevents a service from making calls to a failing service, allowing it to recover and prevent cascading failures in the system.

## Resilience4j

### Properties

```yaml
resilience4j.retry:
  instances:
    generic:
      maxAttempts: 3
      waitDuration: 500ms
      enableExponentialBackoff: true
```

### Controller
    
```java
@RestController
public class GenericController {

    @Autowired
    private GenericService genericService;

    @GetMapping("/generic/{id}")
    @Retry(name = "generic", fallbackMethod = "fallback")
    public ResponseEntity<GenericResponse> getGeneric(@PathVariable Long id) {
        return ResponseEntity.ok(genericService.getGeneric(id));
    }
    
    public String fallback(Exception e, Long id) {
        return "Fallback method called for id: " + id;
    }
}
```

- `generic` is the name of the retry configuration.
- `enableExponentialBackoff` is a strategy where the wait time between retry attempts increases exponentially.
- `fallback` is the method that will be called if the retry fails.
- `Exception e` is the exception thrown by the method, and it's required in the fallback method.
