#!/bin/sh
echo 'Starting...';

# create flarum container
docker run -d --name flarum_forum_v3 -v contents:/var/www/html -v assets:/var/www/html/assets --link flarum_db:mariadb flarum_v3

# create nginx container
docker run -d --name flarum_nginx_v3 -p 8002:80 -v contents:/var/www/html:ro -v assets:/var/www/html/assets:ro -v /home/wil/flarum_v3/nginx/flarum.conf:/etc/nginx/conf.d/default.conf:ro --link flarum_forum_v3:flarum_v3 nginx

# check if all containers are running
docker ps 

echo 'Finish with zero exit code';