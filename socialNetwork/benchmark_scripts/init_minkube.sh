#!/bin/sh

echo ====== Start ======
sudo systemctl daemon-reload
sudo systemctl restart kubelet
pkill -f "port-forward"

# ---------------------------------------- #
echo 1. Init Minikube
helm uninstall social-network
minikube delete
minikube start --nodes=2 --cpus=max

# ---------------------------------------- #
echo 2. Build wrk
cd ../wrk2
make
cd -

# ---------------------------------------- #
echo 3 . Install helm package
helm install social-network ./helm-chart/socialnetwork/
sleep 120

# ---------------------------------------- #
echo 4. Start Metrics-server
kubectl delete -n kube-system deployments.apps metrics-server
minikube addons enable metrics-server
sleep 120

image=`kubectl get deployments.apps -n kube-system metrics-server -o wide --no-headers | awk '/[[:space:]]/ {print $7}'`
echo $image
kubectl patch -n kube-system deployments.apps metrics-server -p '{"spec":{"template":{"spec":{"containers":[{"name":"metrics-server", "image": "'${image}'", "args":["--cert-dir=/tmp","--secure-port=4443","--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname","--kubelet-use-node-status-port","--metric-resolution=15s","--kubelet-insecure-tls"]}]}}}}'
sleep 10
kubectl rollout restart -n kube-system deployments.apps metrics-server
kubectl get deployments.apps -n kube-system metrics-server --template='{{range $k := .spec.template.spec.containers}}{{$k.args}}{{"\n"}}{{end}}' | grep -o 'metric-resolution=[^ ]*'

# ---------------------------------------- #
echo 5. Expose nginx-server, media-front and jaeger
# minikube service nginx-thrift
# minikube service list | grep nginx-thrift |  awk '/[[:space:]]/ {print $8}' > target_url.txt
# minikube service jaeger
# minikube service list | grep jaeger |  awk '/[[:space:]]/ {print $8}' > jaeger_url.txt
kubectl port-forward svc/nginx-thrift 8080:8080 &
kubectl port-forward svc/media-frontend 8081:8081 &
kubectl port-forward svc/jaeger 5778:5778 &
kubectl port-forward svc/jaeger 16686:16686 &
kubectl port-forward svc/jaeger 14268:14268 &
kubectl port-forward svc/jaeger 9411:9411 &
sleep 60

# ---------------------------------------- #
echo 6. Run traffic generlator
# raw_url=`cat target_url.txt`
# url=$(echo $raw_url | tr "\"" "\n")
./run_social_benchmark.sh


echo ====== Done ======