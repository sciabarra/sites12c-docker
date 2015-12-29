#!/bin/bash
EXTERN=${1:?hostname of sites docker machine}
source _machine.sh
if ! docker images | grep localhost:5000/owcs/sites
then source registry-on-s3.sh
     docker pull localhost:5000/owcs/sites
     docker pull localhost:5000/owcs/shared
     docker stop registry
fi
EXTRA_IP=$(docker-machine ip $DOCKER_MACHINE_NAME)
cat >docker-compose.yml <<"EOF"
shared:
  image: localhost:5000/owcs/shared
  hostname: shared
  domainname: loc
  expose:
    - "1521"
sites:
  image: localhost:5000/owcs/sites
  hostname: sites
  domainname: loc
  links:
    - shared:shared.loc
  ports:
    - "7003:7003"
  command: bash run-sites.sh
  extra_hosts:
EOF
echo "    - \"$EXTERN:$EXTRA_IP\"" >>docker-compose.yml
docker-compose up

