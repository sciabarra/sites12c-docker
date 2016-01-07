#!/bin/bash
test -n "$DOCKER_MACHINE_NAME" || DOCKER_MACHINE_NAME=${1:?docker machine}
KEY=${AWS_KEY:?amazon access key}
SECRET=${AWS_SECRET:?amazon secret key}
BUCKET=${AWS_BUCKET:?s3 bucket name}
docker run -d -p 5000:5000 --name=registry \
-e REGISTRY_STORAGE=s3 \
-e REGISTRY_STORAGE_S3_REGION=us-east-1 \
-e REGISTRY_STORAGE_S3_BUCKET="$BUCKET" \
-e REGISTRY_STORAGE_S3_ACCESSKEY="$KEY" \
-e REGISTRY_STORAGE_S3_SECRETKEY="$SECRET" \
registry:2
sleep 5
