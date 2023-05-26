FROM ubuntu:18.04
MAINTAINER kevleyski

# Pull in build cross compiler tool dependencies using Advanced Package Tool
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Sydney

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get --fix-missing -y install tzdata zip build-essential autoconf bison python vim git \
    && apt-get clean
WORKDIR /opt
COPY bash2py-3.6.zip /opt
RUN unzip /opt/bash2py-3.6.zip 
WORKDIR /opt/bash2py-3.6
RUN mkdir /root/bin
RUN sh install
CMD /bin/bash
