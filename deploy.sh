docker build  -t rajuas400/multi-client:latest -t rajuas400/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build  -t rajuas400/multi-server:latest -t rajuas400/multi-server:$SHA -f ./server/Dockerfile ./server  
docker build  -t rajuas400/multi-worker:latest -t rajuas400/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push rajuas400/multi-client:latest
docker push rajuas400/multi-server:latest
docker push rajuas400/multi-worker:latest

docker push rajuas400/multi-client:$SHA
docker push rajuas400/multi-server:$SHA
docker push rajuas400/multi-worker:$SHA

kubectl apply -f simplek8 
kubectl set image deployments/server-deployment server=rajuas400/multi-server:$SHA
kubectl set image deployments/client-deployment client=rajuas400/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rajuas400/multi-worker:$SHA








