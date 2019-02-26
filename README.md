# Using LAVA with Docker

This repository attempts to provide a reference implementation of deploying
LAVA using its officially distributed docker containers.

## Requirements

Install the following.
- [Docker](https://docs.docker.com/install/)
- [docker-compose](https://docs.docker.com/compose/install/)

## Configuration


## Usage

`make`: Deploy a pgsql container, lava server container, lava dispatcher
container, and image host container. A user (username admin, password admin)
will automatically be deployed, as well as a qemu device-type and a qemu-01
device. Its health check should run automatically.

`make clean`: Permanently delete the containers and the pgsql volume.

Once up, go to your http://your-IP (port 80) and log in with admin:admin.

## Upgrades

1. Stop containers.
2. Back up pgsql from its docker volume

    sudo tar cvzf lava-server-pgdata-$(date +%Y%m%d).tgz /var/lib/docker/volumes/lava-server-pgdata

3. Change e.g. `lavasoftware/amd64-lava-server:2018.11` to
`lavasoftware/amd64-lava-server:2019.01` and
`lavasoftware/amd64-lava-dispatcher:2018.11` to
`lavasoftware/amd64-lava-dispatcher:2019.01` in docker-compose.yml.
4. Change the FROM line if any containers are being rebuilt, such as
[./server-docker/Dockerfile](./server-docker/Dockerfile)
5. Start containers.


## Useful Commands

Spy on the serial port:

    docker-compose exec dispatcher telnet ser2net 5001

