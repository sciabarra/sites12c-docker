#!/bin/bash
test -e $PWD/_machine.sh && source $PWD/_machine.sh
HOST="${1:?hostname assigned to sites}"
IP="$(docker-machine ip $DOCKER_MACHINE_NAME)"
EXTRA_HOST="$HOST:$IP"
cp docker-compose.yml.tmpl docker-compose.yml
echo "    - \"$EXTRA_HOST\"">>docker-compose.yml
PASSWORD=${2:?default password for all users}
echo $HOST >install-sites/host.txt
echo $PASSWORD >install-sites/password.txt
docker build -t owcs/3-sites:latest install-sites
docker run -h shared.loc --name shared.loc \
  -p 1521:1521 \
  -d owcs/2-shared
docker run -h sites.loc --name sites.loc \
  --link shared.loc \
  --add-host "$EXTRA_HOST" \
  -p 7003:7003 \
  -ti owcs/3-sites \
  bash install-sites.sh 
docker stop shared.loc
docker commit shared.loc owcs/3-shared:latest
docker commit --change "CMD bash run-sites.sh ; tail -f /app/logs/sites.log" sites.loc owcs/3-sites:latest
#docker rm shared.loc sites.loc
docker tag -f owcs/3-sites localhost:5000/owcs/sites
docker tag -f owcs/3-shared localhost:5000/owcs/shared
echo "You can now start sites with 'docker-compose up'"
echo "Either start it or save it on S3 with step 4"
