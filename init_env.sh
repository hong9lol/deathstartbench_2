#!/bin/sh

echo ====== Start ======
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# ---------------------------------------- #
echo 1. Init Minikube
helm uninstall social-network
minikube delete
minikube start --nodes=2 --cpus=max

# ---------------------------------------- #
echo 2. Build wrk
cd ./wrk2
make
cd ..

# ---------------------------------------- #
echo 3. Install helm package
helm install social-network ./socialNetwork/helm-chart/socialnetwork/
sleep 120

# ---------------------------------------- #
echo 4. Enable nginx-server
minikube service nginx-thrift
minikube service list | grep nginx-thrift |  awk '/[[:space:]]/ {print $8}' > target_url.txt

# ---------------------------------------- #
echo 5. Start Metrics-server
kubectl delete -n kube-system deployments.apps metrics-server
minikube addons enable metrics-server


# ---------------------------------------- #
echo 6. Run traffic generlator
raw_url=`cat target_url.txt`
url=$(echo $raw_url | tr "\"" "\n")
# ... $url


# echo 2. Start Simple Application
# kubectl apply -f k8s/manifests/simple_app.yaml
# kubectl expose deployment simple-app-deployment --type=LoadBalancer --port=8080 & 

# minikube service simple-app-deployment
# minikube service list -n default -o json | jq '.[1].URLs[0]' > target_url.txt

# echo 3. Start Metrics-server
# kubectl delete -n kube-system deployments.apps metrics-server
# minikube addons enable metrics-server
# sleep 120

# image=`kubectl get deployments.apps -n kube-system metrics-server -o wide --no-headers | awk '/[[:space:]]/ {print $7}'`
# echo $image
# kubectl patch -n kube-system deployments.apps metrics-server -p '{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server", "image": "'${image}'", "args":["--cert-dir=/tmp","--secure-port=4443","--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname","--kubelet-use-node-status-port","--metric-resolution=15s","--kubelet-insecure-tls"]}]}}}}'
# sleep 10
# kubectl rollout restart -n kube-system deployments.apps metrics-server
# kubectl get deployments.apps -n kube-system metrics-server --template='{{range $k := .spec.template.spec.containers}}{{$k.args}}{{"\n"}}{{end}}' | grep -o 'metric-resolution=[^ ]*'

echo ====== Done ======
#python3 benchmark/utils/kubelet_interval_test.py