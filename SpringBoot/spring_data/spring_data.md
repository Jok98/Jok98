# Spring Data

In Spring Data, an entity represents a database table, and a repository provides an abstraction to perform CRUD
operations on the entity. Spring Data JPA automates the creation of the repository based on the interfaces you define.

## Configuration

```yaml
spring.datasource.url= jdbc:mysql//localhost:3306/db_name
spring.datasource.username= username
spring.datasource.password= password
```

## Entity

The class is annotated with @Entity and the fields with annotations like @Id and @GeneratedValue to define the primary
key and its auto-generation strategy.

### JPA

```java

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;

    // Default constructor required by JPA
    public User() {
    }
}
```

### Mongo

```java

@Document(collection = "users")  // Specifies the MongoDB collection name
public class User {

    @Id
    private String id;  // MongoDB will automatically generate the `_id` field
    private String name;
    private String email;

    // Default constructor required by Spring Data
    public User() {
    }
}
```

| **Name**                  | **Description**                                                                    |
|---------------------------|------------------------------------------------------------------------------------|
| `GenerationType.AUTO`     | Pick an appropriate strategy for the particular database                           |
| `GenerationType.IDENTITY` | Assign primary keys using database identity column                                 |
| `GenerationType.SEQUENCE` | Assign primary keys using a database sequence                                      |
| `GenerationType.TABLE`    | Assign primary keys using an underlying database table to ensure uniqueness        |
| `GenerationType.UUID`     | Assign primary keys using a globally unique identifier (UUID) to ensure uniqueness |

## Repository

The repository interface provides methods to interact with the database (CRUD ops). Extending JpaRepository (or
CrudRepository) gives these functionalities automatically.

```java

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // You can define custom query methods here
    @Query("SELECT u FROM User u WHERE u.email = ?1")
    User findByEmail(String email);

}
```

### Reactive Repository

Based on non-blocking I/O, this interface does not return objects or collections of objects; instead, it returns Mono
and Flux objects, which are reactive streams capable of returning either 0...1 or 0...m entities as they become
available on the stream. (Supported by Mongo, not supported by JPA)

```java

@Repository
public interface UserRepository extends ReactiveCrudRepository<User, Long> {

    // You can define custom query methods here
    Flux<User> findByEmail(String email);
}
```

## Service

A service layer is a common way to encapsulate business logic and handle repository interactions.

```java

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
}
```