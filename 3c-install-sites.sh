#!/bin/bash
eval $(bash _machine.sh)
HOST=$(echo $DOCKER_HOST | sed -e 's!tcp://!!' -e 's/:.*//')
echo ${1:? usage: $0 \<host\> where \<host\> is either $HOST or an alias to it} >install-sites/host.txt
docker build -t owcs/3c-sites:latest install-sites
docker run -h shared --name shared.loc \
  -p 1521:1521 \
  -d owcs/3b-shared
docker run -h sites --name sites.loc \
  --link shared.loc \
  -p 7003:7003 \
  -ti owcs/3c-sites \
  bash install-sites.sh 
docker stop shared.loc
docker commit shared.loc owcs/shared:latest
docker commit sites.loc owcs/sites:latest
docker rm shared.loc sites.loc
