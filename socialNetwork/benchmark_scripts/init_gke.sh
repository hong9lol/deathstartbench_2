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
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
if [ "$1" = "c" ]; then
    python3 socialnetwork.py & p=$!
fi  
./run_social_benchmark.sh $logPath

kill -9 $log
kill -9 $p
echo ====== Done ======



echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/
kubectl delete horizontalpodautoscalers.autoscaling compose-post-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-frontend       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-memcached      --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-mongodb        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-service        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-redis   --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling text-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling unique-id-service    --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-mongodb  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-service  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-memcached       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mention-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mongodb         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-service --now=true --wait=true
echo "Wait for 10 minutes for initialization"
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
python3 socialnetwork.py & p=$!
./run_social_benchmark.sh $logPath

kill -9 $log
kill -9 $p
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
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
if [ "$1" = "c" ]; then
    python3 socialnetwork.py & p=$!
fi  
./run_social_benchmark2.sh $logPath

kill -9 $log
kill -9 $p
echo ====== Done ======



echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/

kubectl delete horizontalpodautoscalers.autoscaling compose-post-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-frontend       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-memcached      --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-mongodb        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-service        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-redis   --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling text-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling unique-id-service    --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-mongodb  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-service  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-memcached       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mention-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mongodb         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-service --now=true --wait=true
echo "Wait for 10 minutes for initialization"
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
python3 socialnetwork.py & p=$!
./run_social_benchmark2.sh $logPath

kill -9 $log
kill -9 $p
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
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
if [ "$1" = "c" ]; then
    python3 socialnetwork.py & p=$!
fi  
./run_social_benchmark3.sh $logPath

kill -9 $log
kill -9 $p
echo ====== Done ======



echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/

kubectl delete horizontalpodautoscalers.autoscaling compose-post-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-frontend       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-memcached      --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-mongodb        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-service        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-redis   --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling text-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling unique-id-service    --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-mongodb  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-service  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-memcached       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mention-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mongodb         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-service --now=true --wait=true
echo "Wait for 10 minutes for initialization"
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
python3 socialnetwork.py & p=$!
./run_social_benchmark3.sh $logPath

kill -9 $log
kill -9 $p
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
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
if [ "$1" = "c" ]; then
    python3 socialnetwork.py & p=$!
fi  
./run_social_benchmark4.sh $logPath

kill -9 $log
kill -9 $p
echo ====== Done ======



echo ====== Start ======
echo "Delete old objects"
echo "Wait for 10 minutes to scale in"
sleep 900
kubectl delete horizontalpodautoscalers.autoscaling --all=true --now=true --wait=true
helm uninstall social-network --wait


echo 1. Install helm package
helm install social-network --wait ./../helm-chart/socialnetwork/

kubectl delete horizontalpodautoscalers.autoscaling compose-post-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling home-timeline-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-frontend       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-memcached      --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-mongodb        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling media-service        --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling post-storage-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-redis   --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling social-graph-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling text-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling unique-id-service    --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-memcached --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-mongodb  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling url-shorten-service  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-memcached       --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mention-service --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-mongodb         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-service         --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-mongodb --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-redis  --now=true --wait=true
kubectl delete horizontalpodautoscalers.autoscaling user-timeline-service --now=true --wait=true
echo "Wait for 10 minutes for initialization"
sleep 900

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
python3 socialnetwork.py & p=$!
./run_social_benchmark4.sh $logPath

kill -9 $log
kill -9 $p
echo ====== Done ======

