#!/bin/sh

# num of threads
t=10

# test duration (7m)
d=420

# array_c=( 50 100 200 300 400 500 )
array_c=( 25 50 100 150 200 250 )
# array_c=( 4 20 40 60 80 )
# array_c=( 20 1000 )
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
    echo " " >> home.txt
    
    timestamp=`date`
    echo [Test ${i}] $timestamp >> home.txt
    wrk -t ${t} -c ${c} -d ${d} -s ./wrk2/scripts/social-network/read-home-timeline.lua $home --latency -H 'Connection: close' >> home.txt
    
done

timestamp=`date`
echo Test End $timestamp >> home.txt
echo ====== Social Benchmark Done ======