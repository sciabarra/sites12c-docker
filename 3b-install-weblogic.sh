#!/bin/bash
eval $(bash _machine.sh)

# configure weblogic
docker run -d -h shared --name shared.loc \
  -p 1521:1521 owcs/3a-shared
docker run -h sites --name sites.loc --link shared.loc \
  -ti owcs/3a-weblogic \
  bash install-weblogic.sh
docker stop shared.loc
docker commit shared.loc owcs/3b-shared:latest
docker commit sites.loc owcs/3b-weblogic:latest
docker rm sites.loc shared.loc 
docker build -t owcs/3b-sites:latest install-sites
