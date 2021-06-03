#!/bin/bash

kubectl apply -f kind-metrics-server.yaml

kubectl -n kube-system wait --for=condition=Ready pods --all=true --timeout=60s

kubectl wait --for=condition=available deployment/nodejs  --timeout=60s

kubectl autoscale deployment nodejs --cpu-percent=50 --min=4 --max=10

