FROM php:7.1-fpm

ARG \
  FLARUM_VERSION=v0.1.0-beta.7
ENV \
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/tmp

RUN \
  echo "memory_limit=-1" > "$PHP_INI_DIR/conf.d/memory-limit.ini" && \
  echo "date.timezone=${PHP_TIMEZONE:-UTC}" > "$PHP_INI_DIR/conf.d/date_timezone.ini" && \
  \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libgd-dev unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
  docker-php-ext-install -j$(nproc) pdo_mysql gd && \
  \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  chmod +x /usr/local/bin/composer && \
  \
  chown www-data:www-data /var/www/html

USER www-data
WORKDIR /var/www/html

RUN \
  composer create-project flarum/flarum=${FLARUM_VERSION} . --stability=beta

# Add flarum extensions, then clean up
RUN \
  composer require flagrow/upload && \
  composer clear-cache && \
  ln -s assets/config.php config.php

VOLUME ["/var/www/html", "/var/www/html/assets"]

COPY root /

RUN chmod +x /usr/local/bin/*

CMD ["repeat.sh"]