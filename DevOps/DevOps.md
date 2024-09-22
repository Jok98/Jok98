
# DevOps
**Matteo Moi**

## Table of Contents

1. [`Docker`](#docker)
   - [How to set up an environment with Docker]()
       - [Create a Dockerfile](#create-a-dockerfile)
       - [Build the Docker Image](#build-the-docker-image)
       - [Run the Docker Container](#run-the-docker-container)
       - [Docker Compose for Multi-Container Setup](#docker-compose-for-multi-container-setup)

2. `In Progress`


## Docker
**Definition**: Docker is a platform that allows developers to package applications into containers—standardized units of software that include everything the application needs to run. A container is actually a process in a Linux host that uses Linux namespaces to provide isolation between different containers.

### How to set up an environment with Docker

#### Create a Dockerfile
```dockerfile
# Use a base image with Java
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file from the target directory to the container
COPY target/myapp-0.0.1-SNAPSHOT.jar /app/myapp.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
```

Build the Docker Image
```bash
docker build -t myapp:latest .
```

Run the Docker Container
```bash
docker run -p 8080:8080 myapp:latest
```
Access the application at: `http://localhost:8080`

#### Docker Compose for Multi-Container Setup
Docker Compose allows you to define and run multi-container Docker applications using a `docker-compose.yml` file.

```yaml
version: '3'

services:
  service1:
    image: service1:latest
    build:
      context: ./service1
    ports:
      - "8081:8080"
    networks:
      - microservices-network

  service2:
    image: service2:latest
    build:
      context: ./service2
    ports:
      - "8082:8080"
    networks:
      - microservices-network

networks:
  microservices-network:
    driver: bridge
```

- **services**: Defines the microservices and their configurations.
- **image**: Specifies the image for each service.
- **build**: Defines the build context for each service (the directory containing the Dockerfile).
- **ports**: Maps the container ports to the host machine.
- **networks**: Creates an isolated network for the microservices to communicate with each other.

To start all the services:
```bash
docker-compose up --build
```

## in progress...
