# Feign

It is used to make HTTP requests to other services in a declarative way.

It can be used also as a client side load balancer when is defined @FeignClient(name = "user-service") without a URL.

### Dependency
```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

### Enable Feign
```java
@SpringBootApplication
@EnableFeignClients
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

### Create a proxy interface
```java
@FeignClient(name = "user-service")
public interface UserProxy {

    @GetMapping("/users/{id}")
    User getUserById(@PathVariable("id") Long id);
}
```

### On Service class
```java
@Service
public class ProductService {

    @Autowired
    private ProductClient productClient;

    public List<Product> getAllProducts() {
        return productClient.getProducts();
    }
}

```
