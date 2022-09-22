
# use docker-compose
## 建立、重新建立容器用的映像檔
$ docker-compose build

## 確認IMAGE內容
$ docker images

### 建立容器、運行環境
$ docker-compose up -d
## 確認有無執行成功
$ curl http://localhost:8080/skill/1
## 停用、刪除容器和網路，但保留volume和image
$ docker-compose down
## 看volume image是否仍存在
$ docker volume ls
$ docker images
## 停用、刪除容器和網路、volume，但保留image
$ docker-compose -f /Users/kenwhite/docker-sample-code/docker_springboot_jpa_compose/docker-compose.yml down -v
## 看volume image是否仍存在
$ docker volume ls
$ docker images

## 重啟容器
$ docker-compose up -d
## 去修改YAML檔的port設定 重啟不會生效
$ docker-compose restart

## 確認有無執行成功
$ curl http://localhost:8080/skill/1
## 停用容器
$ docker-compose stop

$ docker-compose -f /Users/kenwhite/docker-sample-code/docker_springboot_jpa_compose/docker-compose.yml stop

## ----------
# WITHOUT DOCKER COMPOSE
## create network & volume
##
$ docker network create -d bridge demo-bridge
$ docker volume create demo-volume


## run mysql
##
$ docker run -d --name mysql \
    --network demo-bridge \
    -v demo-volume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_USER=admin \
    -e MYSQL_PASSWORD=admin \
    -p 3306:3306 mysql:5.7

## FOR MAC M1
$ docker run -d --name mysql \
    --network demo-bridge \
    -v demo-volume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_USER=admin \
    -e MYSQL_PASSWORD=admin \
    --platform linux/x86_64 \
    -p 3306:3306 mysql:5.7

## run mysql init sql
##
$ docker exec -i mysql mysql -u root -proot < demo.sql

## build spring boot docker image & run container
##
$ mvn clean package
$ docker build -t springio-api:1.1.0 .
$ docker run -d --name springio-api \
    --network demo-bridge \
    -p 8080:8080 \
    springio-api:1.1.0

## check API
##
$ curl http://localhost:8080/skill/1

## ====================clean up===============================
## stop & remove container springio-api & mysql
##
$ docker stop springio-api && docker rm springio-api
$ docker stop mysql && docker rm mysql

## remove image springio-api & mysql
##
$ docker rmi springio-api:1.0.0
$ docker rmi mysql:5.7

## remove network & volume
##
$ docker network rm demo-bridge
$ docker volume rm demo-volume

