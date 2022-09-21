# Use maven to compile the java application.
FROM maven:3.8.6-openjdk-8-slim AS build-env

RUN mkdir -p /opt/build
WORKDIR /opt/build
COPY pom.xml ./
RUN mvn verify --fail-never
COPY . ./
RUN mvn -Dmaven.test.skip=true package

FROM openjdk:8-jre-alpine

WORKDIR /opt/app
COPY --from=build-env /opt/build/target/*.jar /opt/app/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
