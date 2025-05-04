FROM debian:bookworm
LABEL maintainer="weph philipp.weiss@web.de"
USER root

RUN apt update
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt install -y \
    wget \
    dkms

ARG PROXMOX_REPO="http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/"
ARG PROXMOX_R8125="r8125-dkms_9.013.02-1~bpo12+1_all.deb"

COPY kernel_version.env /tmp/
RUN . /tmp/kernel_version.env && \
    export PROXMOX_HEADERS="proxmox-headers-${KERNEL_VERSION}-pve_${KERNEL_VERSION}_amd64.deb" && \
    wget ${PROXMOX_REPO}${PROXMOX_HEADERS} && dpkg -i ${PROXMOX_HEADERS} && \
    wget ${PROXMOX_REPO}${PROXMOX_R8125} && dpkg -i ${PROXMOX_R8125}
