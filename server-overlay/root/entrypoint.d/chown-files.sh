#!/bin/sh

# lava-server's entrypoint requires that some files are owned by lavaserver
# https://git.lavasoftware.org/lava/pkg/docker/merge_requests/42

set -ex

for path in /etc/lava-server/dispatcher-config/ /var/lib/lava-server/default/media/; do
    if [ -d "${path}" ]; then
        chown --recursive --verbose lavaserver:lavaserver "${path}"

    fi
done
