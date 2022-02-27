# Webserver in Go with Docker

`docker pull ghcr.io/patricklaabs/gotoweb:latest && docker run -e PORT=8080 -p 8080:8080 ghcr.io/patricklaabs/gotoweb:latest`

## Pre-Config

### Install packages
- `brew install qemu`
- `brew install minikube`
- `brew install podman`
- `brew install kubernetes-cli`
- `brew install helm`

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

`minikube dashboard` \
`minikube tunnel` > This one is mandatory, since we need to tunnel the connection from minikube

> Following command is currently no longer needed \
> because we're initializing the
> loadbalancer inside the deployment yaml. \
> ~~kubectl expose deployment gotoweb --type=LoadBalancer --port=8080~~

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

---

### Automatic Deployment Updates
https://keel.sh/docs/#deploying-with-kubectl

Install _Keel_ with helm inside cluster.

Add Keel repo and update helm's repo list by running: \
`helm repo add keel https://charts.keel.sh ` \
`helm repo update`

`helm upgrade --install keel --namespace=kube-system keel/keel`

Verify installation of Keel, run: \
`kubectl --namespace=kube-system get pods -l "app=keel"`

> #### Enable Admin Dashboard of Keel
> `kubectl apply -f https://sunstone.dev/keel?namespace=default&username=admin&password=admin&relay_key=TOKEN_KEY&relay_secret=TOKEN_SECRET&relay_tunnel=TUNNEL_NAME&tag=latest`