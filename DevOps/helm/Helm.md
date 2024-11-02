# Helm

Is used in a `Kubernetes` environment to bundle and configure the microservices for `deployments`.<br>
A package is known as a `chart`.<br>
A `chart` contains `templates`, default values for the templates and optional dependencies. <br>
Each component that needs to be deployed will have its own chart describing how to deploy it.<br>
`Library charts` named `common` are used to reduce the boilerplate definitions from the component charts.<br>
A `library chart` doesn't contain any deployable definitions but only reusable templates.<br>
To deploy all components into different types of environments the concept of `parent charts` and `subcharts` will be
used.<br>
Each environment will be implemented as a parent chart that depends on different sets of subcharts.<br>
`Helm charts` can be published to a `helm chart repository`.<br>

### Helm Chart Structure
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

- **Chart.yaml** contains general information about the chart and a list of other charts it depends on.
- **templates** a folder that contains that will be used to deploy the chart.
- **values.yaml** contains the default values for the templates.
- **Chart.lock** a file created by Helm to keep track of the versions of the dependencies.
- **charts** a folder that contains the dependencies of the chart.
- **.helmignore** a file that contains the files that should be ignored by Helm.

## Commands

- **create**
- **dependency update**
- **dependency build** rebuilds the dependencies based on the Chart.lock file.
- **template** renders the chart templates locally.
- **install:** installs a chart archive.
- **install --dry-run** simulate a deployment without performing it
- **list** lists all installations in the current namespace.
- **upgrade** updates aan existing installation.
- **uninstall** removes an installation.






