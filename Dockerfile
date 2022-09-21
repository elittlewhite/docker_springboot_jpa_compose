# Use maven to compile the java application.
FROM maven:3.8.6-openjdk-8-slim AS build-env

RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY pom.xml ./
RUN mvn verify --fail-never
COPY . ./
RUN mvn -Dmaven.test.skip=true package

FROM openjdk:8-jre-alpine

WORKDIR /opt
EXPOSE 8080
COPY target/*.jar /opt/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
