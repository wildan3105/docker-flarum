!#/bin/sh
echo 'Starting...' && docker volume create db && docker volume create contents && docker volume create assets && docker run -d --name flarum_db_v3 -e MYSQL_ROOT_PASSWORD=wildan123 -e MYSQL_USER=wildan -e MYSQL_PASSWORD=wildan123 -e MYSQL_DATABASE=flarum -v db:/var/lib/mysql mariadb:10.1 && echo 'DB container created';
