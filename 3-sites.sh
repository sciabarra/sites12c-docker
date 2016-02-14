#!/bin/bash
test -e _machine.sh && source $PWD/_machine.sh
IP=127.0.0.1
HOST="${1:?hostname assigned to sites}"
PASSWORD=${2:?default password for all users}
DBO="${3:?Oracle or HSQLDB}"
EXTRA_HOST="$HOST:$IP"
DB=$(echo $DBO | tr A-Z a-z)
docker rm shared.loc sites.loc 2>/dev/null
cp docker-compose.yml.tmpl docker-compose.yml
echo "    - \"$EXTRA_HOST\"">>docker-compose.yml
echo $HOST >install-sites/host.txt
echo $PASSWORD >install-sites/password.txt
echo $DBO >install-sites/db.txt
docker build -t owcs/3-sites-$DB:latest install-sites
docker run -h shared.loc --name shared.loc \
  -p 1521:1521 \
  -d owcs/2-shared
docker run -h sites.loc --name sites.loc \
  --link shared.loc \
  --add-host "$EXTRA_HOST" \
  -p 7003:7003 -p 7001:7001 \
  -ti owcs/3-sites-$DB \
   /app/install-sites.sh 
docker stop shared.loc
docker commit shared.loc owcs/3-shared-$DB:latest
docker commit --change "CMD /app/run-sites.sh ; tail -f /app/logs/sites.log" sites.loc owcs/3-sites-$DB:latest
docker tag -f owcs/3-sites-$DB localhost:5000/owcs/sites
docker tag -f owcs/3-shared-$DB localhost:5000/owcs/shared
docker rm shared.loc sites.loc
echo "You can now start sites with 'docker-compose up'"
echo "Either start it or save it on S3 with step 4"
