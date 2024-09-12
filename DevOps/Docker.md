[//]: # (create TOC)
# Table of Contents


# Docker
Docker is a tool designed to make it easier to create, deploy, and run applications by using containers.<br>
Containers allow a developer to package up an application with all of the parts it needs, <br>
such as libraries and other dependencies, and ship it all out as one package.
* Create a Docker images for each microservice
* Docker image contains everything needed to run the microservice : 
  * code
  * runtime
  * libraries
  * environment variables
  * configuration files
* You can run these docker containers the same way on any infrastructure
## Docker Architecture
![image](DevOps_images/Docker_architecture.png)

## Deployments with Docker
![image](DevOps_images/deployments_w_docker.png)

## CMD Docker commands for images
### To pull an image from docker hub
```cmd
docker pull <image-name>
```
### To see all the images
```cmd
docker images
```
### To remove an image
```cmd
docker rmi <image-id>
```
### To remove all the images
```cmd
docker rmi $(docker images -q)
```
### To change the tag of an image
```cmd
docker tag <image-id> <new-tag>
```
### To push an image to docker hub
```cmd
docker push <image-name>
```
### To inspect an image
```cmd
docker inspect <image-name>
```
### To see the history of an image
```cmd
docker history <image-name>
```
## CMD Docker commands for containers
### Run a container 
```cmd
docker run -p 5000:5000 -d in28min/todo-rest-api-h2:1.0.0.RELEASE
```
* -p 5000:5000 : Map port 5000 of the container to port 5000 on host machine (localhost) // if not specified you can't access
* -d : Run the container in detached mode (in the background) // crt+c to stop won't work
* in28min/todo-rest-api-h2:1.0.0.RELEASE : Image name and version to run // it's pointing to docker hub repository
### To Stop a container
```cmd
docker stop <container-id>
```
### To kill a container
```cmd
docker kill <container-id>
```
### To pause a container
```cmd
docker pause <container-id>
```
### To unpause a container
```cmd
docker unpause <container-id>
```
### To remove all stopped containers
```cmd
docker container prune
```
### To inspect a container
```cmd
docker inspect <container-id>
```
### To see the logs of the container
```cmd
docker logs <container-id>
```
### To see the logs of the container in real time
```cmd
docker logs -f <container-id> 
```
### To see the running containers
```cmd
docker ps
```
### To see all the containers
```cmd
docker ps -a
```
### To remove the container
```cmd
docker rm <container-id>
```
### To remove all the containers
```cmd
docker rm $(docker ps -a -q)
```
## CMD Docker commands (extra)
### To see the events of docker
```cmd
docker events
```
### To check all the processes running inside a specific container
```cmd
docker top <container-id>
```
### To see the stats of a container
```cmd
docker stats <container-id>
```
### To see the disk usage of docker
```cmd
docker system df
```
## CMD Docker commands policy
### Restart
* no : Never restart
* always : Always restart
* on-failure : Restart only if the container stops with an error code
* unless-stopped : Always restart unless we forcibly stop it
```cmd
docker run -p 5000:5000 -d --restart=always in28min/todo-rest-api-h2:1.0.0.RELEASE
```
### Allocate Memory
```cmd
docker run -p 5000:5000 -d -m 512m in28min/todo-rest-api-h2:1.0.0.RELEASE
```
### Allocate CPU
```cmd
docker run -p 5000:5000 -d --cpu-quota=50000 in28min/todo-rest-api-h2:1.0.0.RELEASE
```
---
# Distributed Tracing
**Distributed Tracing** is a method used to profile and monitor applications, especially those built using a microservices architecture. <br>
![image](DevOps_images/Distributed_tracing.png)

## Zipkin
**Zipkin** is a distributed tracing system. It helps gather timing data needed to troubleshoot latency problems in service architectures. <br>
```cmd
docker run -p 9411:9411 openzipkin/zipkin:2.23
```
## Observability and OpenTelemetry

* Monitoring vs observability: Monitoring is reactive. Observability is proactive.
* Monitoring is a subset of observability.
* Observability: How well do we understand what's happening in a system?

1. Step 1: Gather data: Metrics, logs, or traces

2. Step 2: Get intelligence: AI/Ops and anomaly detection

**OpenTelemetry**: Collection of tools, APIs, and SDKs to instrument, generate, collect, & export telemetry data (metrics, logs, & traces)<br>
Almost all cloud platforms provide support for OpenTelemetry today!

### Zipkin in application.properties
```cmd
spring.zipkin.base-url=http://localhost:9411
management.tracing.sampling.probability=1.0
logging.pattern.level=%5p [${spring.application.name:},%X{traceId:-},%X{spanId:-}]
```
---
# Create Docker Images for Spring Boot Microservices

## On POM
```xml
<plugin>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-maven-plugin</artifactId>
  <configuration>
    <image>
      <name>jok98/mmv3-${project.artifactId}:${project.version}</name> <!-- dockerId/prefix -->
    </image>
    <pullPolicy>IF_NOT_PRESENT</pullPolicy> <!-- pull image if not present -->
  </configuration>
</plugin>
```
## Maven commands
```cmd
spring-boot:build-image
```

## Docker Compose
Docker compose is a tool for defining and running multi-container Docker applications.
### docker-compose.yml
```yml
version: '3.7'

services:
  currency-exchange:
    image: docker.io/jok98/mmv3-currency-exchange-service:0.0.1-SNAPSHOT
    mem_limit: 700m
    ports:
      - "8000:8000"
    networks:
      - currency-network
    depends_on:
      - naming-server
    environment:
      EUREKA.CLIENT.SERVICE-URL.DEFAULT-ZONE: http://naming-server:8761/eureka/
      MANAGEMENT.ZIPKIN.TRACING.ENDPOINT: http://zipkin-server:9411/api/v2/spans

  currency-conversion:
    image: docker.io/jok98/mmv3-currency-conversion-service:0.0.1-SNAPSHOT
    mem_limit: 700m
    ports:
      - "8100:8100"
    networks:
      - currency-network
    depends_on:
      - naming-server
    environment:
      EUREKA.CLIENT.SERVICE-URL.DEFAULT-ZONE: http://naming-server:8761/eureka/
      MANAGEMENT.ZIPKIN.TRACING.ENDPOINT: http://zipkin-server:9411/api/v2/spans

  api-gateway:
    image: docker.io/jok98/mmv3-api-gateway:0.0.1-SNAPSHOT
    mem_limit: 700m
    ports:
      - "8765:8675"
    networks:
      - currency-network
    depends_on:
      - naming-server
    environment:
      EUREKA.CLIENT.SERVICE-URL.DEFAULT-ZONE: http://naming-server:8761/eureka/
      MANAGEMENT.ZIPKIN.TRACING.ENDPOINT: http://zipkin-server:9411/api/v2/spans

  zipkin-server:
    image: openzipkin/zipkin:2.23
    mem_limit: 300m
    ports:
      - "9411:9411"
    networks:
      - currency-network
    restart: always #Restart if there is a problem starting up

  naming-server:
    image: docker.io/jok98/mmv3-naming-server:0.0.1-SNAPSHOT
    mem_limit: 700m
    ports:
      - "8761:8761"
    networks:
      - currency-network

networks:
  currency-network:
```