#!/bin/bash

set -x

mvn install -DskipTests
docker login
docker build . -t hatemhobbies/wallet:2.0
docker push  hatemhobbies/wallet:2.0

docker network rm easypaynet
docker network create easypaynet
rm -rf /var/lib/postgresql/data/pgdata
rm -rf /tmp/data

docker run --name empostgres --rm -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgres -e PGDATA=/var/lib/postgresql/data/pgdata -v /tmp/data:/var/lib/postgresql/data -p 5432:5432 -d postgres:14.1-alpine
POSTGRESSQL_CONTAINER_IP=`docker inspect -f \ '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' empostgres `
sleep 10
docker run --name walletservice --network=easypaynet  -p 8080:8080 -e POSTGRES_HOST="${POSTGRESSQL_CONTAINER_IP## }"  hatemhobbies/wallet:2.0


~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                                                                                                                                                                                                                             
~                                                        
