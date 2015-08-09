FROM phusion/baseimage:0.9.16
MAINTAINER J.R. Arseneau <http://github.com/jrarseneau/>

# This Docker is heavily based off of this excellent repo:
#    https://github.com/jimeh/docker-znc

# Set some variables (inc. nzbget version)
ENV LANG en_US.UTF-8
ENV VERSION 14.1

RUN locale-gen $LANG

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# We use a bootstrap script to avoid having temporary cache files and build
# dependencies being committed and included into the docker image.
ADD     install.sh /tmp/
RUN     chmod +x /tmp/install.sh
RUN     /tmp/install.sh

RUN     useradd znc
ADD     init/ /etc/my_init.d/
RUN     mkdir /etc/service/znc
ADD     start-znc /etc/service/znc/run
ADD     znc.conf.default /src/
RUN     chmod 664 /src/znc.conf.default

EXPOSE  6667
VOLUME  /config

CMD     ["/sbin/my_init"]
