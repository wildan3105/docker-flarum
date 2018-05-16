#!/bin/sh
echo 'Starting...';

# create flarum container
docker run -d --name flarum_forum -v contents:/var/www/html -v assets:/var/www/html/assets --link flarum_db:mariadb flarum_v1 

# create nginx container
docker run -d --name flarum_nginx -p 80:80 -v contents:/var/www/html:ro -v assets:/var/www/html/assets:ro -v /home/wil/flarum_v1/nginx/flarum.conf:/etc/nginx/conf.d/default.conf:ro --link flarum_forum:flarum_v1 nginx

# check if all containers are running
docker ps 

echo 'Finish with zero exit code';