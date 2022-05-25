docker build -t testecx14/localontv-app:latest -t testecx14/localontv-app:$SHA -f ./appclient/Dockerfile ./client
docker build -t testecx14/localontv-server:latest -t testecx14/localontv-server:$SHA -f ./appserver/Dockerfile ./server
docker build -t testecx14/localontv-worker:latest -t testecx14/localontv-worker:$SHA -f ./appworker/Dockerfile ./worker 
docker push testecx14/localontv-app:latest
docker push testecx14/localontv-server:latest
docker push testecx14/localontv-worker:latest

docker push testecx14/localontv-app:$SHA
docker push testecx14/localontv-server:$SHA
docker push testecx14/localontv-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/localontv-server-deployment server=testecx14/localontv-server:$SHA
kubectl set image deployments/localontv-app-deployment client=testecx14/localontv-app:$SHA
kubectl set image deployments/localontv-worker-deployment worker=testecx14/localontv-worker:$SHA

