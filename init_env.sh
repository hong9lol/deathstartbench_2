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
echo 3k . Install helm package
helm install social-network ./socialNetwork/helm-chart/socialnetwork/
sleep 120

# ---------------------------------------- #
echo 4. Start Metrics-server
kubectl delete -n kube-system deployments.apps metrics-server
minikube addons enable metrics-server
sleep 120

# ---------------------------------------- #
echo 5. Expose nginx-server, media-front and jaeger
# minikube service nginx-thrift
# minikube service list | grep nginx-thrift |  awk '/[[:space:]]/ {print $8}' > target_url.txt
# minikube service jaeger
# minikube service list | grep jaeger |  awk '/[[:space:]]/ {print $8}' > jaeger_url.txt
kubectl port-forward svc/nginx-thrift 8080:8080 &
kubectl port-forward svc/media-frontend 8081:8081 &
kubectl port-forward svc/jaeger 5775:5775 &
kubectl port-forward svc/jaeger 6831:6831 &
kubectl port-forward svc/jaeger 6832:6832 &
kubectl port-forward svc/jaeger 5778:5778 &
kubectl port-forward svc/jaeger 16686:16686 &
kubectl port-forward svc/jaeger 14268:14268 &
kubectl port-forward svc/jaeger 9411:9411 &

# ---------------------------------------- #
echo 6. Run traffic generlator
raw_url=`cat target_url.txt`
url=$(echo $raw_url | tr "\"" "\n")
# ... $url


echo ====== Done ======