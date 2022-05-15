############################################################
# Dockerfile to build V8  container images
# Based on Ubuntu
############################################################
# Set the base image to Ubuntu
FROM ubuntu:18.04
# File Author / Maintainer
LABEL cc.wuyifei.v8build.android.image.authors="wuyifei.cc@gmail.com"
################## BEGIN INSTALLATION ######################
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

# Update depedency of V8
RUN apt-get update && apt-get install -y \
	git \
	curl \
	wget \
	python \
	lsb-core \
	sudo \
	pkg-config \
	zip	\
	vim \
	apt-utils

RUN useradd -rm -d /home/docker -s /bin/bash -g root -G sudo -u 1000 docker
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER docker

WORKDIR /home/docker
# Get depot_tool
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH /home/docker/depot_tools:"$PATH"
# Fetch V8 code
RUN fetch v8
RUN echo "target_os= ['android']">>.gclient
# Update V8 depedency
WORKDIR /home/docker/v8
# checkout required V8 Branch
RUN git checkout 8.2.297.3
RUN gclient sync -D

WORKDIR /home/docker/v8/build
COPY build.diff build.diff
RUN git apply build.diff && rm build.diff

WORKDIR /home/docker/v8
RUN ./build/install-build-deps-android.sh
# End of docker Command
