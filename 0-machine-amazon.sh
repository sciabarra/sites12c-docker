#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
echo "eval \$(docker-machine env $DOCKER_MACHINE)"  >_machine.sh
docker-machine create --driver amazonec2 \
--amazonec2-vpc-id ${2:?amazon vpc id} \
--amazonec2-access-key ${3:?amazon access key} \
--amazonec2-secret-key ${4:?amazon secret key} \
--amazonec2-root-size 30 \
--amazonec2-instance-type t2.medium $DOCKER_MACHINE
# --amazonec2-region ${5:?a region for your vpc} 
echo Please use this ip for installing sites or create a dns/host alias
docker-machine ip $DOCKER_MACHINE
# adding swap space
docker-machine ssh $DOCKER_MACHINE "sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048"
docker-machine ssh $DOCKER_MACHINE "sudo /bin/chmod 0600 /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "sudo /sbin/mkswap /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "sudo /sbin/swapon /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "free"
