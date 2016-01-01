#!/bin/bash
source $PWD/_machine.sh
HOST=$(docker-machine ip $DOCKER_MACHINE_NAME)
EXTRA_HOST="${1:?hostname assigned to sites}:$HOST"
cp docker-compose.yml.tmpl docker-compose.yml
echo "    - \"$EXTRA_HOST\"">>docker-compose.yml
PASSWORD=${2:?default password for all users}
echo $EXTERN >install-sites/host.txt
echo $PASSWORD >install-sites/password.txt
docker build -t owcs/3-sites:latest install-sites
docker run -h shared.loc --name shared.loc \
  -p 1521:1521 \
  -d owcs/2-shared
docker run -h sites.loc --name sites.loc \
  --link shared.loc \
  --add-host $EXTRA_HOST \
  -p 7003:7003 \
  -ti owcs/3-sites \
  bash install-sites.sh 
docker stop shared.loc
docker commit shared.loc owcs/3-shared:latest
docker commit sites.loc owcs/3-sites:latest
docker rm shared.loc sites.loc
docker tag -f owcs/3-sites localhost:5000/owcs/sites
docker tag -f owcs/3-shared localhost:5000/owcs/shared
