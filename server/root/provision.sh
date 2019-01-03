#!/bin/sh

# Idempotentally provision users and devices in lava

set -ex

lava-server manage users list | grep -q drue || \
    lava-server manage users add --staff --superuser --email dan.rue@linaro.org --passwd foo drue

