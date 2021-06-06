#!/bin/bash

# starting message
echo Starting...

# to count each try
COUNTER=1

# main loop
while :
do
 	# print the current counter
        echo $COUNTER

        # make a curl request to submit our data to the target page
        # $HOSTNAME: the name of the machine doing the requests
        # COUNTER: the number of the request
        curl -d name="$HOSTNAME" -d character="$COUNTER" http://paas-01.fcc21.fogx.me/items/additem

        # increment the counter
        let COUNTER=COUNTER+1

        #message to divide each try
        echo next...

        #makes the script wait n seconds before making another request
        sleep 20

done

