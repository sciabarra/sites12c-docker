#!/bin/bash
source _machine.sh
echo sites.loc >install-sites/host.txt
docker build -t owcs/3-sites:latest install-sites
docker run -h shared.loc --name shared.loc \
  -p 1521:1521 \
  -d owcs/2-shared
docker run -h sites.loc --name sites.loc \
  --link shared.loc \
  -p 7003:7003 \
  -ti owcs/3-sites \
  bash install-sites.sh 
docker stop shared.loc
docker commit shared.loc owcs/3-shared:latest
docker commit sites.loc owcs/3-sites:latest
docker rm shared.loc sites.loc
docker tag owcs/3-sites owcs/sites
docker tag owcs/3-shared owcs/shared
