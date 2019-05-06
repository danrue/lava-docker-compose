# Using LAVA with Docker Compose

This repository attempts to provide a reference implementation of deploying
LAVA using its [officially distributed docker
containers](https://master.lavasoftware.org/static/docs/v2/docker-admin.html#official-lava-software-docker-images).

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

## Upgrades

1. `docker-compose down`
2. Back up pgsql from its docker volume

```
    sudo tar cvzf lava-server-pgdata-$(date +%Y%m%d).tgz /var/lib/docker/volumes/lava-server-pgdata
```

3. Change e.g. `lavasoftware/lava-server:2019.03` to
`lavasoftware/lava-server:2019.04` and
`lavasoftware/lava-dispatcher:2019.03` to
`lavasoftware/lava-dispatcher:2019.04` in docker-compose.yml.
4. `docker-compose up`

### 2019.03 to 2019.04

This upgrade changed the uid and gid of the lava user in the container to
200:200. After upgrading, run the following command to chown
/var/lib/lava-server accordingly:

```
$ docker-compose exec server chown -R lavaserver:lavaserver /var/lib/lava-server/
```

## Design

The design goal of this repository is to demonstrate how to use the official
LAVA docker containers in a native way. Ideally, this means without having to
rebuild or modify the containers in any way. In the events that the containers
or their entrypoints do need modifications, patches should be [pushed
upstream](https://git.lavasoftware.org/lava/pkg/docker) to provide interfaces
for the given functionality. As the official containers mature, this repository
should become more simple.

### Containers

There are 4 containers defined in [docker-compose.yml](docker-compose.yml):

#### database

This is an official postgres container, and runs using a docker volume. Using
an official postgres container is a lot easier than using the postgres that
comes with the lava-server container. This set-up makes data persistant by
default, and makes backups easy (if desired).

Note that
[./server-overlay/etc/lava-server/instance.conf](./server-overlay/etc/lava-server/instance.conf)
provides connection details to this database for lava-server.

#### squid

This is a squid container that serves as an http proxy to the LAVA dispatcher.
Its purpose is to cache downloads to a docker volume, to improve performance
and prevent duplicate downloads. This is enabled in
[./server-overlay/etc/lava-server/env.yaml](./server-overlay/etc/lava-server/env.yaml)

#### server

This is lava-server (lava master). In order to provision a qemu device
automatically, a script at
[./server-overlay/root/provision.sh](./server-overlay/root/provision.sh) is run
at boot time to add a superuser (admin/admin) and a qemu device and qemu
worker. The lava-server container's
[entrypoint.sh](server-docker/entrypoint.sh) needed to be modified to support
this functionality - a feature that could be added upstream (see discussion at
[pkg/docker
MR#10](https://git.lavasoftware.org/lava/pkg/docker/merge_requests/10) for
details).

Several other files are mounted into the container.
[settings.conf](server-overlay/etc/lava-server/settings.conf) is provided, as
well as device and health-check directories.

#### dispatcher

The lava dispatcher is run using the official container directly. However, to
use an actual board container modifications would have to be made in a similar
way as they were made to lava-server. See the beaglebone-black branch for an
example implemention of a beaglebone-black.

