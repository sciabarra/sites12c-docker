#!/bin/bash
eval $(bash _machine.sh)
echo $DOCKER_HOST | sed -e 's!tcp://!!' -e 's/:.*//' >install-sites/host.txt
# prepare
docker build -t owcs/install-sites-preweblogic:latest install-sites
docker build -t owcs/install-shared-preweblogic:latest install-shared
# configure weblogic
docker run -d -h shared --name shared.loc -p 1521:1521 owcs/install-shared-preweblogic
docker run -h sites --name sites.loc --link shared.loc \
  -ti owcs/install-sites-preweblogic \
  bash install-weblogic.sh
docker stop shared.loc
docker commit shared.loc owcs/install-shared-presites:latest
docker commit sites.loc owcs/install-sites-presites:latest
docker rm sites.loc shared.loc 
