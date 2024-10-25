# Helm
Is used in a `Kubernetes` environment to bundle and configure the microservices for `deployments`.<br>
A package is known as a `chart`.<br>
A `chart` contains `templates`, default values for the templates and optional dependencies. <br>
Each component that needs to be deployed will have its own chart describing how to deploy it.<br>
`Library charts` named `common` are used to reduce the boilerplate definitions from the component charts.<br>
A `library chart` doesn't contain any deployable definitions but only reusable templates.<br>
To deploy all components into different types of environments the concept of `parent charts` and `subcharts` will be used.<br>
Each environment will be implemented as a parent chart that depends on different sets of subcharts.<br>
```tree
|-- common
|   |-- Chart.yaml
|   |-- templates
|   `-- values.yaml
|-- components
|   |-- auth-server
|   |-- config-server
|   |-- gateway
|   |-- mongodb
|   |-- mysql
|   |-- product
|   |-- rabbitmq
|   `-- zipkin-server
|-- environments
|   |-- dev-env
|   `-- prod-env
```
`Helm charts` can be published to a `helm chart repository`.<br>




