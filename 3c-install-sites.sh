#!/bin/bash
eval $(bash _machine.sh)
docker run -h shared --name shared.loc -p 1521:1521 \
  -d owcs/3b-shared
docker run -h sites --name sites.loc \
  --link shared.loc --volumes-from shared.loc \
  -p 7001:7001 -p 7003:7003 -ti owcs/3b-sites \
  bash install-sites.sh
docker stop shared.loc
docker commit shared.loc owcs/3c-shared:latest
docker commit sites.loc owcs/3c-sites:latest
