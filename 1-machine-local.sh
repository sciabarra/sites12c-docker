#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo docker-machine env $DOCKER_MACHINE  >_machine.sh
docker-machine create $DOCKER_MACHINE \
--driver virtualbox \
--virtualbox-memory "10000" \
--virtualbox-disk-size "30000" 
