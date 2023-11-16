#!/bin/sh


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