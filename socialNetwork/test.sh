#!/bin/bash


# num of threads
t=10

# test duration (7m)
d=420

# ratio with 5 test
# Set 2:3:5
array_c=( 10 20 40 60 80 100 )
array_u=( 15 30 60 90 120 150 )
array_h=( 25 50 100 150 200 250 )


# 증가 속도 느림
array_users=( 51 101 201)
# 증가 속도 빠름
# array_users_fast=( 50 500 1000)


users=$(($t * (${array_c[$c]} + ${array_u[$c]} +  ${array_h[$c]})))
echo Test ${users} users
echo ${array_c[$c]}
echo ${array_u[$c]}
echo ${array_h[$c]}


for c in ${array_users[@]}
do
    echo $c    
done


r=10

# compose user home
ratio=( 1 3 6 )

# 증가 속도 느림
connections=( 5 10 20 50 100)
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

echo [Ratio] ${ratio[0]} ${ratio[1]} ${ratio[2]}

# tc count
i=0
for conn in ${connections[@]}
do
    ((i=i+1))
    users=$((${conn}))
    echo Test ${i}    

    conn_compose=$((${conn} * ${ratio[0]}))
    conn_user=$((${conn} * ${ratio[1]}))
    conn_home=$((${conn} * ${ratio[2]}))
    echo Requests of Compose: $((${conn_compose} * ${r})) # wrk send 5 requests per sec
    echo Requests of User: $((${conn_user} * ${r}))
    echo Requests of Home: $((${conn_home} * ${r}))
done