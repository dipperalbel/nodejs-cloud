#!/bin/bash

cd nodejs-deployment

kubectl create -f db-secret.yaml

kubectl create -f nodejs-env-configmap.yaml

kubectl create -f nodejs-deployment.yaml

kubectl create -f nodejs-service.yaml

kubectl create -f nodejs-ingress.yaml
