FROM ubuntu:14.04

RUN echo "deb http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu trusty main" \
> /etc/apt/sources.list.d/ubuntu-wine.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0 && \
dpkg --add-architecture i386 && \
apt-get update && DEBIAN_FRONTEND=noninteractive \
apt-get -y install wine1.7:i386 \
&& \
DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
DEBIAN_FRONTEND=noninteractive apt-get -y clean && \
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN useradd -u 1000 -g users -G sudo -s /bin/bash -MN dev && \
echo dev:dev | chpasswd && \
cp -R /etc/skel/. /home/dev && \
chown -R dev:users /home/dev

USER dev
