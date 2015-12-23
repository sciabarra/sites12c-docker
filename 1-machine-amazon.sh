#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo docker-machine env $DOCKER_MACHINE  >_machine.sh
docker-machine create --driver amazonec2 \
--amazonec2-access-key ${2:-amazon access key} \
--amazonec2-secret-key ${3:-amazon secret key} \
--amazonec2-vpc-id ${4:?amazon vpc id} \
--amazonec2-region eu-west-1 \
--amazonec2-instance-type t2.large $DOCKER_MACHINE
