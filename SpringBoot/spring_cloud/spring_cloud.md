# Spring Cloud

## Spring Cloud Stream

**Definition**: SCS provides a streaming abstraction over messaging, based on the publish and subscribe integration
pattern. SCS comes with built-in support for Apache Kafka and RabbitMQ.

### Core concepts

- **Message**: A data structure that's used to describe data sent to and received from a messaging system.
- **Publisher (Supplier)**: Sends messages to the messaging system.
- **Subscriber (Consumer)**: Receives messages from the messaging system.
- **Destination**: Used to communicate with the messaging system.
    - Publishers use output destinations, and Subscribers use input destinations.
    - Destinations are mapped by specific binders to queues and topics in the underlying messaging system.
- **Binder**: Provides the actual integration with a specific messaging system (similar to JDBC with a specific
  database).

## System Messaging Implementation

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