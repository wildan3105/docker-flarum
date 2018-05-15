#!/bin/sh
echo 'Starting...'
# create volume for db
docker volume create db-data
docker volume web-contents
docker volume web-assets

# create db container
docker run -d --name flarum_db -e MYSQL_ROOT_PASSWORD=wildan123 -e MYSQL_USER=wildan -e MYSQL_PASSWORD=wildan123 MYSQL_DATABASE=flarum -v db-data:/var/lib/mysql mariadb:10.1

# create flarum container
docker run -d --name flarum_forum -v web-contents:/var/www/html -v web-assets:/var/www/html/assets --link flarum_db:mariadb flarum_v1 

# create nginx container
docker run -d --name flarum_nginx -p 80:80 -v web-contents:/var/www/html:ro -v web-assets:/var/www/html/assets:ro -v /home/wil/flarum_v1/nginx/flarum.conf:/etc/nginx/conf.d/default.conf:ro --link flarum_forum:flarum_v1 nginx

# check if all containers are running
docker ps 

echo 'Finish with zero exit code'