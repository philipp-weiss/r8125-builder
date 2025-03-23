FROM debian:bookworm
MAINTAINER weph philipp.weiss@web.de
USER root

RUN apt update
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt install -y \
    wget \
    dkms

ARG PROXMOX_REPO="http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/"
ARG PROXMOX_HEADERS="proxmox-headers-6.8.12-4-pve_6.8.12-4_amd64.deb"
ARG PROXMOX_R8125="r8125-dkms_9.013.02-1~bpo12+1_all.deb"
RUN wget ${PROXMOX_REPO}${PROXMOX_HEADERS} && dpkg -i ${PROXMOX_HEADERS} 
RUN wget ${PROXMOX_REPO}${PROXMOX_R8125} && dpkg -i ${PROXMOX_R8125} 
