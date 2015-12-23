#!/bin/bash
eval $(bash _machine.sh)
# prepare
docker build -t owcs/3a-shared:latest install-shared
docker build -t owcs/3a-weblogic:latest install-weblogic
