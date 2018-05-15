# Flarum, dockerized.

## Using `docker-compose.yml`
1. Edit credentials in `docker-compose.yml`
2. Start the service : `docker-compose up -d`

## Using `Dockerfile`
1. Build flarum image by running : `docker build -t flarum:latest ./`
2. Create containers for : webserver, database, and flarum app by run `./run.sh`
