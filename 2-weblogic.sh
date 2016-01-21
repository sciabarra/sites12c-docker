#!/bin/bash
# prepare
test -e _machine.sh && source $PWD/_machine.sh
docker tag owcs/1-base-oracle owcs/2-shared:latest 
docker build -t owcs/2-weblogic:latest install-weblogic
# configure weblogic
docker run -h shared.loc --name shared.loc \
  -p 1521:1521 -d owcs/2-shared
docker run -h sites.loc --name sites.loc --link shared.loc \
  -ti owcs/2-weblogic \
  bash install-weblogic.sh
docker stop shared.loc
docker commit shared.loc owcs/2-shared:latest
docker commit sites.loc owcs/2-weblogic:latest
docker rm sites.loc shared.loc 
