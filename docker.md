# Docker

## Commands

Command | Description
- | -
`docker build .` | Build image with Dockerfile in local directory
`docker exec -it <container name> /bin/bash` |
`docker ps -a` | View all containers
`docker images` | View all images
`docker pull registry.lieferheld-staging.rz01.deposit-solutions.com/mysql/comonea_b2c` |
`docker run -dP registry.lieferheld-staging.rz01.deposit-solutions.com/mysql/comonea_b2c` |
`docker run -it --net host registry.lieferheld-staging.rz01.deposit-solutions.com/tenant/ds-comonea-product:master` | Run container in the local network with an interactive terminal (responds to Ctrl+C)
`docker stop $(docker ps -aq) && docker rm $(docker ps -aq)` | Stop and remove all containers
`docker network rm $(docker network ls -fdriver=bridge -q)` | Remove all networks of type `bridge`
`docker ps | grep "docker-mariadb:1.0.1" | awk '{ print $1 }'` | Filtering example

## Notes

https://github.com/docker/docker/issues/27381
Enabling moutflags=slave as well as enabling deferred removal and deletion have fixed this issue for me. Now I'm hitting this race condition bug: #23418