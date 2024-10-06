# Resilience4j Circuit Breaker

## Purpose
- Prevents cascading failures.
- Provides fallback methods.
- Avoid overloading struggling services by cutting off repeated, unsuccessful requests.

## How it works
The Circuit Breaker pattern monitors the number of failed requests to a particular service and transitions between three main states:

**Closed** :
- In the closed state, requests are allowed to pass through as normal.

- If a request fails, the Circuit Breaker keeps track of the failure.

- If the number of failures reaches a predefined threshold, it trips to the Open state.
      
**Open**
- In the open state, requests to the faulty service are blocked automatically.
- Instead of trying to reach the failing service, the client receives an error response immediately.
- This prevents the system from overwhelming the failing service and gives it a chance to recover.
- After a certain timeout period, the Circuit Breaker will move to the Half-Open state.
- 
**Half-Open**
- In this state, the Circuit Breaker allows a limited number of requests to pass through to see if the issue has been resolved.
- If the service responds successfully, the Circuit Breaker transitions back to the Closed state.
- If the service fails again, the Circuit Breaker returns to the Open state, and the timeout is reset.

## Implementation

### Properties

```yaml
resilience4j.circuitbreaker:
  instances:
    generic:
      registerHealthIndicator: true
      slidingWindowSize: 10
      minimumNumberOfCalls: 5
      permittedNumberOfCallsInHalfOpenState: 3
      waitDurationInOpenState: 5s
      failureRateThreshold: 50
      slowCallRateThreshold: 50
      slowCallDurationThreshold: 2s
      automaticTransitionFromOpenToHalfOpenEnabled: true
      recordExceptions:
        - java.lang.RuntimeException
  
resilience4j.rateLimiter:
  instances:
    generic:
        limitForPeriod: 10
        limitRefreshPeriod: 1s

resilience4j.bulkhead:
    instances:
        generic:
        maxConcurrentCalls: 10
        maxWaitDuration: 10ms
        writableStackTraceEnabled: true
```
`circuitbreaker`
- `slidingWindowSize` : The number of calls that are recorded in the sliding window.
- `minimumNumberOfCalls` : The minimum number of calls that must be recorded in the sliding window.
- `permittedNumberOfCallsInHalfOpenState` : The number of permitted calls when the Circuit Breaker is in the Half-Open state.
- `waitDurationInOpenState` : The time that the Circuit Breaker should wait before transitioning to the Half-Open state.
- `failureRateThreshold` : The threshold for the failure rate in percentage.
- `slowCallRateThreshold` : The threshold for the slow call rate in percentage.
- `slowCallDurationThreshold` : The threshold for the slow call duration.
- `automaticTransitionFromOpenToHalfOpenEnabled` : Whether the Circuit Breaker should automatically transition to the Half-Open state.

`rateLimiter`
- `limitForPeriod` : The number of calls that are permitted in the given period.
- `limitRefreshPeriod` : The period in which the limit is refreshed.

`bulkhead`
- `maxConcurrentCalls` : The maximum number of concurrent calls that are allowed.
- `maxWaitDuration` : The maximum time that a call should wait for a permit.
- `writableStackTraceEnabled` : Whether the stack trace should be written to the logs.

### Controller
```java
@RestController
public class GenericController {

    @Autowired
    private GenericService genericService;

    @GetMapping("/generic/{id}")
    @CircleBreaker(name = "generic", fallbackMethod = "fallback")
    @RateLimiter(name = "generic")
    @Bulkhead(name = "generic")
    public ResponseEntity<GenericResponse> getGeneric(@PathVariable Long id) {
        return ResponseEntity.ok(genericService.getGeneric(id));
    }
    
    public String fallback(Exception e, Long id) {
        return "Fallback method called for id: " + id;
    }
}
```

- `@RateLimiter` is used to limit the number of requests to a service. ex: 10 requests per second.
- `fallback` is the method that will be called if the retry fails.
- `Exception e` is the exception thrown by the method, and it's required in the fallback method.
