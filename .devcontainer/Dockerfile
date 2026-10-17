# Thin layer on top of the published C3Dev image that adds packages the base
# image does not ship. Rebuild the container after changing this file:
# "Dev Containers: Rebuild Container".
ARG BASE_IMAGE=brakmic/c3dev:latest
FROM ${BASE_IMAGE}

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openssh-client \
        libmicrohttpd-dev \
    && rm -rf /var/lib/apt/lists/*

USER c3dev
