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



