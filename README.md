# Fog & Cloud Computing Project: A stateless + stateful web application

Project for the Fog and Cloud COmputing course, 2020/2021.

### IaaS: Open Stack

We used Open Stack to simulate the traffic coming to the website. To do this, we create a set of machines, running Ubuntu minimal server, in their own private network connected to the Open Stack public network. Each of these machines has a private IP from their private network and a floating IP to make them reacheable from the outside.

In each of this machines, we uploaded a shell script that let us send data to our target website. The script can be seen in the "web_req_script.sh" file, [here](https://github.com/dipperalbel/nodejs-cloud/blob/main/IaaS/web_req_script.sh).
In brief, as our website have a simple form, we use curl to submit the name of the machine running the script and the number of the request it is submitting. With the sleep command we can change the execution's speed for each machine to simulate a higher or lower traffic.

### Paas: Kubernetes

The website itself is deployed inside Kubernetes, together with the MongoDB database.


### Authors
- Alberto Bellumat
- Alessandro Gnutti
