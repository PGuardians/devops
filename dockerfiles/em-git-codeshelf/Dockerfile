FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn clean package -DskipTests

FROM centos:7
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y update
RUN yum -y install wget vim
RUN wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
RUN yum -y install ./jdk-17_linux-x64_bin.rpm

RUN yum -y install epel-release && \
    yum -y update && \
    yum -y install redis && \
    yum clean all


WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
#ENTRYPOINT ["sh", "-c", "redis-server --daemonize yes && java -jar app.jar"]
