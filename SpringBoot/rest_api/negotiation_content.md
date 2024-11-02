## Negotiation Content

- ### Return XML

The client can request the response in XML format by setting the `Accept` header to `application/xml`.
The conversion is automatic, managed by jackson library.

On pom.xml

```xml

<dependency>
    <groupId>com.fasterxml.jackson.dataformat</groupId>
    <artifactId>jackson-dataformat-xml</artifactId>
</dependency>
```

- ### Internationalization (i18n)

Create a `messages.properties` file in the same folder as `application.properties`.

```yaml
good.morning.message=Good Morning
```

For other languages, create `messages_x.properties` files (e.g., for `it`, `fr`, `de`).

```java

@Autowired
private MessageSource messageSource;

@GetMapping(path = "/hello-world-internationalized")
public String helloWorldInternationalized() {
    Locale locale = LocaleContextHolder.getLocale();
    return messageSource.getMessage("good.morning.message", null, "Default Message", locale);
}
```

Client need to set the `Accept-Language` header to the desired language.