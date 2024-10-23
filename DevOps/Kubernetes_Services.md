# Kubernetes Services
### Replacing Netflix Eureka
Kubernetes has a built-in discovery service based on kubernetes services and the kube-proxy run time component.<br>
Kubernetes discovery service doesn't require a client library so it make it independent to the programming language.<br>

## How Kubernetes will be used
- For each microservice, database, and queue manager that will be deployed in kube
    -> one `deployment object` and one `service object` will be created.
    -> For all the components (except for the `edge server` named gateway) the service type will be `ClusterIP`
    -> For the `edge server` the service type will be `NodePort` accepting external https requests.
- The config server will use  a `configMap` containing the configuration files.
- To hold credentials for the config server and its clients will be created a `secret object` for each.