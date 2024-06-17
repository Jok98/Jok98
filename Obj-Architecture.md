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

## Controller
```java
@Rest
@Slf4j
public class LoginController implements LoginProvider {
private LoginService loginService;
    @Override
    public ClimeneResponse<LoginResponse> login( final LoginRequest loginRequest, final MessageContext context ){
// ...
        LoginResponse response = loginService.login( loginRequest );
        return new AppResponse<LoginResponse>().code( SUCCESS ).result( response );
    }
```

## Service Interface
```java
public interface LoginService {

    LoginResponse login( LoginRequest request )
// ...

}
```

## Service Impl
```java
@Data
@Accessors( chain = true )
public class LoginDefaultServiceImpl implements LoginService {

    @Override
    public LoginResponse login( LoginRequest request ) throws AlarmCodeException {
        // Do logic
        LoginResponse response = authenticate( request );
        return response;
    }
```

## Login Response

```java
public class LoginResponse extends HashMap<String, String> {

    private static final String USERNAME_KEY = "username";
    private static final String USERID_KEY = "userid";
    private static final String TOKEN_KEY = "token";
    private static final String REFRESH_TOKEN_KEY = "refreshToken";
    private static final String ON_BEHALF_OF_TYPE_KEY = "onBehalfOfType";
    private static final String FIRST_NAME = "firstName";
    private static final String LAST_NAME = "lastName";
    private static final String LANDING_URL = "landingUrl";

    public LoginResponse() {
    }

    public String getUsername() {
        return this.get(USERNAME_KEY);
    }

    public String getUserid() {
        return this.get(USERID_KEY);
    }

    public String getToken() {
        return this.get(TOKEN_KEY);
    }

    public String getRefreshToken() {
        return this.get(REFRESH_TOKEN_KEY);
    }

    public String getOnBehalfOfType() {
        return this.get(ON_BEHALF_OF_TYPE_KEY);
    }

    public String getFirstName() {
        return this.get(FIRST_NAME);
    }

    public String getLastName() {
        return this.get(LAST_NAME);
    }

    public String getLandingUrl() {
        return this.get(LANDING_URL);
    }


    public LoginResponse username(String value) {
        this.put(USERNAME_KEY, value);
        return this;
    }

    public LoginResponse userId(String value) {
        this.put(USERID_KEY, value);
        return this;
    }

    public LoginResponse token(String value) {
        this.put(TOKEN_KEY, value);
        return this;
    }

    public LoginResponse refreshToken(String value) {
        this.put(REFRESH_TOKEN_KEY, value);
        return this;
    }

    public LoginResponse onBehalfOfType(String value) {
        this.put(ON_BEHALF_OF_TYPE_KEY, value);
        return this;
    }

    public LoginResponse firstName(String value) {
        this.put(FIRST_NAME, value);
        return this;
    }

    public LoginResponse lastName(String value) {
        this.put(LAST_NAME, value);
        return this;
    }

    public LoginResponse landingUrl(String value) {
        this.put(LANDING_URL, value);
        return this;
    }

}

```
