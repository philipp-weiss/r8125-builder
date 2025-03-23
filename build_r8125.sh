#!/bin/bash

podman build -t build_r8125 .
podman create --name r8125 build_r8125
podman cp r8125:/lib/modules/6.8.12-4-pve/updates/dkms/r8125.ko output/
podman rm -f r8125