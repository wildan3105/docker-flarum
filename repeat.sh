!#/bin/sh
# docker run and start development server using flagrow/serve
echo 'Starting...' && docker run -d --name flarum_forum_v3 -v contents:/var/www/html -v assets:/var/www/html/assets --link flarum_db_v3:mariadb flarum_v3 /bin/sh
