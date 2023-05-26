FROM debian
#ubuntu:18.04
MAINTAINER kevleyski

# Pull in build cross compiler tool dependencies using Advanced Package Tool
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Sydney

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get --fix-missing -y install tzdata zip build-essential autoconf bison python vim git strace gdb \
    && apt-get clean
WORKDIR /
ADD . /
RUN sh install
CMD /bin/bash
