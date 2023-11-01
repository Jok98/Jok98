# MATTEO MOI
---
# Microservices w/ Spring Boot
### TOC
[//]: # (TOC generated with https://ecotrust-canada.github.io/markdown-toc/)
* [Microservices w/ Spring Boot](#microservices-w-spring-boot)
  * [Definition](#definition)
  * [Microservices are based on](#microservices-are-based-on)
  * [Advantages of microservices](#advantages-of-microservices)
* [Spring Cloud](#spring-cloud)
  * [Spring Cloud is composed by :](#spring-cloud-is-composed-by)
  * [Dynamic scale up and down of services](#dynamic-scale-up-and-down-of-services)


## Definition
- **Microservice architecture is an approach to developing a single application as a suite of small services,<br>**
**each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API.<br>**
- **These services are built around business capabilities and independently deployable by fully automated deployment machinery<br>**
- **There is a bare minimum of centralized management of these services, which may be written in different P.L. and use different data storage technologies<br>**

## Microservices are based on
- **RESTfull services**
- **Small and well chosen deployable units**
- **Cloud enable : create and delete istance of a specific microservice without huge problems**
- **Decentralized architecture**

## Advantages of microservices
- **Technology heterogeneity** : Each microservice can be developed with a different technology
- **Resilience** : If a microservice fails, the other microservices are not affected
- **Scaling** : Each microservice can be scaled independently
- **Ease of deployment** : Each microservice is deployed independently
- **Organizational alignment** : Microservices are aligned with the organizational structure of the company
- **Optimizing for scalability** : Microservices can be scaled independently
- **Optimizing for replaceability** : Microservices can be replaced with a rewrite
- **Optimizing for evolvability** : Microservices can evolve independently
- **Optimizing for testability** : Microservices can be tested independently
- **Optimizing for debuggability** : Microservices can be debugged independently
- **Optimizing for deployability** : Microservices can be deployed independently
- **Optimizing for replaceability** : Microservices can be replaced with a rewrite
- **Optimizing for organizational agility** : Microservices can be developed by different teams
---
# Spring Cloud
### Spring Cloud is a framework that provides a variety of features to support the development of microservices :
- **Service discovery**
- **Circuit breakers**
- **Routing**
- **Load balancing**
- **Global locks**
- **Configuration management**
- **Authentication and authorization**
- **Metrics and monitoring**
- **Distributed sessions**
- **Cluster state**

## Spring Cloud is composed by

[//]: # (make a list of all the projects starting from the most know and used that compose Spring Cloud ad associate a link to the official documentation and a short description of the project)
- **Spring Cloud Config** : https://cloud.spring.io/spring-cloud-config/ <br>   **Configuration management** : Centralized external configuration management backed by a git repository
- **Spring Cloud Netflix** : https://cloud.spring.io/spring-cloud-netflix/ <br>   **Service discovery** : Service discovery with Netflix Eureka and client side loadbalancing with Ribbon and Feign
- **Spring Cloud AWS** : https://cloud.spring.io/spring-cloud-aws/ <br>   **Cloud platform support** : Support for AWS services such as S3, SQS, SNS, DynamoDB, SES, SSM, ACM, ElastiCache, CloudWatch, Kinesis, and CloudFormation with Spring Cloud AWS
- **Spring Cloud Kubernetes** : https://cloud.spring.io/spring-cloud-kubernetes/ <br>   **Cloud platform support** : Support for Kubernetes with Spring Cloud Kubernetes and Kubernetes native Spring Boot integrations
- **Spring Cloud Bus** : https://cloud.spring.io/spring-cloud-bus/ <br>   **Configuration management** : Event bus for propagating state changes (e.g. configuration changes) across nodes
- **Spring Cloud Security** : https://cloud.spring.io/spring-cloud-security/ <br>   **Authentication and authorization** : Security features backed by Spring Security
- **Spring Cloud Sleuth** : https://cloud.spring.io/spring-cloud-sleuth/ <br>   **Metrics and monitoring** : Distributed tracing via logs with Zipkin and Sleuth
- **Spring Cloud Stream** : https://cloud.spring.io/spring-cloud-stream/ <br>   **Messaging** : Messaging microservices with Redis, Rabbit or Kafka as the broker and support for Spring Integration and Spring Batch for event-driven microservices orchestration
- **Spring Cloud Task** : https://cloud.spring.io/spring-cloud-task/ <br>   **Batch processing** : Short-lived microservices with Spring Batch as the underlying batch processing framework and Spring Integration for event-driven microservices orchestration
- **Spring Cloud Zookeeper** : https://cloud.spring.io/spring-cloud-zookeeper/ <br>   **Service discovery** : Service discovery with Apache Zookeeper and client side loadbalancing with Ribbon and Feign
- **Spring Cloud Consul** : https://cloud.spring.io/spring-cloud-consul/ <br>   **Service discovery** : Service discovery with Consul and client side loadbalancing with Ribbon and Feign
- **Spring Cloud Contract** : https://cloud.spring.io/spring-cloud-contract/ <br>   **Testing** : Consumer Driven Contracts testing with Spring Cloud Contract Verifier and Stub Runner modules and Pact support for HTTP based messaging systems
- **Spring Cloud Function** : https://cloud.spring.io/spring-cloud-function/ <br>   **Programming model** : Support for writing functions as Spring beans and running them locally or in the cloud via Spring Cloud Function
- **Spring Cloud Gateway** : https://cloud.spring.io/spring-cloud-gateway/ <br>   **Routing** : Gateway service with support for Websockets, HTTP routing and a range of filters such as rate limiting, circuit breakers, request caching and others
- **Spring Cloud OpenFeign** : https://cloud.spring.io/spring-cloud-openfeign/ <br>   **Service discovery** : Declarative REST client with support for Feign annotations and Netflix Ribbon as the client side loadbalancer and Eureka as the service registry and discovery module
- **Spring Cloud Pipelines** : https://cloud.spring.io/spring-cloud-pipelines/ <br>   **Continuous delivery** : Deployment pipeline DSL for deploying applications to Cloud Foundry, Kubernetes or AWS with Spinnaker and Jenkins as the underlying CI/CD platform and Concourse as the alternative CI/CD platform

---

## Dynamic scale up and down of services
- **Naming server : Eureka** -> Service discovery and registration of microservices
- **Client side load balancing** :  Ribbon -> Load balancing between microservices
- **Client side service discovery : Feign** -> Declarative REST client

## Visibility and monitoring of microservices
- **Zipkin** -> Distributed tracing system
- **Netflix API Gateway** -> Routing and filtering
- **Hystrix** -> Fault tolerance between microservices
- **Hystrix Dashboard** -> Monitor Hystrix metrics in real time
- **Prometheus** -> Monitoring system and time series database

## Spring Cloud Config
[//]: # (Explain in details with a text and not only with lists how to use Spring Cloud Config to manage the configuration of microservices)
Is a framework for externalizing configuration properties into a remote repository. <br>
Provides server and client-side support for externalized configuration in a distributed system. <br>
With the Config Server you have a central place to manage external properties for applications across all environments. <br>
The concepts on both client and server map identically to the Spring Environment and PropertySource abstractions, so they fit very well with Spring applications but can be used with any application running in any language. <br>
As an application moves through the deployment pipeline from dev to test and into production you can manage the configuration between those environments and be certain that applications have everything they need to run when they migrate. <br>
The default implementation of the server storage backend uses git so it easily supports labelled versions of configuration environments as well as being accessible to a wide range of tooling for managing the content. <br>
It is easy to add alternative implementations and plug them in with Spring configuration. <br>
Out of the box the server is REST based with lightweight semantics. <br>
It is easy to customize the server to handle different content types and use alternative transports. <br>
On the client side, the config client library provides Spring @Configuration style binding from external properties sources into Java beans. <br>
It also provides support for Spring Environment and PropertySource abstractions. <br>
The goal of the Config Server and Config Client is to provide a central place for managing external properties for applications across all environments. <br>

### On the server side
- **Add the dependency** : spring-cloud-config-server
```properties
spring.application.name=spring-cloud-config-server
server.port=8888
spring.cloud.config.server.git.uri=file:///C:/Users/jokmo/IdeaProjects/Microservices/git-localconfig-repo
```
- **Add the annotation** : @EnableConfigServer
```java
@EnableConfigServer // This annotation enables the Spring Cloud Config Server
@SpringBootApplication
public class SpringCloudConfigServerApplication {
```
- **Create the file** : limits-service.properties
```properties
limits-service.minimum=4
limits-service.maximum=996
```
For each environment you can create a specific file with the name of the microservice and the name of the environment. <br>
- **Create the file** : limits-service-dev.properties
```properties
limits-service.minimum=5
limits-service.maximum=997
```
### On URL
http://localhost:8888/limits-service/default or http://localhost:8888/limits-service/dev
```json
{
  "name": "limits-service",
  "profiles": [
    "default"
  ],
  "label": null,
  "version": "a07d4634b290375f8d2215e0b76350f434f4650c",
  "state": null,
  "propertySources": [
    {
      "name": "file:///C:/Users/jokmo/IdeaProjects/Microservices/git-localconfig-repo/limits-service.properties",
      "source": {
        "limits-service.minimum": "4",
        "limits-service.maximum": "996"
      }
    }
  ]
}
```
### On the client side
#### On POM
- **Add the dependency** : spring-cloud-starter-config
```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
    <version>2.2.2.RELEASE</version>
</dependency>
```
#### On Propreties
```properties
spring.application.name=limits-service
spring.cloud.config.import=optional:configserver:http://localhost:8888
```
For use a specific environment you can add a specific profile in the properties file. <br>
```properties
spring.profiles.active=dev
spring.cloud.config.profile=dev
```
#### On URL
http://localhost:8080/limits
```json
{
  "minimum": 4,
  "maximum": 996
}
```