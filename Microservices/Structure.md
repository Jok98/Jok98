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