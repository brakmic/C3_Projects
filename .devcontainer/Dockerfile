# Thin layer on top of the published C3Dev image that adds packages the base
# image does not ship. The digest pins the verified image; bump it deliberately.
# Rebuild the container after changing this file:
# "Dev Containers: Rebuild Container".
ARG BASE_IMAGE=brakmic/c3dev@sha256:0c48cd8e0ef0333142c01a6b433b2839084fabe141cabd0db4dbb16981598626
FROM ${BASE_IMAGE}

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openssh-client \
        libmicrohttpd-dev \
    && rm -rf /var/lib/apt/lists/*

USER c3dev
