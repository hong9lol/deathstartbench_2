#!/bin/sh

echo "\n[Log Top and HPA]\n"
logPath=$1
# basePath=./>> $logPath/output.log/log
# mkdir $basePath/$1
# currentPath=$basePath/$1

getPod=getPod.log
top=top.log
hpa=horizontalpodautoscalers.log

echo " " >> $logPath/$top
echo " "  >> $logPath/$hpa

i=0
while true
do
    ((i=i+1))
    timestamp=`date`
    
    echo [\#$i Time] $timestamp >> $logPath/$getPod
    kubectl get pod >> $logPath/$getPod

    echo [\#$i Time] $timestamp >> $logPath/$top
    kubectl top pod >> $logPath/$top

    echo [\#$i Time] $timestamp >> $logPath/$hpa
    kubectl get horizontalpodautoscalers.autoscaling >> $logPath/$hpa

    sleep 10
    if [ $i -eq 91 ]; then
        break
    fi
done

