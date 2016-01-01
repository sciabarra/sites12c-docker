#!/bin/bash
source _machine.sh
EXTRA_HOST="${1:?hostname assigned to sites}:$(docker-machine ip $DOCKER_MACHINE_NAME)"
sed -i -e "s/extra_hosts:.*/extra_hosts: $EXTRA_HOST/" docker-compose.yml
AWS_KEY=${2:?aws key}
AWS_SECRET=${3?aws secret}
AWS_BUCKET=${4:?aws bucket name}
if ! docker images | grep localhost:5000/owcs/sites
then source registry-on-s3.sh
     docker pull localhost:5000/owcs/sites
     docker pull localhost:5000/owcs/shared
     docker stop registry
fi
echo "Restore done - you can start with docker-compose up"
