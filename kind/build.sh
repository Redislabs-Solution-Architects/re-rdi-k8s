
#!/bin/bash
echo -e "\n*** Create K8S (Kind) Cluster ***"
kind create cluster --config=$PWD/kind/config.yaml --name $USER-redis-cluster

echo -e "\n*** Create Loadbalancer ***"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml; sleep 5
kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=-1s
kubectl apply -f $PWD/kind/metallb.yaml