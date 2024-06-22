# Spring Security

### Add Dependency
```xml
<dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
</dependencies>
```
### Create a Controller
```java
@RestController @RequestMapping("hello")
public class HelloRestController {

    @GetMapping("user")
    public String helloUser() {
        return "Hello User";
    }

    @GetMapping("admin")
    public String helloAdmin() {
        return "Hello Admin";
    }

}
```
### With this configuration, all the endpoints are secured by default and require authentication wich id is `user` and password is generated in the console.

### To set a custom user and password, we can add the following configuration in the `application.properties` file.
```properties
spring.security.user.name=admin
spring.security.user.password=admin
```
### To try the endpoints
```text
http://localhost:8080/hello/user
http://localhost:8080/hello/admin
```
### Spring Security will redirect the request to the login page
```text
http://localhost:8080/login
```

### To logout
```text
http://localhost:8080/logout
```