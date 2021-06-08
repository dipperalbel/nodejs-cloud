#!/bin/bash

echo "Starting..."

# username to log with
USERNAME=ubuntu
# list of hosts to log to
HOSTS="172.24.4.10 172.24.4.83 172.24.4.30"


for HOSTNAME in ${HOSTS}; do
        echo "Logging in $HOSTNAME..."
        # connect to the host with the username and the key
        ssh ubuntu@$HOSTNAME -i ./.ssh/eval_rsa -t 'sudo nohup ./web_req_script.sh -invisible & disown ; exit'

        echo "Next host..."

done
