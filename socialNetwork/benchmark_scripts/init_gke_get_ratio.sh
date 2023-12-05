#!/bin/bash

echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/
echo "Wait for 10 minutes for initialization"
sleep 600

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
./run_social_benchmark2.sh $logPath

kill -9 $log
echo ====== Done ======


echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/
echo "Wait for 10 minutes for initialization"
sleep 600

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

kubectl delete horizontalpodautoscalers.autoscaling nginx-thrift
sleep 10
kubectl scale --replicas 20 deployment nginx-thrift
sleep 120
echo 3. Run Benchmark
./run_social_benchmark2.sh $logPath

kill -9 $log
echo ====== Done ======


echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
# sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/
echo "Wait for 10 minutes for initialization"
sleep 600

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!


kubectl delete horizontalpodautoscalers.autoscaling compose-post-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling text-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mention-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-service --now=true --wait=true
sleep 120



kubectl scale --replicas 2 deployment home-timeline-service
kubectl scale --replicas 12 deployment post-storage-service 
kubectl scale --replicas 3 deployment text-service 
kubectl scale --replicas 8 deployment user-timeline-service
kubectl scale --replicas 3 deployment compose-post-service
kubectl scale --replicas 3 deployment user-service
kubectl scale --replicas 3 deployment user-mention-service
sleep 120

echo 3. Run Benchmark
./run_social_benchmark2.sh $logPath

kill -9 $log
echo ====== Done ======



