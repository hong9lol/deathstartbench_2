#!/bin/sh
# pkill -f "port-forward"
# kubectl port-forward svc/nginx-thrift 8080:8080 &
# kubectl port-forward svc/media-frontend 8081:8081 &
# kubectl port-forward svc/jaeger 5778:5778 &
# kubectl port-forward svc/jaeger 16686:16686 &
# kubectl port-forward svc/jaeger 14268:14268 &
# kubectl port-forward svc/jaeger 9411:9411 &
# sleep 5

kubectl get svc | grep nginx-thrift |  awk '/[[:space:]]/ {print $4}' > target_url.txt

t=10
#array_c=( 50 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 )
array_c=( 10 20 40 60 80 100 )
array_u=( 15 30 60 90 120 150 )
array_h=( 25 50 100 150 200 250 )
d=600
ip=`cat target_url.txt`

compose="http://$ip:8080/wrk2-api/post/compose"
home="http://$ip:8080/wrk2-api/home-timeline/read"
user="http://$ip:8080/wrk2-api/user-timeline/read"

echo TEST APIs rate [6:3:1]
echo $home
echo $user
echo $composeps -
echo " "

echo ====== Social Benchmark Start ======

timestamp=`date`
echo [Result] $timestamp > output.txt
echo Current POd Status >> output.txt
kubectl get pod >> output.txt

i=0

for c in ${array_c[@]}
do
    ((i=i+1))
    users=$(($t * $c))
    echo Test ${i} with ${users} users
    echo " " >> output.txt
    
    timestamp=`date`
    echo [Test ${i}] $timestamp >> output.txt
    # if [ "$c" = "20" ]; then
    #     wrk -t ${t} -c ${c} -d 60 -s ./wrk2/scripts/social-network/compose-post.lua $compose --latency -H 'Connection: close' >> output.txt
    # else
    echo Run user
    wrk -t ${t} -c ${c} -d 360 -s ./wrk2/scripts/social-network/read-user-timeline.lua $user --latency -H 'Connection: close' >> user.txt & 
    echo Run home
    wrk -t ${t} -c ${c} -d 360 -s ./wrk2/scripts/social-network/read-home-timeline.lua $home --latency -H 'Connection: close' >> home.txt &
    echo Run Post
    wrk -t ${t} -c ${c} -d 360 -s ./wrk2/scripts/social-network/compose-post.lua $compose --latency -H 'Connection: close' >> output.txt

    # fi
    kubectl get pod >> output.txt
    kubectl top pod >> output.txt
    kubectl get horizontalpodautoscalers.autoscaling >> output.txt
    
done

timestamp=`date`
echo Test End $timestamp >> output.txt
echo ====== Social Benchmark Done ======

# watch kubectl get pod
# watch kubectl top pod
# watch kubectl get horizontalpodautoscalers.autoscaling
# wrk -t 10 -c 50000 -d 300 -s ./wrk2/scripts/social-network/mixed-workload.lua http://34.16.26.98:8080/wrk2-api/home-timeline/read http://34.16.26.98:8080/wrk2-api/user-timeline/read http://34.16.26.98:8080/wrk2-api/post/compose --latency -H 'Connection: close' >> output.txt