#!/bin/bash
AWS_ID=$(aws sts get-caller-identity --query "Account" --output text)
envsubst < $PWD/aws/config.yaml | eksctl create cluster -f -

eksctl utils associate-iam-oidc-provider \
    --region=us-west-2 \
    --cluster=$USER-redis-cluster \
    --approve

eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster $USER-redis-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

eksctl create addon \
    --name aws-ebs-csi-driver \
    --cluster $USER-redis-cluster \
    --service-account-role-arn arn:aws:iam::$AWS_ID:role/AmazonEKS_EBS_CSI_DriverRole \
    --force