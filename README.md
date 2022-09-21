### prerequisite
* [Install Docker](https://www.docker.com/)
* [Install JDK](https://adoptopenjdk.net/)
* [Install Maven 3](https://maven.apache.org/install.html)
* [Install Git](https://www.atlassian.com/git/tutorials/install-git)

### Spring Boot
* [Spring Initializr](https://start.spring.io/)
* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.6.6/maven-plugin/reference/html/)
* [Spring Web](https://docs.spring.io/spring-boot/docs/2.6.6/reference/htmlsingle/#boot-features-developing-web-applications)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.6.6/reference/htmlsingle/#boot-features-jpa-and-spring-data)

### Tomcat
* [Tomcat](https://tomcat.apache.org/download-80.cgi)

### JPA / Hibernate
* [OSIV](https://medium.com/@rafaelralf90/open-session-in-view-is-evil-fd9a21645f8e)
* [CascadeType/FetchType](https://openhome.cc/Gossip/EJB3Gossip/CascadeTypeFetchType.html)
* [lazyinitializationexception](https://matthung0807.blogspot.com/2020/11/spring-data-jpa-one-to-many-lazyinitializationexception.html)
* [JPA Concepts](https://tomee.apache.org/jpa-concepts.html)
* [N+1](https://www.javacodemonk.com/n-1-problem-in-hibernate-spring-data-jpa-894097b9)
* [find query executed](https://dataedo.com/kb/query/mysql/find-last-query-executed-by-session)

### script
```
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
```