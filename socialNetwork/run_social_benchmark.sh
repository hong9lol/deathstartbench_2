#!/bin/sh
pkill -f "port-forward"
kubectl port-forward svc/nginx-thrift 8080:8080 &
kubectl port-forward svc/media-frontend 8081:8081 &
kubectl port-forward svc/jaeger 5778:5778 &
kubectl port-forward svc/jaeger 16686:16686 &
kubectl port-forward svc/jaeger 14268:14268 &
kubectl port-forward svc/jaeger 9411:9411 &
sleep 5

echo ====== Social Benchmark Start ======
../wrk2/wrk -D exp -t 20 -c 20 -d 120 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://35.223.76.214:8080/wrk2-api/user-timeline/read -R 250 
../wrk2/wrk -D exp -t 20 -c 20 -d 120 -L -s ./wrk2/scripts/social-network/compose-post.lua http://35.223.76.214:8080/wrk2-api/post/compose -R 150

echo ====== Social Benchmark Done ======



../wrk2/wrk -D exp -t 100 -c 1000 -d 600 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://35.223.76.214:8080/wrk2-api/user-timeline/read 
../wrk2/wrk -D exp -t 100 -c 1000 -d 600 -L -s ./wrk2/scripts/social-network/read-user-timeline.lua http://35.223.76.214:8080/wrk2-api/user-timeline/read 