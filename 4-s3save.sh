#!/bin/bash
AWS_BUCKET=${1:?aws bucket}
test -e _machine.sh && source $PWD/_machine.sh
source $PWD/registry-on-s3.sh
docker push localhost:5000/owcs/sites
docker push localhost:5000/owcs/shared
