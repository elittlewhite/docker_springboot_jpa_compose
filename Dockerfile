# Use maven to compile the java application.
FROM maven:3.8.6-openjdk-8-slim AS build-env

RUN mkdir -p /opt/build
WORKDIR /opt/build
COPY pom.xml ./
#mvn verify 驗證專案正確性以及所有必要資訊已備妥
RUN mvn verify --fail-never
COPY . ./
#mvn package 將相關檔案進行封裝，例如產生JAR檔案。
#使用maven.test.skip，不但跳過單元測試的執行，也跳過測試程式碼的編譯。
RUN mvn -Dmaven.test.skip=true package

FROM openjdk:8-jre-alpine

WORKDIR /opt/app
# COPY --from instruction to copy from a separate image, 
# either using the local image name, a tag available locally or on a Docker registry, or a tag ID.
COPY --from=build-env /opt/build/target/*.jar /opt/app/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
