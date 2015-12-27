#!/bin/bash
DOCKER_MACHINE=${1:?machine name}
BUCKET=${2:?s3 bucket name}
ACCESS=${3:?amazon access key}
SECRET=${4:?amazon secret key}
VPC=${5:?amazon vpc id}
echo "eval \$(docker-machine env $DOCKER_MACHINE)"  >_machine.sh
# create machine
docker-machine create --driver amazonec2 \
--amazonec2-vpc-id "$VPC"  \
--amazonec2-access-key "$ACCESS" \
--amazonec2-secret-key  "$SECRET" \
--amazonec2-root-size 30 \
--amazonec2-instance-type t2.large $DOCKER_MACHINE
# add swap space
docker-machine ssh $DOCKER_MACHINE "sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048"
docker-machine ssh $DOCKER_MACHINE "sudo /bin/chmod 0600 /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "sudo /sbin/mkswap /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "sudo /sbin/swapon /var/swap.1"
docker-machine ssh $DOCKER_MACHINE "free"
# start registry
docker run -d -p 5000:5000 \
-e REGISTRY_STORAGE=s3 \
-e REGISTRY_STORAGE_S3_REGION=us-east-1 \
-e REGISTRY_STORAGE_S3_BUCKET="$BUCKET" \
-e REGISTRY_STORAGE_S3_ACCESSKEY="$ACCESS" \
-e REGISTRY_STORAGE_S3_SECRETKEY="$SECRET" \
registry:2
# print info
echo Please use this ip for installing sites or create a dns/host alias
docker-machine ip $DOCKER_MACHINE
