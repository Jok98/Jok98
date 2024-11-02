# AOP (Aspect-Oriented Programming)
It enables to separate cross-cutting concerns (such as logging, transaction management, security, etc.) from the core business logic.<br>
This results in cleaner, more modular code, making it easier to maintain.

## Concepts

### Aspect
A modularization of a concern that cuts across multiple classes.<br>
It encapsulates behaviors that affect multiple classes into reusable modules.(`@Before` `@After`)<br>

### Join Point
A point during the execution of a program, such as a method execution or an exception being thrown.<br>

### Advice
The action taken by an `aspect` at a particular `join point`.<br>
Types of advice:
- `@Before` : Run before the method execution.
- `@After` : Run after the method execution
- `@AfterReturning` : Run after the method returns a result.
- `@AfterThrowing` : Run after the method throws an exception.

### Pointcut
A predicate that matches `join points`. <br>
`Advice` is associated with a `pointcut` expression and runs at any `join point` matched by the `pointcut`.<br>
The `execution` expression is one of the most commonly used `pointcut` expressions.<br>
```java
execution(modifiers-pattern? ret-type-pattern declaring-type-pattern? name-pattern(param-pattern) throws-pattern?)
```
You can create reusable pointcut expressions to apply the same logic to different methods.
```java
@Pointcut("execution(* com.example.service.*.*(..))")
public void serviceLayerExecution() {}

// Use this pointcut in the advice
@Before("serviceLayerExecution()")
public void logServiceMethods() {
    System.out.println("Executing a method in the service layer.");
}
```

### Weaving
The process of linking aspects with other application types or objects to create an advised object.<br>
This can happen at compile-time, load-time, or at runtime.


## Example
```java
@Aspect
@Component
public class LoggingAspect {

    // Define a pointcut expression and an advice
    @Before("execution(* com.example.service.*.*(..))")
    public void logBeforeMethod() {
        System.out.println("A method has been called in the service layer.");
    }
}
```
- `@Aspect` : Indicates that the class is an aspect.
- `@Before` : Indicates that the advice should run before the execution of the method.
- Pointcut expression : `execution(* com.example.service.*.*(..))` :
    - `*` : Matches any return type.
    - `com.example.service.*` : Matches any class in the com.example.service package.
    - `.*(..)` : Matches any method with any parameters.