FROM maven:3-jdk-11 as BUILD

COPY . /usr/src/app
RUN mvn --batch-mode -f /usr/src/app/pom.xml clean package

FROM openjdk:11-jre-slim
ENV PORT 4567
EXPOSE 4567
COPY --from=BUILD /usr/src/app/target /opt/target
WORKDIR /opt/target
ENTRYPOINT ["java","-jar","webfrontend-0.1.0.jar"]
#CMD ["/bin/bash", "-c", "find -type f -name '*-with-dependencies.jar' | xargs java -jar"]
