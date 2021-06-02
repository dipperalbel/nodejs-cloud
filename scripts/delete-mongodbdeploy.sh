#!/bin/bash

kubectl delete secret config-secret

helm delete mongodb

kubectl get pvc | grep pv | awk '{print $1}' | xargs kubectl delete pvc
