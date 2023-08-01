#!/bin/bash

DBS=$(kubectl -n re get redb -o jsonpath='{.items[*].metadata.name}' 2>/dev/null)
for db in $DBS
do
	kubectl delete redb $db
done

kubectl -n re delete rec mycluster
kubectl -n re delete pod rdi-cli
kubectl -n re delete pod debezium-server
kubectl delete namespace postgres

eksctl delete iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster $USER-redis-cluster 
eksctl delete cluster \
    --name $USER-redis-cluster \
    --region us-west-2 \
    --disable-nodegroup-eviction