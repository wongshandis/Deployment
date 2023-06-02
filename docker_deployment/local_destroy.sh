#!/bin/bash

docker compose down --rmi local
#docker rmi $(docker images | grep 'postgres') $(docker images | grep 'dpage/pgadmin4') $(docker images | grep 'none')
docker rmi -f postgres:latest dpage/pgadmin4:latest
docker volume rm `docker volume ls -q -f dangling=true`
echo *** Cleaned Up! ***

