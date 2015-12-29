#!/bin/bash
DOCKER_MACHINE_NAME=${1:?machine name}
AWS_KEY=${2:?amazon access key}
AWS_SECRET=${3:?amazon secret key}
AWS_VPC=${4:?amazon vpc id}
AWS_BUCKET=${5:?s3 bucket}
MTYPE=t2.large
#${6:?machine type - recommended t2.large for build, t2.medium to run}
echo "eval \$(docker-machine env $DOCKER_MACHINE_NAME)"  >_machine.sh
echo "AWS_KEY=$AWS_KEY">>_machine.sh
echo "AWS_SECRET=$AWS_SECRET">>_machine.sh
echo "AWS_VPC=$AWS_VPC">>_machine.sh
echo "AWS_BUCKET=$AWS_BUCKET">>_machine.sh
# create machine
docker-machine create --driver amazonec2 \
--amazonec2-vpc-id "$AWS_VPC"  \
--amazonec2-access-key "$AWS_KEY" \
--amazonec2-secret-key  "$AWS_SECRET" \
--amazonec2-root-size 30 \
--amazonec2-instance-type $MTYPE $DOCKER_MACHINE_NAME
# add swap space
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /bin/chmod 0600 /var/swap.1"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /sbin/mkswap /var/swap.1"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo /sbin/swapon /var/swap.1"
docker-machine ssh $DOCKER_MACHINE_NAME "free"
# print info
echo Please create a dns alias to this ip for installing sites:
docker-machine ip $DOCKER_MACHINE_NAME
