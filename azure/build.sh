#!/bin/bash
az group create \
    --name $USER-redis-cluster-ResourceGroup \
    --location westus

az aks create \
    --resource-group $USER-redis-cluster-ResourceGroup \
    --name $USER-redis-cluster \
    --node-count 3 \
    --node-vm-size Standard_DS3_v2 \
    --generate-ssh-keys

az aks get-credentials \
    --resource-group $USER-redis-cluster-ResourceGroup \
    --name $USER-redis-cluster \
    
