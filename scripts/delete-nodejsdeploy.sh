#!/bin/bash

kubectl delete deployment nodejs

kubectl delete service nodejs

kubectl delete secret mongo-secret

kubectl delete configmap nodejs-env

kubectl delete ingress nodejs
