
# RUN git clone <>
# replace adfs auth js file
# run

## References
#  https://codefresh.io/docker-tutorial/java_docker_pipeline/

FROM openjdk:8-jdk-alpine as intermediate
# ----
# Install Maven
RUN apk add --no-cache curl tar bash
ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"
RUN mkdir -p /usr/share/maven && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
# speed up Maven JVM a bit
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
ENTRYPOINT ["/usr/bin/mvn"]
# ----
# Install project dependencies and keep sources
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# install maven dependency packages (keep in image)
COPY pom.xml /usr/src/app
# copy other source files (keep in image)
COPY src /usr/src/app/src/
# RUN mvn -T 1C install && rm -rf target
RUN mvn clean install


FROM tomcat:8
COPY --from=intermediate /usr/src/app/target/*.war /usr/local/tomcat/webapps/
ADD dockerconfig/ /usr/local/tomcat/conf
ADD dockercontext/ /usr/local/tomcat/webapps/manager/META-INF/
ADD dockercontext/ /usr/local/tomcat/webapps/host-manager/META-INF/
CMD ["catalina.sh", "run"]


# commands
# docker build -t restservice .
# docker run restservice
# docker inspect restservice
# docker ps
# docker port <>
# http://192.168.2.114:32768/restservices-1.0/services/Finally