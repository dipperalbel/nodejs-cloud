#!/bin/bash

./scripts/start-cluster.sh

./scripts/start-mongodbdeploy.sh

./scripts/start-nodejsdeploy.sh

./scripts/hpa-nodejs.sh


