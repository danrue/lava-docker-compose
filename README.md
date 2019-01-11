# Using LAVA with Docker

This repository attempts to provide a reference implementation of deploying
LAVA using its officially distributed docker containers.

## Requirements

Install the following.
- [Docker](https://docs.docker.com/install/)
- [docker-compose](https://docs.docker.com/compose/install/)

## Configuration

No configuration should be necessary when running a simple qemu worker.

## Usage

`make`: Deploy a pgsql container, lava server container, lava dispatcher
container, and image host container. A user (username admin, password admin)
will automatically be deployed, as well as a qemu device-type and a qemu-01
device. Its health check should run automatically.

`make clean`: Permanently delete the containers and the pgsql volume.

Once up, go to your http://localhost (port 80) and log in with admin:admin.

## Troubleshooting

