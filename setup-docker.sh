#!/bin/sh

docker build -t snipeit .

# export DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
# export MYSQL_PORT_3306_TCP_ADDR=localhost
# export MYSQL_PORT_3306_TCP_PORT=3307

# sed -i -r "s/^(MYSQL_ROOT_PASSWORD=).*/\1 $MYSQL_ROOT_PASSWORD/" ./.env.docker
# sed -i -r "s/^(MYSQL_PASSWORD=).*/\1 $MYSQL_PASSWORD/" ./.env.docker
# sed -i -r "s/^(DB_PASSWORD=).*/\1 $DB_PASSWORD/" ./.env.docker
# sed -i -r "s/^(MYSQL_PORT_3306_TCP_ADDR=).*/\1 $MYSQL_PORT_3306_TCP_ADDR/" ./.env.docker
# sed -i -r "s/^(MYSQL_PORT_3306_TCP_ADDR=).*/\1 $MYSQL_PORT_3306_TCP_PORT/" ./.env.docker

docker run -itd --name snipeit-instance \
    --env-file=./.env.docker \
    -p 80:80 -p 443:443 \
    -v /home/azorahai/projects/personal/snipe-it:/var/www/html \
    -P \
    --link snipeit-db-instance:mysql \
    snipeit

# docker exec -d snipeit-instance export APP_KEY=$(php artisan key:generate --show)
docker exec -i -t snipeit-instance composer install
