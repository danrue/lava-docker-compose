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

Once up, go to your http://localhost (port 80) and log in with admin:admin. You
should see qemu-01's health-check running and it should finish successfully.

## Design

The design goal of this repository is to demonstrate how to use the official
LAVA docker containers in a native way. Ideally, this means without having to
rebuild or modify the containers in any way. In the events that the containers
or their entrypoints do need modifications, patches should be [pushed
upstream](https://git.lavasoftware.org/lava/pkg/docker) to provide interfaces
for the given functionality. As the official containers mature, this repository
should become more simple.

### Containers

There are 4 containers defined in `docker-compose.yaml`:

#### database

This is an official postgres container, and runs using a docker volume. Using
an official postgres container is a lot easier than using the postgres that
comes with the lava-server container. This set-up makes data persistant by
default, and makes backups easy (if desired).

Note that `./server-overlay/etc/lava-server` provides connection details to
this database for lava-server.

#### server

This is lava-server (lava master). In order to provision a qemu device
automatically, a script at `./server-overlay/root/provision.sh` is run at boot
time to add a superuser (admin/admin) and a qemu device and qemu worker. The
lava-server container's `entrypoint.sh` needed to be modified to support this
functionality - a feature that could be added upstream (see discussion at
https://git.lavasoftware.org/lava/pkg/docker/merge_requests/10 for details).

Several other files are mounted into the container. `settings.conf` is
provided, as well as device and health-check directories.

#### dispatcher

The lava dispatcher is run using the official container directly. However, to
use an actual board container modifications would have to be made in a similar
way as they were made to lava-server. See the lava.therub.org branch for an
example implemention of a beaglebone-black.

#### images

This is an nginx container that serves the `./images` directory. It is used to
cache the image files necessary for health checks. The `Makefile` has a rule to
fetch these files initially.

## Troubleshooting

