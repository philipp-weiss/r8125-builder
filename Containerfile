FROM debian:bookworm
LABEL maintainer="weph philipp.weiss@web.de"
USER root

RUN apt update
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt install -y \
    wget \
    dkms

ARG ENV_FILE
RUN echo "$ENV_FILE"
COPY ${ENV_FILE} /tmp/
RUN . /tmp/${ENV_FILE} && \
    wget ${HEADERS} && dpkg -i $(basename ${HEADERS}) && \
    wget ${R8125} && dpkg -i $(basename ${R8125})
