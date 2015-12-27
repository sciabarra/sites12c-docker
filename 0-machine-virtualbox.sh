#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo "eval \$(docker-machine env $DOCKER_MACHINE)"  >_machine.sh
docker-machine create $DOCKER_MACHINE \
--driver virtualbox \
--virtualbox-memory "8192" \
--virtualbox-disk-size "30000" 
