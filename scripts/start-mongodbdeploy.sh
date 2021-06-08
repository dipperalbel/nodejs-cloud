#!/bin/bash

cd mongodb-deployment

kubectl create -f config-secret.yaml

helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade --install mongodb -f values.yaml bitnami/mongodb

kubectl rollout status statefulset/mongodb
