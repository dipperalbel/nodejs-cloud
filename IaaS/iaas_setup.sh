# NOTICE: the commands had been run manually before being gathered in this file and thus the end result may vary.

# Project set up
openstack project create --description "Fog and Cloud Computing project" iaas_architecture


# Member creation
openstack user create --password password --description "admin user for the project" project_admin
openstack role add --user project_admin --project  iaas_architecture admin
openstack user create --project iaas_architecture  --password eval eval
openstack role add --user eval --project iaas_architecture member

# Execution of the iaas_architecture-openrc.sh to make use of the project_admin access to the project, the file can be downloaded from the web dashboard
. iaas_architecture-openrc.sh

# RSA key generation to log in the instances
ssh-keygen -t rsa -b 4096 -N "" -C "Key for iaas_infrastructure project" -f "${HOME}"/.ssh/eval_rsa 
openstack keypair create --public-key "${HOME}/.ssh/eval_rsa.pub" iaas_project_eval_keypair   

# Network setup
openstack network create web_reqs
openstack subnet create --network web_reqs --gateway 10.11.11.1 --subnet-range 10.11.11.0/24 --dns-nameserver 208.67.222.222 --dns-nameserver 208.67.220.220 web_reqs_subnet


# Router setup
openstack router create web_reqs_to_public --availability-zone-hint nova --project iaas_architecture
openstack router set --external-gateway public web_reqs_to_public
openstack router add subnet web_reqs_to_public web_reqs_subnet


# Security groups creation and definition
openstack security group create web --project iaas_architecture  
openstack security group rule create  web   --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0    
openstack security group rule create  web   --protocol tcp --dst-port 443:443 --remote-ip 0.0.0.0/0  
openstack security group rule create  web   --protocol tcp --dst-port 80:80 --remote-ip 0.0.0.0/0
openstack security group rule create  web   --protocol tcp --dst-port 8080:8080 --remote-ip 0.0.0.0/0     
openstack security group create ping --project iaas_architecture
openstack security group rule create ping --protocol icmp --remote-ip 0.0.0.0/0     


# instance creation
openstack server create --flavor mini.ubuntu --image ubuntu-bionic-minimal-cloudimg-amd64 --network web_reqs --key-name iaas_project_eval_keypair --security-group 278ce8ea-20d3-47d6-96a0-f6594e334a02 --security-group ping ubuntu_reqs_1
openstack server create --flavor mini.ubuntu --image ubuntu-bionic-minimal-cloudimg-amd64 --network web_reqs --key-name iaas_project_eval_keypair --security-group 278ce8ea-20d3-47d6-96a0-f6594e334a02 --security-group ping ubuntu_reqs_2
openstack server create --flavor mini.ubuntu --image ubuntu-bionic-minimal-cloudimg-amd64 --network web_reqs --key-name iaas_project_eval_keypair --security-group 278ce8ea-20d3-47d6-96a0-f6594e334a02 --security-group ping ubuntu_reqs_3
openstack server create --flavor mini.ubuntu --image ubuntu-bionic-minimal-cloudimg-amd64 --network web_reqs --key-name iaas_project_eval_keypair --security-group 278ce8ea-20d3-47d6-96a0-f6594e334a02 --security-group ping ubuntu_reqs_4
openstack server create --flavor mini.ubuntu --image ubuntu-bionic-minimal-cloudimg-amd64 --network web_reqs --key-name iaas_project_eval_keypair --security-group 278ce8ea-20d3-47d6-96a0-f6594e334a02 --security-group ping ubuntu_reqs_5

# floating ip creation and addition to each instance
FLOATING_IP=$(openstack floating ip create public --format json | jq -r -M '.name')
openstack server add floating ip ubuntu_reqs_1  ${FLOATING_IP}
FLOATING_IP=$(openstack floating ip create public --format json | jq -r -M '.name')
openstack server add floating ip ubuntu_reqs_2  ${FLOATING_IP}
FLOATING_IP=$(openstack floating ip create public --format json | jq -r -M '.name')
openstack server add floating ip ubuntu_reqs_3  ${FLOATING_IP}
FLOATING_IP=$(openstack floating ip create public --format json | jq -r -M '.name')
openstack server add floating ip ubuntu_reqs_4  ${FLOATING_IP}
FLOATING_IP=$(openstack floating ip create public --format json | jq -r -M '.name')
openstack server add floating ip ubuntu_reqs_5  ${FLOATING_IP}


# volume creation
openstack volume create --image ubuntu-bionic-minimal-cloudimg-amd64 --size 5 --availability-zone nova volume_reqs_1
openstack volume create --image ubuntu-bionic-minimal-cloudimg-amd64 --size 5 --availability-zone nova volume_reqs_2
openstack volume create --image ubuntu-bionic-minimal-cloudimg-amd64 --size 5 --availability-zone nova volume_reqs_3
openstack volume create --image ubuntu-bionic-minimal-cloudimg-amd64 --size 5 --availability-zone nova volume_reqs_4
openstack volume create --image ubuntu-bionic-minimal-cloudimg-amd64 --size 5 --availability-zone nova volume_reqs_5

# volume attachment
openstack server add volume ubuntu_reqs_1 volume_reqs_1
openstack server add volume ubuntu_reqs_1 volume_reqs_2
openstack server add volume ubuntu_reqs_1 volume_reqs_3
openstack server add volume ubuntu_reqs_1 volume_reqs_4
openstack server add volume ubuntu_reqs_1 volume_reqs_5


# The shell script to make curl requests had been manually loaded into each machine


