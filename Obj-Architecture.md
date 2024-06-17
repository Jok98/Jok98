`Provider` -> `Controller` -> `Service`
## Provider Interface
### Define api's firm
```java
public interface LoginProvider extends BaseProvider {

    @POST
    @Path( "/auth/login" )
    @Consumes( MediaType.APPLICATION_JSON )
    @Produces( MediaType.APPLICATION_JSON )
    @WebMethod
    @Operation( description = "Login" )
    @ApiResponses( value = {
            @ApiResponse( responseCode = "400", description = "Input data is invalid" ) } )
    AppResponse<LoginResponse> login( final LoginRequest loginRequest, @Context final MessageContext context ) throws Exception;
```
