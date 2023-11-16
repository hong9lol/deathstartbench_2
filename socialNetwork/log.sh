#!/bin/sh

echo " " >> top.txt
echo " "  >> horizontalpodautoscalers.txt

while true
do

    timestamp=`date`
    echo [Time] $timestamp >> top.txt
    kubectl top pod >> top.txt

    echo [Time] $timestamp >> horizontalpodautoscalers.txt
    kubectl get horizontalpodautoscalers.autoscaling >> horizontalpodautoscalers.txt
    sleep 10
done

