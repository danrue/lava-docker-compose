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


apt-get install nfs-kernel-server tftpd-hpa
sudo mkdir /etc/exports.d
cp lava-dispatcher-nfs.exports into /etc/exports.d/
sudo mkdir -p /var/lib/lava/dispatcher/tmp

edit /usr/lib/python3/dist-packages/lava_dispatcher/actions/boot/__init__.py and set self.interrupt_newline = False
