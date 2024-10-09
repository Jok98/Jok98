# Docker

Docker is a platform for developing, shipping, and running applications inside containers.
Containers are lightweight, portable units that package an application along with its dependencies,
allowing it to run consistently across different computing environments.

## Commands

| Command                                                 | Description                                                       |
|---------------------------------------------------------|-------------------------------------------------------------------|
| `docker --version`                                      | Check the installed version of Docker.                            |
| `docker pull <image>`                                   | Pull an image from Docker Hub.                                    |
| `docker build -t <image-name> <path>`                   | Build a Docker image from a Dockerfile.                           |
| `docker images`                                         | List all available Docker images on your system.                  |
| `docker run <image>`                                    | Run a container from the specified image.                         |
| `docker run -d -p <host-port>:<container-port> <image>` | Run a container in detached mode and map ports.                   |
| `docker ps`                                             | List all running containers.                                      |
| `docker ps -a`                                          | List all containers (including stopped ones).                     |
| `docker stop <container-id>`                            | Stop a running container.                                         |
| `docker start <container-id>`                           | Start a stopped container.                                        |
| `docker restart <container-id>`                         | Restart a container.                                              |
| `docker rm <container-id>`                              | Remove a container.                                               |
| `docker rmi <image-id>`                                 | Remove an image.                                                  |
| `docker exec -it <container-id> /bin/bash`              | Access a running container's terminal.                            |
| `docker login`                                          | Log in to Docker Hub.                                             |
| `docker push <username>/<image>`                        | Push an image to Docker Hub.                                      |
| `docker network create <network-name>`                  | Create a custom Docker network.                                   |
| `docker volume create <volume-name>`                    | Create a Docker volume.                                           |
| `docker-compose up`                                     | Create and start containers defined in a docker-compose.yml file. |
| `docker-compose down`                                   | Stop and remove containers defined in a docker-compose.yml file.  |

## Components
- **DockerFile :** is a text file that contains instructions to build a Docker image.
- **Image :** is a package (set of bytes) representing specific version of the app. Is downloaded from Docker Hub by default if it is not available locally.
- **Container :** is a running instance of a Docker image.
  - **Host-port :** is the exposed port on the host machine.
  - **Container-port :** is the port on which the application is running inside the container.
- **Registry :** is a collection of repositories of Docker images.
- 
## Advatages

- **Isolation**: Containers run in isolation and do not interfere with each other.
- **Portability**: Containers can run on any machine that has Docker installed.
- **Standardization**: Docker provides a standard way to package applications and their dependencies.


## Dockerfile

```dockerfile
# First stage: Build the application
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

# Second stage: Run the application
FROM zulu-openjdk:17
VOLUME /tmp
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]
```

- `FROM` : specifies the base image.
- `WORKDIR` : sets the working directory inside the container.
- `COPY` : copies the build project to the container. COPY source destination
- `RUN` : executes a command inside the container.
- `VOLUME` : creates a mount point for a volume.
- `EXPOSE` : exposes a port on which the application is running.
- `ENTRYPOINT` : specifies the command to run when the container starts.


### Layer Caching

```dockerfile
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /home/app
# Copy the pom.xml file to cache the dependencies
COPY ./pom.xml /home/app/pom.xml
RUN mvn -f /home/app/pom.xml clean package

# Copy the source code to build the application
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM zulu-openjdk:17
VOLUME /tmp
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]
```
### Example Console Logs

```cmd
Sending build context to Docker daemon  79.36MB
Step 1/10 : FROM maven:3.8.1-openjdk-11-slim AS build
 ---> 1a2b3c4d5e6f
Step 2/10 : WORKDIR /home/app
 ---> Using cache
 ---> 7a8b9c0d1e2f
Step 3/10 : COPY ./pom.xml /home/app/pom.xml
 ---> Using cache
 ---> 3c4d5e6f7a8b
Step 4/10 : RUN mvn -f /home/app/pom.xml clean package
```

### Create an Image with Spring Boot
It will create a very efficient image with a minimal OS layer and only the necessary dependencies.
```cmd
spring-boot:build-image
```
