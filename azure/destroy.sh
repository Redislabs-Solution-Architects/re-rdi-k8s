#!/bin/bash
az aks delete \
    --name $USER-redis-cluster \
    --resource-group $USER-redis-cluster-ResourceGroup \
    --yes \

az group delete \
    --name $USER-redis-cluster-ResourceGroup \
    --yes \