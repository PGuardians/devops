#!/bin/sh
git-http-server -p 3000 /mnt/git/ &
redis-server --daemonize yes && java -jar app.jar
exec "$@"
