#!/bin/bash

echo *** Starting up Postgres and pgAdmin4 ***
docker-compose -f docker-compose.yaml up -d --build