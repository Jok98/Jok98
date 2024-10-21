# Kubectl

| Kubectl Command                             | Description                                         |
|---------------------------------------------|-----------------------------------------------------|
| `kubectl get pods`                          | Lists all pods in the current namespace.            |
| `kubectl describe pod <pod-name>`           | Displays detailed information about a specific pod. |
| `kubectl logs <pod-name>`                   | Retrieves the logs for a specific pod.              |
| `kubectl exec -it <pod-name> -- /bin/bash`  | Opens a bash shell inside a running pod.            |
| `kubectl apply -f <file.yaml>`              | Applies a configuration change from a YAML file.    |
| `kubectl delete pod <pod-name>`             | Deletes a specific pod.                             |
| `kubectl get services`                      | Lists all services in the current namespace.        |
| `kubectl get nodes`                         | Lists all nodes in the cluster.                     |
| `kubectl get namespaces`                    | Lists all namespaces in the cluster.                |
| `kubectl create namespace <namespace-name>` | Creates a new namespace.                            |

## Contexts
Is a combination of :
- Cluster
- Auth Info
- Namespace

Is usually stored in `~/.kube/config` file.

To get the context:
```shell
kubectl config get-contexts
```

To set the context:
```shell
kubectl config use-context <context-name>
```

To set the namespace:
```shell
kubectl config set-context --current --namespace=<namespace-name>
```

