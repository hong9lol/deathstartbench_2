#!/bin/sh

echo ====== Start ======
echo "Delete old objects"
kubectl delete horizontalpodautoscalers.autoscaling --all
helm uninstall social-network
echo "Wait for 4 minutes to complete"
sleep 240


echo 1. Install helm package
helm install social-network ./helm-chart/socialnetwork/
echo "Wait for 4 minutes for initialization"
sleep 240

echo 2. Run Benchmark
./run_social_benchmark_new.sh

echo ====== Done ======