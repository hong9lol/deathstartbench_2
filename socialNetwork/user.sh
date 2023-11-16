#!/bin/sh

t=10
# array_c=( 50 100 200 300 400 500 )
array_c=( 15 30 60 90 120 150 )
# array_c=( 20 1000 )
d=600
ip=`cat target_url.txt`

compose="http://$ip:8080/wrk2-api/post/compose"
home="http://$ip:8080/wrk2-api/home-timeline/read"
user="http://$ip:8080/wrk2-api/user-timeline/read"

i=0

for c in ${array_c[@]}
do
    ((i=i+1))
    users=$(($t * $c))
    echo Test ${i} with ${users} users
    echo " " >> user.txt
    
    timestamp=`date`
    echo [Test ${i}] $timestamp >> user.txt
    wrk -t ${t} -c ${c} -d ${d} -s ./wrk2/scripts/social-network/read-user-timeline.lua $user --latency -H 'Connection: close' >> user.txt
    
done
