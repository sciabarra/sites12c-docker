#!/bin/bash
source $PWD/_machine.sh
USER=${1:?your oracle username}
PASS=${2:?your oracle password}
cp sources.txt base-java/sources.link
printf "username=$USER\npassword=$PASS\n" >>base-java/sources.link
for i in base-java base-oracle base-weblogic base-sites 
do echo ============  BUILD owcs/1-$i:latest 
docker build -t owcs/1-$i:latest $i
done
