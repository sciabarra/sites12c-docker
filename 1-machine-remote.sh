#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo docker-machine env $DOCKER_MACHINE  >_machine.sh
HOST=${2:?hostname}
test -e _owcs-machine.key || ssh-keygen -t rsa -f _owcs-machine.key
echo "Please type the root password"
ssh-copy-id -i _owcs-machine.key root@$HOST
docker-machine create $DOCKER_MACHINE  \
 --driver generic \
 --generic-ssh-key _owcs-machine.key \
 --generic-ip-address $HOST
