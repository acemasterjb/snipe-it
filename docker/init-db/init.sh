#!/bin/sh

# if [ -z "$MYSQL_ROOT_PASSWORD"] || [ "$MYSQL_ROOT_PASSWORD" == "changeme1234" ]
# then
#   echo "Generating mysql root password..."
#   export MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
# fi

# if [ -z "$MYSQL_PASSWORD" ] || [ "$MYSQL_PASSWORD" == "changeme1234" ]
# then
#   echo "Generating mysql password..."
#   export MYSQL_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
# fi

# echo "Generating db password..."
# export DB_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

docker build -t mariadb $(pwd)/docker/init-db/.

docker run -itd -p 3307:3306 \
    --name snipeit-db-instance \
    --env-file ./.env.mysql \
    --mount source=snipesql-vol,target=/var/lib/mysql \
    mariadb
