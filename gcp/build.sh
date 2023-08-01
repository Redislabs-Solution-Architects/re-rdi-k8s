#!/bin/bash
gcloud container clusters create $USER-redis-cluster --num-nodes 3 --machine-type e2-standard-4
