#!/bin/bash

# set path
logPath=$1

# set target IP
kubectl get svc | grep nginx-thrift |  awk '/[[:space:]]/ {print $4}' > target_url.txt

# num of threads
t=5

# request per second
rps=10

# test duration (20m)
duration=1200

# ratio #data set 뽑을 때는 랜덤으로
ratio=()
ratio_raw=()
while true; do
    # 1부터 3, 5 사이의 랜덤 숫자 2개 생성
    num1=$((RANDOM % 3 + 1))
    num2=$((RANDOM % 5 + 1))

    # 세 번째 숫자 계산
    num3=$((10 - num1 - num2))

    # 세 번째 숫자가 1과 9 사이인지 확인
    if [[ num3 -ge 1 && num3 -le 9 ]]; then
        numbers=()
        numbers+=($num1)
        numbers+=($num2)
        numbers+=($num3)
        ratio_raw=$(printf "%s\n" "${numbers[@]}" | shuf)
        break
    fi
done
for r in ${ratio_raw[@]} 
do
    ratio+=($r)
done

# compose user home
# ratio=( 1 3 6 )

# 증가 속도 느림 - 50 70 100 이거 세개로 샘플링하면 될듯
connections=( 20 50 70 100)
# 증가 속도 빠름
# connections=( 50 500 1000 )

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
echo [Result] $timestamp >> $logPath/output.log
echo [Ratio] ${ratio[0]} ${ratio[1]} ${ratio[2]} >> $logPath/output.log
echo Current Pod Status >> $logPath/output.log
kubectl get pod >> $logPath/output.log

# tc count
i=0
for conn in ${connections[@]}
do
    ((i=i+1))
    users=$((${conn}))
    echo Test ${i}
    echo " " >> $logPath/output.log

    conn_compose=$((${conn} * ${ratio[0]}))
    conn_user=$((${conn} * ${ratio[1]}))
    conn_home=$((${conn} * ${ratio[2]}))
    echo Requests of Compose: $((${conn_compose})) # wrk send 5 requests per sec
    echo Requests of User: $((${conn_user}))
    echo Requests of Home: $((${conn_home}))

    timestamp=`date`
    echo [Test ${i}] $timestamp >> $logPath/output.log
    
    # # user
    # wrk -t ${t} -c $conn_user -d $duration -s ./../wrk2/scripts/social-network/read-user-timeline.lua $user_url --latency -H 'Connection: close' >> $logPath/output.log & 
    # # home
    # wrk -t ${t} -c $conn_home -d $duration -s ./../wrk2/scripts/social-network/read-home-timeline.lua $home_url --latency -H 'Connection: close' >> $logPath/output.log &
    # # compose
    # wrk -t ${t} -c $conn_compose -d $duration -s ./../wrk2/scripts/social-network/compose-post.lua $compose_url --latency -H 'Connection: close' >> $logPath/output.log
    
    # Ubuntu
    # user
    ../../wrk2/wrk -D fixed -t ${t} -T 2 -c $conn_user -d $duration -R ${conn_user} -s ./../wrk2/scripts/social-network/read-user-timeline.lua $user_url --latency -H 'Connection: close' >> $logPath/output.log & 
    # home
    ../../wrk2/wrk -D fixed -t ${t} -T 2 -c $conn_home -d $duration -R ${conn_user} -s ./../wrk2/scripts/social-network/read-home-timeline.lua $home_url --latency -H 'Connection: close' >> $logPath/output.log  &
    # compose
    ../../wrk2/wrk -D fixed -t ${t} -T 2 -c $conn_compose -d $duration -R ${conn_user} -s ./../wrk2/scripts/social-network/compose-post.lua $compose_url --latency -H 'Connection: close' >> $logPath/output.log

    
    kubectl top pod >> $logPath/output.log
    kubectl get horizontalpodautoscalers.autoscaling >> $logPath/output.log
    kubectl get pod >> $logPath/output.log

done

timestamp=`date`
echo Test End $timestamp >> $logPath/output.log
echo ====== Social Benchmark Done ======