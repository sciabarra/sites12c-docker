#!/bin/bash
EXTRA_HOST="${1:?hostname assigned to sites}:${2:?public ip}"
cp docker-compose.yml.tmpl docker-compose.yml
echo "    - \"$EXTRA_HOST\"">>docker-compose.yml
AWS_KEY=${3?aws key}
AWS_SECRET=${4?aws secret}
AWS_BUCKET=${5:?aws bucket name}
source $PWD/registry-on-s3.sh
docker pull localhost:5000/owcs/sites
docker pull localhost:5000/owcs/shared
echo "Restore done - you can start with docker-compose up"
