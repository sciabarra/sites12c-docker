#!/bin/bash
eval $(bash _machine.sh)
# prepare
docker build -t owcs/3a-install-shared:latest install-shared
docker build -t owcs/3a-install-weblogic:latest install-weblogic
