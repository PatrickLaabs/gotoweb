# Webserver in Go with Docker

`docker pull ghcr.io/patricklaabs/gotoweb:latest && docker run -e PORT=8080 -p 8080:8080 ghcr.io/patricklaabs/gotoweb:latest`

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

---

### Rollout new Versions of code to k8s

Desired state in the future: make it run auto

After changes are made to the code, push them to the repo and add a tag after and also 
push the tag.
The new build will be triggered by gh actions.

Run the following: \
`kubectl set image deployment/gotoweb gotoweb=ghcr.io/patricklaabs/gotoweb:0.0.6`

Check the rollout status by running: \
`kubectl rollout status deployment/gotoweb`

The new Release should be now up and running. 

---

### Roll back to previous version

For rolling back to the previous deployment just run: \
`kubectl rollout undo deployment/gotoweb`

---

### Roll back to specific revision

To check the List of available, run: \
`kubectl rollout history deployment`

Roll back to desired revision: \
`kubectl rollout undo deployment/gotoweb --to-revision=<rev-nr>`