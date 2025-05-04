#!/bin/bash

# Load the kernel version from the environment file
source kernel_version.env

podman build -t build_r8125 .
podman create --name r8125 build_r8125
podman cp r8125:/lib/modules/${KERNEL_VERSION}-pve/updates/dkms/r8125.ko output/
podman rm -f r8125