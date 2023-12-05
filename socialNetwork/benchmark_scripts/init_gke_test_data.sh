#!/bin/bash
while true
do
echo ====== Start ======
echo "Delete old objects"
kubectl delete horizontalpodautoscalers.autoscaling --all
helm uninstall social-network
echo "Wait for 4 minutes to deleting"
sleep 240


echo 1. Install helm package
helm install social-network ./../helm-chart/socialnetwork/
echo "Wait for 4 minutes for initialization"
sleep 240

basePath=./log
currentTime=`date +"%m-%d_%H%M%S"`
mkdir $basePath/$currentTime
logPath=$basePath/$currentTime

echo 2. Run Log
./log.sh $logPath & log=$!

echo 3. Run Benchmark
# if [ "$1" = "c" ]; then
#     python3 socialnetwork.py & p=$!
# fi  
./run_social_benchmark.sh $logPath

kill -9 $log
# kill -9 $p
echo ====== Done ======
done