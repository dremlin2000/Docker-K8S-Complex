docker build -t dyadkababka/multi-client:latest -t dyadkababka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dyadkababka/multi-server:latest -t dyadkababka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dyadkababka/multi-worker:latest -t dyadkababka/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dyadkababka/multi-client:latest
docker push dyadkababka/multi-client:$SHA
docker push dyadkababka/multi-server:latest
docker push dyadkababka/multi-server:$SHA
docker push dyadkababka/multi-worker:latest
docker push dyadkababka/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dyadkababka/multi-server:$SHA
kubectl set image deployments/client-deployment client=dyadkababka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dyadkababka/multi-worker:$SHA