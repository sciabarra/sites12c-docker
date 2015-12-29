#!/bin/bash

DOCKER_MACHINE=owcs.local
AWS_KEY=AKIAIG7UX74DUQWPQYXA
AWS_SECRET=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
AWS_BUCKET=sites001-docker-registry
m

test -n "$DOCKER_MACHINE" || DOCKER_MACHINE=${1:?docker machine}
test -n "$AWS_KEY" || AWS_KEY=${2:?amazon access key}
test -n "$AWS_SECRET" || AWS_SECRET=${3:?amazon secret key}
test -n "$AWS_BUCKET" || AWS_BUCKET=${4:?s3 bucket name}

if docker-machine env $DOCKER_MACHINE
then
    eval $(docker-machine env $DOCKER_MACHINE)
    docker-machine start $DOCKER_MACHINE
else 
    docker-machine create $DOCKER_MACHINE \
--driver virtualbox \
--virtualbox-memory "8192" \
--virtualbox-disk-size "30000"
fi 

docker run -d -restart-always \
-p 5000:5000 \
-e REGISTRY_STORAGE=s3 \
-e REGISTRY_STORAGE_S3_REGION=us-east-1 \
-e REGISTRY_STORAGE_S3_BUCKET="$AWS_BUCKET" \
-e REGISTRY_STORAGE_S3_ACCESSKEY="$AWS_KEY" \
-e REGISTRY_STORAGE_S3_SECRETKEY="$AWS_SECRET" \
registry:2

docker pull localhost:5000/owcs/sites
docker pull localhost:5000/owcs/shared
