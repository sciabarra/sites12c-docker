#!/bin/bash
eval $(bash _machine.sh)
# prepare
docker build -t owcs/3b-weblogic:latest install-weblogic
# configure weblogic
docker run -h shared --name shared.loc \
  -p 1521:1521 -d owcs/base-oracle
docker run -h sites --name sites.loc \
  --link shared.loc \
  -ti owcs/3b-weblogic \
  bash install-weblogic.sh
docker stop shared.loc
docker commit shared.loc owcs/3b-shared:latest
docker commit sites.loc owcs/3b-weblogic:latest
docker rm sites.loc shared.loc 
