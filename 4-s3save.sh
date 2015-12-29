#!/bin/bash
source _machine.sh
source registry-on-s3.sh
docker push localhost:5000/owcs/sites
docker push localhost:5000/owcs/shared
