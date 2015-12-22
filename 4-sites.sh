#!/bin/bash
eval $(bash _machine.sh)
docker run -h shared --name shared.loc -p 1521:1521 \
  -d owcs/install-shared-presites
docker run -h sites --name sites.loc \
  --link shared.loc --volumes-from shared.loc \
  -p 7001:7001 -p 7003:7003 -ti owcs/install-sites-presites \
  bash install-sites.sh
docker commit shared.loc owcs/shared:latest
docker commit sites.loc owcs/sites:latest
