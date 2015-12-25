#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo "eval \$(docker-machine env $DOCKER_MACHINE)"  >_machine.sh
docker-machine create --driver amazonec2 \
--amazonec2-vpc-id ${2:?amazon vpc id} \
--amazonec2-region ${3:-a region for your vpc}  \
--amazonec2-access-key ${4:?amazon access key} \
--amazonec2-secret-key ${5:?amazon secret key} \
--amazonec2-root-size 30 \
--amazonec2-instance-type t2.large $DOCKER_MACHINE
# adding swap space
docker-machine ssh $DOCKER_MACHINE sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
docker-machine ssh $DOCKER_MACHINE sudo /sbin/mkswap /var/swap.1
docker-machine ssh $DOCKER_MACHINE sudo /sbin/swapon /var/swap.1
