# Distributed Tracing

Is a method used to monitor and track requests as they flow through a system of distributed services, 
through the generation of unique trace IDs for each request it passed through all the services involved in processing that request.

Micrometer -> OpenTelemetry -> Zipkin

### Dependencies
```xml
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-observation</artifactId>
</dependency>

<!--Open Telemetry as Bridge-->
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-otel</artifactId>
</dependency>

<!--Zipkin-->
<dependency>
<groupId>io.opentelemetry</groupId>
<artifactId>opentelemetry-exporter-zipkin</artifactId>
</dependency>
```

### Properties
For every microservice :
```properties
management.tracing.sampling.probability=1.0
logging.pattern.level=%5p [${spring.application.name:},%X{traceId:-},%X{spanId:-}]
```

### Logging
```java
private Logger log = LoggerFactory.getLogger(GenericClass.class);
log.info("Message");
```

## Zipkin
- Zipkin is a distributed tracing system. It helps gather timing data needed to troubleshoot latency problems in microservice architectures.

### Run Zipkin with Docker
```bash
docker run -d -p 9411:9411 openzipkin/zipkin
```

- Open `http://localhost:9411/zipkin/` in your browser to access the Zipkin dashboard.

## Trace ID between Microservices
- ### **Feign**

### Dependencies
```xml
<dependency>
    <groupId>io.github.openfeign</groupId>
    <artifactId>feign-micrometer</artifactId>
</dependency>
```

- ### **RestTemplate**

### Configuration
```java
@Configuration(proxyBeanMethods = false)
public class RestTemplateConfig {
    @Bean
    public RestTemplateBuilder restTemplateBuilder() {
        return new RestTemplateBuilder();
    }
}
```

### Controller
```java
@Autowired
private RestTemplate restTemplate;

@GetMapping("/call")
public String callService() {
    return restTemplate.getForObject("http://localhost:8081/service", String.class);
}
```