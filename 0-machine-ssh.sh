#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
IP=${2:?ip of your machine}
USER=${3:?user}
echo "eval \$(docker-machine env $DOCKER_MACHINE)"  >_machine.sh
test -e _machine.key || ssh-keygen -t rsa -f _machine.key
echo "Please type the root password to install docker"
ssh-copy-id -i $PWD/_machine.key $USER@$IP
docker-machine --debug --native-ssh create $DOCKER_MACHINE  \
 --driver generic \
 --generic-ssh-key $PWD/_machine.key \
 --generic-ssh-user $USER \
 --generic-ip-address $IP
