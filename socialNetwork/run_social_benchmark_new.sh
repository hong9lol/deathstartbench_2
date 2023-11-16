#!/bin/sh

# ser target IP
kubectl get svc | grep nginx-thrift |  awk '/[[:space:]]/ {print $4}' > target_url.txt

# num of threads
t=10

# test duration (7m)
duration=420

# ratio
ratio=( 2 3 5)
# 증가 속도 느림
# connections=( 50 100 200)
# 증가 속도 빠름
connections=( 50 500 1000)

ip=`cat target_url.txt`

compose_url="http://$ip:8080/wrk2-api/post/compose"
home_url="http://$ip:8080/wrk2-api/home-timeline/read"
user_url="http://$ip:8080/wrk2-api/user-timeline/read"

echo TEST APIs 
echo $home_url
echo $user_url
echo $compose_url
echo " "

echo ====== Social Benchmark Start ======

timestamp=`date`
echo [Result] $timestamp > output.txt
echo Current POd Status >> output.txt
kubectl get pod >> output.txt

# tc count
i=0
for conn in ${connections[@]}
do
    ((i=i+1))
    users=$((${t} * ${conn}))
    echo Test ${i} with ${users} users
    echo " " >> output.txt

    conn_compose=$((${conn} / 10 * ${ratio[0]}))
    conn_user=$((${conn} / 10 * ${ratio[1]} ))
    conn_home=$((${conn} / 10 * ${ratio[2]}))
    echo Requests of Compose: $((${conn_compose} * ${t} * 5))
    echo Requests of User: $((${conn_user} * ${t} * 5))
    echo Requests of Home: $((${conn_home} * ${t} * 5))

    timestamp=`date`
    echo [Test ${i}] $timestamp >> output.txt
    echo Run Test
    # user
    wrk -t ${t} -c $conn_user -d $duration -s ./wrk2/scripts/social-network/read-user-timeline.lua $user_url --latency -H 'Connection: close' >> output.txt & 
    # home
    wrk -t ${t} -c $conn_home -d $duration -s ./wrk2/scripts/social-network/read-home-timeline.lua $home_url --latency -H 'Connection: close' >> output.txt &
    # compose
    wrk -t ${t} -c $conn_compose -d $duration -s ./wrk2/scripts/social-network/compose-post.lua $compose_url --latency -H 'Connection: close' >> output.txt

    kubectl get pod >> output.txt
    kubectl top pod >> output.txt
    kubectl get horizontalpodautoscalers.autoscaling >> output.txt
    
done

timestamp=`date`
echo Test End $timestamp >> output.txt
echo ====== Social Benchmark Done ======