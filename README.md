# Webserver in Go with Docker

`docker run -e PORT=8080 -p 8080:8080 ghcr.io/patricklaabs/gotoweb:latest`

## Pre-Config

### Install packages
- `brew install qemu`
- `brew install minikube`
- `brew install podman`
- `brew install kubernetes-cli`

---

>### Podman configuration (Currently not working.. use hyperkit or docker instead)
>
>`podman machine init --image-path next --cpus 2 --memory 2048 --disk-size 20` \
>`podman machine start` \
>`minikube start --driver=podman --container-runtime=cri-o`

---

### Minikube configuration

`minikube start --driver=hyperkit`

---

### Deploy to k8s

`kubectl apply -f k8s-deployment.yml`

minikube dashboard (run inside another terminal)
minikube service --url gotoweb-service
kubectl get svc
minikube tunnel
kubectl expose deployment gotoweb --type=LoadBalancer --port=8080
kubectl get svc

Access via http://<external-IP>:<Port>
