#!/bin/bash
eval $(bash _machine.sh)
echo $DOCKER_HOST | sed -e 's!tcp://!!' -e 's/:.*//' >install-sites/host.txt
docker run -h shared --name shared.loc -p 1521:1521 \
  -d owcs/sites-shared-step2
docker run -h sites --name sites.loc \
  --link shared.loc --volumes-from shared.loc \
  -p 7001:7001 -p 7003:7003 -ti owcs/sites-staging-step2 \
  bash install-sites.sh
docker stop shared.loc
docker commit shared.loc owcs/sites-shared:latest
docker commit sites.loc owcs/sites-staging:latest
