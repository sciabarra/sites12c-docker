#!/bin/bash
if test -e _machine.sh
then
 source $PWD/_machine.sh
 HOST=$(docker-machine ip $DOCKER_MACHINE_NAME)
else
 HOST=$(hostname -I | awk '{print $1}')
fi
EXTRA_HOST="${1:?hostname assigned to sites}:$HOST"
cp docker-compose.yml.tmpl docker-compose.yml
echo "    - \"$EXTRA_HOST\"">>docker-compose.yml
AWS_KEY=${2:?aws key}
AWS_SECRET=${3?aws secret}
AWS_BUCKET=${4:?aws bucket name}
source $PWD/registry-on-s3.sh
docker pull localhost:5000/owcs/sites
docker pull localhost:5000/owcs/shared
echo "Restore done - you can start with docker-compose up"
