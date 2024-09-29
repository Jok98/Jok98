# Spring Security

## How it works
When you send a request to the server, Spring Security will intercept the request and check if the user is authenticated. 

If the user is not authenticated, it will redirect the user to the login page. 

If the user is authenticated, it will allow the request to be processed.

## Basic Authentication
On pom.xml
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```
From console logs, you can see that Spring Security is enabled by default with a default user and password.

You can use this default user and password to login to the application.

To set your own user and password, you can add the following properties in application.properties file.
```properties
spring.security.user.name=user
spring.security.user.password=password
```

### Filter Chain
Spring Security uses a filter chain to intercept the request.
1) All request should be authenticated.
2) If the request is not authenticated, it will redirect the user to the login page.
3) CSRF (Cross-Site Request Forgery) token is added to the request to prevent CSRF attacks.

### Custom Filter Chain
New class
```java
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//      All request should be authenticated
        http.authorizeRequests(auth ->
                auth.anyRequest().authenticated()
        );
//      If the request is not authenticated, it will redirect the user to the login page
        http.httpBasic(withDefaults());
        return http.build();
    }
}
```