#!/bin/bash

kind create cluster --config kind-config.yaml --name=$USER

kubectl wait --for=condition=Ready nodes --all=true --timeout=140s

kubectl create -f mandatory.yaml

kubectl create -f service-nodeport.yaml

kubectl -n ingress-nginx wait --for=condition=Ready pods --all=true --timeout=140s

kubectl patch deployments -n ingress-nginx nginx-ingress-controller -p '{"spec":{"template":{"spec":{"containers":[{"name":"nginx-ingress-controller","ports":[{"containerPort":80,"hostPort":80},{"containerPort":443,"hostPort":443}]}],"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'

kubectl -n ingress-nginx wait --for=condition=Ready pods --all=true --timeout=140s

kubectl label nodes $USER-worker tier=nodejs

kubectl label nodes $USER-worker2 tier=mongodb
