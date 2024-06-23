# Microk8s
## Install Microk8s
```bash
sudo snap install microk8s --classic
```
## Add user to microk8s group
```bash
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```
## Start microk8s
```bash
microk8s start
```

## Enable microk8s addons
```bash
microk8s enable dns dashboard
```

## Access the Kubernetes dashboard
```bash
microk8s dashboard-proxy
```

## Dashboard URL
```text
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

## Get ip address of microk8s
```bash
microk8s kubectl get nodes -o wide
```

## Add dns entry for microk8s
```bash
echo "$(microk8s kubectl get nodes -o wide | grep -v NAME | awk '{print $6}') nginx.local" | sudo tee -a /etc/hosts
```
