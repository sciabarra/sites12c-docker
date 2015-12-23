#!/bin/bash
eval $(bash _machine.sh)

# configure weblogic
docker run -d -h shared --name shared.loc \
  -p 1521:1521 owcs/3a-install-shared
docker run -h sites --name sites.loc --link shared.loc \
  -ti owcs/3a-install-weblogic \
  bash install-weblogic.sh
docker stop shared.loc
docker commit shared.loc owcs/3b-install-shared:latest
docker commit sites.loc owcs/3b-weblogic:latest
docker rm sites.loc shared.loc 
