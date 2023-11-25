# Open API Specification (SWAGGER)
### Create Entitys and the structure of the APIs specified in the .yml file
### To in sert into \resources\openapi
#### Configuration
```yml
openapi: 3.0.0
info:
  title: SWAGGER Example
  version: 1.0.0
```
#### Define the APIs
```yml
paths:
  /widgets:
    get:
      operationId: Identify id name
      summary: API functionality
      parameters: # request input parameter
        - name: parameter name
          in: query
          description: parameter description
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                $ref : '#/components/schemas/{entity name}'
        '404':
          description: Not found
```
#### Define the Entities
```yml
components:
  schemas:
    Entity:
      type: object
      discriminator:
        propertyName: id
      properties:
        id:
          type: integer
        descrizione:
          type: string
```

# Controller
### Implements the API structure and @Override its response returning the execution of the Command of the Entity

```java
@RestController
public class EntityController implements WidgetsApi {

    @Override
    public ResponseEntity<EntityResponse> getEntity(@NotNull @Valid String parameter) {
        EntityCommand getEntityCommand = beanFactory.getBean(EntityCommand.class,parameter);
        return ResponseEntity.ok(getEntityCommand.execute());    }
}
```
# Command
```java
@Component
@Scope(SCOPE_PROTOTYPE) //specify that a bean should be created as a new object each time it is requested from the Spring container
public class EntityCommand extends BaseCommand<EntityResponse> {

    private final String parameter;

    @Autowired
    private EntityService entityService;

    @Autowired
    private EntityMapper entityMapper;

    public EntityCommand(String parameter) {
        this.parameter = parameter;
    }
    
    @Override
    protected EntityResponse doExecute(){
        EntityResponse entityResponse = new EntityResponse();
        JpaEntity jpaEntity = entityService.getEntity();
        entityMapper.jpaEntityToEntity(entity);
        entityResponse.setEntity(entity);

        return entityResponse;
    }

}
```
# Mapper
```java
@Component
public class EntityMapper {

    public Entity jpaEntityToEntity(JpaEntity jpaEntity) {
        Entity entity = new Entity();
        // set manually all the fields
        entity.setId(jpaEntity.getId());
        // etc...

        return entity;
    }
}
```
# Service
```java
@Service
public class WidgetService extends CustomBaseService{

    @Autowired
    EntityRepository entityRepository;
    
    public JpaEntity getEntity(){
        JpaEntity jpaEntity = entityRepository.find();

        return jpaEntity;
    }
}
```
# Repository
```java
public interface EntityRepository extends JpaRepository<JpaEntity, int> {

}
```
# Pom
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.5</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.projectalt96</groupId>
    <artifactId>Expenses</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>Expenses</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.openapitools</groupId>
            <artifactId>jackson-databind-nullable</artifactId>
            <version>0.2.4</version>
        </dependency>

        <dependency>
            <groupId>io.swagger</groupId>
            <artifactId>swagger-annotations</artifactId>
            <version>1.6.8</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.springdoc/springdoc-openapi-starter-webmvc-ui -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>2.2.0</version>
        </dependency>


        <!-- https://mvnrepository.com/artifact/javax.validation/validation-api -->
        <dependency>
            <groupId>javax.validation</groupId>
            <artifactId>validation-api</artifactId>
            <version>2.0.1.Final</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/javax.annotation/javax.annotation-api -->
        <dependency>
            <groupId>javax.annotation</groupId>
            <artifactId>javax.annotation-api</artifactId>
            <version>1.3.2</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <image>
                        <builder>paketobuildpacks/builder-jammy-base:latest</builder>
                    </image>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.openapitools</groupId>
                <artifactId>openapi-generator-maven-plugin</artifactId>
                <version>5.4.0</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>generate</goal>
                        </goals>
                        <configuration>
                            <inputSpec>
                                ${project.basedir}/src/main/resources/swagger/Expense.yml
                            </inputSpec>
                            <generatorName>spring</generatorName>
                            <apiPackage>com.openapi.gen.springboot.api</apiPackage>
                            <modelPackage>com.openapi.gen.springboot.dto</modelPackage>
                            <supportingFilesToGenerate>
                                ApiUtil.java
                            </supportingFilesToGenerate>
                            <configOptions>
                                <delegatePattern>true</delegatePattern>
                                <serializableModel>true</serializableModel>
                            </configOptions>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

</project>

```
## IMPORTANT
### The generated files must be moved to the same package of SpringBoot Application
```xml
                            <apiPackage>com.openapi.gen.springboot.api</apiPackage>
                            <modelPackage>com.openapi.gen.springboot.dto</modelPackage>
```