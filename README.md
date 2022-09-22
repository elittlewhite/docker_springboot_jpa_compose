
# use docker-compose
## 建立、重新建立容器用的映像檔
$ docker-compose build

## 確認IMAGE內容
$ docker images

### 建立容器、運行環境
$ docker-compose up -d

## 停用、刪除容器和網路，但保留volume和image
$ docker-compose up -d
## 停用、刪除容器和網路、volume，但保留image
$ docker-compose -f /Users/kenwhite/docker-sample-code/docker_springboot_jpa_compose/docker-compose.yml up -d

###刪除容器、運行環境
$ docker-compose down
$ docker-compose -f /Users/kenwhite/docker-sample-code/docker_springboot_jpa_compose/docker-compose.yml down -v

$ docker-compose stop
$ docker-compose -f /Users/kenwhite/docker-sample-code/docker_springboot_jpa_compose/docker-compose.yml stop

# create network & volume
#
$ docker network create -d bridge demo-bridge
$ docker volume create demo-volume

# https://hub.docker.com/_/mysql
# run mysql
#
$ docker run -d --name mysql \
    --network demo-bridge \
    -v demo-volume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_USER=admin \
    -e MYSQL_PASSWORD=admin \
    -p 3306:3306 mysql:5.7

# FOR MAC M1
$ docker run -d --name mysql \
    --network demo-bridge \
    -v demo-volume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_USER=admin \
    -e MYSQL_PASSWORD=admin \
    --platform linux/x86_64 \
    -p 3306:3306 mysql:5.7

# run mysql init sql
#
$ docker exec -i mysql mysql -u root -proot < demo.sql

# build spring boot docker image & run container
#
$ mvn clean package
$ docker build -t springio-api:1.1.0 .
$ docker run -d --name springio-api \
    --network demo-bridge \
    -p 8080:8080 \
    springio-api:1.1.0

# check API
#
$ curl http://localhost:8080/skill/1

# ====================clean up===============================
# stop & remove container springio-api & mysql
#
$ docker stop springio-api && docker rm springio-api
$ docker stop mysql && docker rm mysql

# remove image springio-api & mysql
#
$ docker rmi springio-api:1.0.0
$ docker rmi mysql:5.7

# remove network & volume
#
$ docker network rm demo-bridge
$ docker volume rm demo-volume

